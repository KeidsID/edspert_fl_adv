import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:root_lib/common/constants.dart';
import 'package:root_lib/core/entities/auth/firebase_user.dart';
import 'package:root_lib/core/entities/auth/school_detail.dart';
import 'package:root_lib/core/entities/auth/user.dart';
import 'package:root_lib/infrastructures/services/remote/api/errors/common_response_exception.dart';
import 'package:root_lib/interfaces/providers.dart';
import 'package:root_lib/interfaces/utils/app_form_validators.dart';
import 'package:root_lib/interfaces/widgets/common/outlined_text_form_field.dart';

part '_sections/_input_field_section.dart';

class RegisterView extends StatelessWidget {
  const RegisterView({super.key, this.signedInUser});

  /// Used by form fields to set the initial value.
  final FirebaseUser? signedInUser;

  @override
  Widget build(BuildContext context) {
    final authCubit = context.watch<AuthCubit>();

    final isVerifying = !(authCubit.state.value?.isVerifiedOnce ?? false);

    if (isVerifying) return _VerifyingView(key: key);

    return _RegisterViewImpl(key: key, signedInUser: signedInUser);
  }
}

class _RegisterViewImpl extends StatefulWidget {
  const _RegisterViewImpl({super.key, this.signedInUser});

  final FirebaseUser? signedInUser;

  @override
  State<_RegisterViewImpl> createState() => _RegisterViewImplState();
}

class _RegisterViewImplState extends State<_RegisterViewImpl> {
  Gender? selectedGender;
  SchoolDetail? selectedClass;

  bool isValidateOnce = false;

  late final TextEditingController emailController;
  late final TextEditingController fullnameController;
  final schoolNameController = TextEditingController();

