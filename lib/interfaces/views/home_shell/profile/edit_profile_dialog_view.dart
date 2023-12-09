import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:root_lib/common/constants.dart';
import 'package:root_lib/core/entities/auth/editable_user.dart';
import 'package:root_lib/core/entities/auth/school_detail.dart';
import 'package:root_lib/core/entities/auth/user.dart';
import 'package:root_lib/infrastructures/services/remote/api/errors/common_response_exception.dart';
import 'package:root_lib/interfaces/providers/res/user_cache_cubit.dart';
import 'package:root_lib/interfaces/router/routes/routes.dart';
import 'package:root_lib/interfaces/utils/app_form_validators.dart';

import 'profile_view.dart';

class EditProfileDialogView extends StatelessWidget {
  const EditProfileDialogView({
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

class _DialogForm extends StatefulWidget {
  const _DialogForm({
    required this.email,
    required this.oldUser,
  });

  final String email;
  final EditableUser oldUser;

  @override
  State<StatefulWidget> createState() => _DialogFormState();
}

class _DialogFormState extends State<_DialogForm> {
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

    final userCacheAsync = context.watch<UserCacheCubit>().state;

    final isLoading = userCacheAsync.isLoading;

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

    void toProfileRoute() => const ProfileRoute().go(context);

    final userCacheCubit = context.read<UserCacheCubit>();

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
      await userCacheCubit.updateUserByEmail(
        fullname: fullnameController.text,
        gender: selectedGender,
        schoolName: schoolNameController.text,
        schoolDetail: selectedClass,
        photoUrl: 'null',
      );

      toProfileRoute();
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
