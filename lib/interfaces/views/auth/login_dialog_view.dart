import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:root_lib/common/constants.dart';
import 'package:root_lib/infrastructures/api/errors/common_response_exception.dart';
import 'package:root_lib/interfaces/providers/res/user_cache_cubit.dart';
import 'package:root_lib/interfaces/utils/app_form_validators.dart';
import 'package:root_lib/interfaces/widgets/common/outlined_text_form_field.dart';

class LoginDialogView extends StatefulWidget {
  const LoginDialogView({super.key});

  @override
  State<LoginDialogView> createState() => _LoginDialogState();
}

class _LoginDialogState extends State<LoginDialogView> {
  bool isValidateOnce = false;

  final emailTextController = TextEditingController();

  @override
  void dispose() {
    emailTextController.dispose();
    super.dispose();
  }

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final userCacheCubit = context.watch<UserCacheCubit>();

    final isLoading = userCacheCubit.state.isLoading;

    return AlertDialog(
      title: const Text('Login'),
      content: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            OutlinedTextFormField(
              controller: emailTextController,
              enabled: !isLoading,
              decoration: const InputDecoration(labelText: 'Email'),
              keyboardType: TextInputType.emailAddress,
              onEditingComplete: _onLogin,
              autovalidateMode:
                  isValidateOnce ? AutovalidateMode.onUserInteraction : null,
              validator: AppFormValidators.email,
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: isLoading ? null : () => Navigator.pop(context),
          child: const Text('Batal'),
        ),
        TextButton(
          onPressed: isLoading ? null : _onLogin,
          child: const Text('Masuk'),
        ),
      ],
    );
  }

  void _onLogin() async {
    final userCacheCubit = context.read<UserCacheCubit>();

    /// prevent async gap.
    Future<T?> showDialogApi<T>(WidgetBuilder builder) =>
        showDialog<T>(context: context, builder: builder);

    if (!_formKey.currentState!.validate()) {
      if (!isValidateOnce) setState(() => isValidateOnce = true);

      return;
    }

    try {
      await userCacheCubit.loginByEmail(emailTextController.text);
    } catch (e, trace) {
      if (e is CommonResponseException) {
        showDialogApi(
          (context) => AlertDialog(
            title: Text(e.message),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Ok'),
              ),
            ],
          ),
        );

        return;
      }

      kLogger.f(
        'userCacheProvider.notifier.loginByEmail',
        error: e,
        stackTrace: trace,
      );

      showDialogApi(
        (context) => AlertDialog(
          title: const Text('Maaf terjadi kesalahan'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Ok'),
            ),
          ],
        ),
      );
    }
  }
}
