import 'package:edspert_fl_adv/core/entities/editable_user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:edspert_fl_adv/common/constants.dart';
import 'package:edspert_fl_adv/core/entities/school_detail.dart';
import 'package:edspert_fl_adv/core/entities/user.dart';
import 'package:edspert_fl_adv/infrastructures/api/errors/common_response_exception.dart';
import 'package:edspert_fl_adv/interfaces/providers/user_cache_provider.dart';
import 'package:edspert_fl_adv/interfaces/utils/app_form_validators.dart';
import 'package:edspert_fl_adv/interfaces/views/home/profile_view.dart';

class EditProfileDialog extends StatelessWidget {
  const EditProfileDialog({
    super.key,
    required this.email,
    required this.editableUser,
  });

  final String email;
  final EditableUser editableUser;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Dialog.fullscreen(
      child: Column(
        children: [
          SizedBox(
            height: kToolbarHeight,
            child: AppBar(
              backgroundColor: colorScheme.primary,
              foregroundColor: colorScheme.onPrimary,
              centerTitle: true,
              title: const Text('Edit Akun'),
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(kPaddingValue),
              child: _DialogForm(
                email: email,
                oldUser: editableUser,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _DialogForm extends ConsumerStatefulWidget {
  const _DialogForm({
    required this.email,
    required this.oldUser,
  });

  final String email;
  final EditableUser oldUser;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _DialogFormState();
}

class _DialogFormState extends ConsumerState<_DialogForm> {
  bool isValidateOnce = false;

  late Gender selectedGender;
  late SchoolDetail selectedClass;
  late final TextEditingController emailController;
  late final TextEditingController fullnameController;
  late final TextEditingController schoolNameController;

  @override
  void initState() {
    super.initState();
    selectedGender = widget.oldUser.gender;
    selectedClass = widget.oldUser.schoolDetail;
    emailController = TextEditingController(text: widget.email);
    fullnameController = TextEditingController(text: widget.oldUser.name);
    schoolNameController =
        TextEditingController(text: widget.oldUser.schoolName);
  }

  @override
  void dispose() {
    emailController.dispose();
    fullnameController.dispose();
    schoolNameController.dispose();
    super.dispose();
  }

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final user = widget.oldUser;
    final validateMode =
        isValidateOnce ? AutovalidateMode.onUserInteraction : null;

    final userCacheAsync = ref.watch(userCacheProvider);

    final isLoading = userCacheAsync.isLoading || userCacheAsync.isRefreshing;

    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text('Data Diri', style: kPVCardTitleStyle(context)),
          //
          const SizedBox(height: kLargeSpacerValue),
          Text('Email', style: kPVContentTitleStyle(context)),
          TextField(controller: emailController, enabled: false),

          // fullname
          const SizedBox(height: kSpacerValue),
          Text('Nama Lengkap', style: kPVContentTitleStyle(context)),
          TextFormField(
            controller: fullnameController,
            decoration: InputDecoration(hintText: user.name),
            enabled: !isLoading,
            autovalidateMode: validateMode,
            validator: AppFormValidators.fullname,
          ),

          // gender
          const SizedBox(height: kSpacerValue),
          Text('Jenis Kelamin', style: kPVContentTitleStyle(context)),
          DropdownButtonFormField(
            items: Gender.values.map((e) {
              return DropdownMenuItem(
                value: e,
                child: Text('$e'),
              );
            }).toList(),
            onChanged: isLoading
                ? null
                : (Gender? val) => setState(() => selectedGender = val!),
            value: user.gender,
            autovalidateMode: validateMode,
            validator: AppFormValidators.gender,
          ),

          // school class
          const SizedBox(height: kSpacerValue),
          Text('Kelas', style: kPVContentTitleStyle(context)),
          DropdownButtonFormField(
            items: SchoolDetail.classes.map((e) {
              return DropdownMenuItem(
                value: e,
                child: Text('$e'),
              );
            }).toList(),
            onChanged: isLoading
                ? null
                : (SchoolDetail? val) => setState(() => selectedClass = val!),
            value: user.schoolDetail,
            autovalidateMode: validateMode,
            validator: AppFormValidators.schoolGrade,
          ),

          // school name
          const SizedBox(height: kSpacerValue),
          Text('Sekolah', style: kPVContentTitleStyle(context)),
          TextFormField(
            controller: schoolNameController,
            enabled: !isLoading,
            onEditingComplete: _onUpdate,
            autovalidateMode: validateMode,
            validator: AppFormValidators.schoolName(selectedClass),
          ),
          //
          const SizedBox(height: kSpacerValue),
          FilledButton(
            onPressed: isLoading ? null : _onUpdate,
            child: const Text('Perbarui Data'),
          ),
        ],
      ),
    );
  }

  bool get _isNoChanges {
    final oldUser = widget.oldUser;

    return oldUser.name == fullnameController.text &&
        oldUser.gender == selectedGender &&
        oldUser.schoolName == schoolNameController.text &&
        oldUser.schoolDetail == selectedClass;
  }

  void _onUpdate() async {
    Future showErrorDialog<T>(Widget title) {
      return showDialog<T>(
        context: context,
        builder: (context) => AlertDialog(
          title: title,
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Ok'),
            ),
          ],
        ),
      );
    }

    final navPop = Navigator.of(context).pop;

    final userCacheNotifier = ref.read(userCacheProvider.notifier);

    if (!_formKey.currentState!.validate()) {
      showErrorDialog(const Text('Cek isian yang merah'));

      if (!isValidateOnce) setState(() => isValidateOnce = true);

      return;
    }

    if (_isNoChanges) {
      showErrorDialog(const Text('Tidak ada perubahan data'));
      return;
    }

    try {
      await userCacheNotifier.updateUserByEmail(
        fullname: fullnameController.text,
        gender: selectedGender,
        schoolName: schoolNameController.text,
        schoolDetail: selectedClass,
        photoUrl: 'null',
      );

      navPop();
    } catch (e, trace) {
      if (e is CommonResponseException) {
        showErrorDialog(Text(e.message));

        kLogger.d('$e', error: e);

        return;
      }

      kLogger.f(
        'userCacheProvider.notifier.registerUser',
        error: e,
        stackTrace: trace,
      );

      showErrorDialog(const Text(
        'Maaf terjadi kesalahan, silahkan coba lagi.',
      ));
    }
  }
}