  @override
  void initState() {
    super.initState();

    final signedInUser = widget.signedInUser;

    emailController = TextEditingController(text: signedInUser?.email);
    fullnameController = TextEditingController(text: signedInUser?.displayName);
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
    final validateMode =
        isValidateOnce ? AutovalidateMode.onUserInteraction : null;

    final userCacheCubit = context.watch<UserCacheCubit>();

    final isLoading = userCacheCubit.state.isLoading;

    return Scaffold(
      appBar: AppBar(
        leading: BackButton(onPressed: () => userCacheCubit.logout(context)),
        title: const Text('Yuk isi data diri'),
      ),
      bottomNavigationBar: SizedBox(
        width: double.maxFinite,
        height: kToolbarHeight,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: FilledButton(
            onPressed: isLoading ? null : _onRegister,
            child: const Text('Daftar'),
          ),
        ),
      ),
      body: SizedBox.expand(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(kPaddingValue).copyWith(bottom: 0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _InputFieldSection(
                  title: 'Email',
                  inputField: OutlinedTextFormField(
                    controller: emailController,
                    enabled: false,
                    decoration: const InputDecoration(
                      hintText: 'username@example.com',
                    ),
                    keyboardType: TextInputType.emailAddress,
                    textInputAction: TextInputAction.next,
                    autovalidateMode: validateMode,
                    validator: AppFormValidators.email,
                  ),
                ),

                //
                const SizedBox(height: kSpacerValue),
                _InputFieldSection(
                  title: 'Nama Lengkap',
                  inputField: OutlinedTextFormField(
                    controller: fullnameController,
                    enabled: !isLoading,
                    decoration: const InputDecoration(hintText: 'Fulan'),
                    keyboardType: TextInputType.name,
                    // textInputAction: TextInputAction.next,
                    autovalidateMode: validateMode,
                    validator: AppFormValidators.fullname,
                  ),
                ),

                //
                const SizedBox(height: kSpacerValue),
                _InputFieldSection(
                  title: 'Jenis Kelamin',
                  inputField: _GenderFormField(
                    enabled: !isLoading,
                    onSaved: (gender) {
                      setState(() => selectedGender = gender);
                    },
                    autovalidateMode: validateMode,
                    validator: AppFormValidators.gender,
                  ),
                ),

                //
                const SizedBox(height: kSpacerValue),
                _InputFieldSection(
                  title: 'Kelas',
                  inputField: DropdownButtonFormField(
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                    ),
                    isExpanded: true,
                    hint: const Text('Pilih kelas'),
                    value: selectedClass,
                    onChanged: !isLoading
                        ? (SchoolDetail? schoolGrade) {
                            setState(() => selectedClass = schoolGrade);
                          }
                        : null,
                    items: SchoolDetail.classes
                        .map((e) =>
                            DropdownMenuItem(value: e, child: Text('$e')))
                        .toList(),
                    autovalidateMode: validateMode,
                    validator: AppFormValidators.schoolGrade,
                  ),
                ),

                //
                const SizedBox(height: kSpacerValue),
                _InputFieldSection(
                  title: 'Nama Sekolah',
                  inputField: OutlinedTextFormField(
                    controller: schoolNameController,
                    enabled: !isLoading,
                    decoration: const InputDecoration(
                      hintText: 'SMA Islam Al-Azhar 12 Makassar',
                    ),
                    onEditingComplete: _onRegister,
                    autovalidateMode: validateMode,
                    validator: AppFormValidators.schoolName(selectedClass),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _onRegister() async {
    final userCacheCubit = context.read<UserCacheCubit>();

    // prevent async gap
    final showSnackBar = ScaffoldMessenger.of(context).showSnackBar;

    if (!_formKey.currentState!.validate()) {
      showSnackBar(const SnackBar(
        content: Text('Cek isian yang merah'),
      ));

      if (!isValidateOnce) setState(() => isValidateOnce = true);

      return;
    }

    try {
      await userCacheCubit.registerUser(
        context,
        email: emailController.text,
        fullname: fullnameController.text,
        // form validated
        gender: selectedGender!,
        schoolName: schoolNameController.text,
        // form validated
        schoolDetail: selectedClass!,
        photoUrl: '',
      );
    } catch (e, trace) {
      if (e is CommonResponseException) {
        showSnackBar(SnackBar(content: Text(e.message)));

        return;
      }

      kLogger.f(
        'userCacheProvider.notifier.registerUser',
        error: e,
        stackTrace: trace,
      );

      showSnackBar(const SnackBar(
        content: Text(
          'Maaf terjadi kesalahan, silahkan coba lagi.',
        ),
      ));
    }
  }
}

class _VerifyingView extends StatelessWidget {
  const _VerifyingView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SizedBox.expand(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Verifikasi Akun',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: kSpacerValue),
              const CircularProgressIndicator(),
            ],
          ),
        ),
      ),
    );
  }
}

class _GenderFormField extends FormField<Gender?> {
  _GenderFormField({
    super.enabled,
    super.onSaved,
    super.autovalidateMode,
    super.validator,
  }) : super(
          builder: (state) {
            final gender = state.value;
            final isMan = gender == Gender.male;
            final isFemale = gender == Gender.female;

            final isNotValid = state.hasError;

            return Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    InputChip(
                      label: const Text('Laki-laki'),
                      selected: isMan,
                      isEnabled: enabled ? !isMan : enabled,
                      onSelected: (_) {
                        state.didChange(Gender.male);
                        state.save();
                      },
                    ),
                    InputChip(
                      label: const Text('Perempuan'),
                      selected: isFemale,
                      isEnabled: enabled ? !isFemale : enabled,
                      onSelected: (_) {
                        state.didChange(Gender.female);
                        state.save();
                      },
                    ),
                  ],
                ),
                ...isNotValid
                    ? [
                        const SizedBox(height: 8.0),
                        Builder(builder: (context) {
                          final theme = Theme.of(context);
                          final textTheme = Theme.of(context).textTheme;

                          return Text(
                            state.errorText!,
                            style: textTheme.labelLarge?.copyWith(
                              color: theme.colorScheme.error,
                            ),
                          );
                        }),
                      ]
                    : [const SizedBox()]
              ],
            );
          },
        );
}
