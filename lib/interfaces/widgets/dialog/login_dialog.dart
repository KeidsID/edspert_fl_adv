import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:edspert_fl_adv/common/constants.dart';
import 'package:edspert_fl_adv/infrastructures/api/errors/common_response_exception.dart';
import 'package:edspert_fl_adv/interfaces/providers/auth/user_cache_provider.dart';
import 'package:edspert_fl_adv/interfaces/utils/app_form_validators.dart';
import 'package:edspert_fl_adv/interfaces/widgets/text_field/outlined_text_form_field.dart';

class LoginDialog extends ConsumerStatefulWidget {
  const LoginDialog({super.key});

  @override
  ConsumerState<LoginDialog> createState() => _LoginDialogState();
}

class _LoginDialogState extends ConsumerState<LoginDialog> {
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
    final userCacheAsync = ref.watch(userCacheProvider);
    final userCacheNotifier = ref.read(userCacheProvider.notifier);

    final isLoading = userCacheAsync.isLoading || userCacheAsync.isRefreshing;

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
              onEditingComplete: _onLogin(userCacheNotifier),
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
          onPressed: isLoading ? null : _onLogin(userCacheNotifier),
          child: const Text('Masuk'),
        ),
      ],
    );
  }

  VoidCallback _onLogin(UserCache userCacheNotifier) {
    return () async {
      /// prevent async gap.
      Future<T?> showDialogApi<T>(WidgetBuilder builder) =>
          showDialog<T>(context: context, builder: builder);

      if (!_formKey.currentState!.validate()) {
        if (!isValidateOnce) setState(() => isValidateOnce = true);

        return;
      }

      try {
        await userCacheNotifier.loginByEmail(emailTextController.text);
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
    };
  }
}
