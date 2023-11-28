import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:edspert_fl_adv/common/constants.dart';
import 'package:edspert_fl_adv/core/entities/school_detail.dart';
import 'package:edspert_fl_adv/core/entities/user.dart';
import 'package:edspert_fl_adv/infrastructures/api/errors/common_response_exception.dart';
import 'package:edspert_fl_adv/interfaces/providers/user_cache_provider.dart';
import 'package:edspert_fl_adv/interfaces/utils/app_form_validators.dart';
import 'package:edspert_fl_adv/interfaces/widgets/text_field/outlined_text_form_field.dart';

class RegisterView extends ConsumerStatefulWidget {
  const RegisterView({super.key});

  @override
  ConsumerState<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends ConsumerState<RegisterView> {
  Gender? selectedGender;
  SchoolDetail? selectedClass;

  bool isValidateOnce = false;

  final emailController = TextEditingController();
  final fullnameController = TextEditingController();
  final schoolNameController = TextEditingController();

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

    final userCacheAsync = ref.watch(userCacheProvider);
    final userCacheNotifier = ref.read(userCacheProvider.notifier);

    final isLoading = userCacheAsync.isLoading || userCacheAsync.isRefreshing;

    return Scaffold(
      appBar: AppBar(title: const Text('Yuk isi data diri')),
      body: SizedBox.expand(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16.0).copyWith(bottom: 0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ..._inputFieldSection(
                        context,
                        title: 'Email',
                        inputField: OutlinedTextFormField(
                          controller: emailController,
                          enabled: !isLoading,
                          decoration: const InputDecoration(
                            hintText: 'username@example.com',
                          ),
                          keyboardType: TextInputType.emailAddress,
                          textInputAction: TextInputAction.next,
                          autovalidateMode: validateMode,
                          validator: AppFormValidators.email,
                        ),
                      ),
                      const SizedBox(height: 16.0),
                      ..._inputFieldSection(
                        context,
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
                      const SizedBox(height: 16.0),
                      ..._inputFieldSection(
                        context,
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
                      const SizedBox(height: 16.0),
                      ..._inputFieldSection(
                        context,
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
                      const SizedBox(height: 16.0),
                      ..._inputFieldSection(
                        context,
                        title: 'Nama Sekolah',
                        inputField: OutlinedTextFormField(
                          controller: schoolNameController,
                          enabled: !isLoading,
                          decoration: const InputDecoration(
                            hintText: 'SMA Islam Al-Azhar 12 Makassar',
                          ),
                          onEditingComplete: _onRegister(userCacheNotifier),
                          autovalidateMode: validateMode,
                          validator:
                              AppFormValidators.schoolName(selectedClass),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: FilledButton(
                onPressed: isLoading ? null : _onRegister(userCacheNotifier),
                child: const Text('Daftar'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> _inputFieldSection(
    BuildContext context, {
    String title = 'Text Field Label',
    Widget inputField = const OutlinedTextFormField(),
  }) {
    final textTheme = Theme.of(context).textTheme;

    return [
      Text(title, style: textTheme.titleLarge),
      const SizedBox(height: 8.0),
      inputField,
    ];
  }

  VoidCallback _onRegister(UserCache userCacheNotifier) {
    return () async {
      final showSnackBar = ScaffoldMessenger.of(context).showSnackBar;

      if (!_formKey.currentState!.validate()) {
        showSnackBar(const SnackBar(
          content: Text('Cek isian yang merah'),
        ));

        if (!isValidateOnce) setState(() => isValidateOnce = true);

        return;
      }

      try {
        await userCacheNotifier.registerUser(
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
    };
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
            final isMan = (gender == null) ? null : gender == Gender.male;

            final isNotValid = state.hasError;

            return Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    InputChip(
                      label: const Text('Laki-laki'),
                      selected: isMan ?? false,
                      isEnabled: enabled ? !(isMan ?? false) : enabled,
                      onSelected: (_) {
                        state.didChange(Gender.male);
                        state.save();
                      },
                    ),
                    InputChip(
                      label: const Text('Perempuan'),
                      selected: !(isMan ?? true),
                      isEnabled: enabled ? isMan ?? true : enabled,
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
