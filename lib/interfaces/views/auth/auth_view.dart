import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'package:root_lib/common/assets_paths.dart';
import 'package:root_lib/common/constants.dart';
import 'package:root_lib/interfaces/router/routes.dart';

class AuthView extends StatelessWidget {
  const AuthView({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    final textTheme = theme.textTheme;
    final textColor = textTheme.bodyMedium?.color;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: SizedBox.expand(
          child: Padding(
            padding: const EdgeInsets.all(kPaddingValue),
            child: Column(
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text('Login', style: textTheme.displaySmall),
                ),
                const SizedBox(height: kSpacerValue),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.4,
                  child: Image.asset(AssetsPaths.loginPageHeadline),
                ),
                const SizedBox(height: kSpacerValue),
                Text('Selamat Datang', style: textTheme.headlineMedium),
                Text(
                  'Selamat Datang di Aplikasi Widya Edu\n'
                  'Aplikasi Latihan dan Konsultasi Soal',
                  style: textTheme.bodyMedium?.copyWith(
                    color: textColor?.withOpacity(0.5),
                  ),
                  textAlign: TextAlign.center,
                ),
                //
                const Expanded(child: SizedBox()),
                //
                FilledButton(
                  onPressed: () => const LoginDialogRoute().go(context),
                  child: const Text('Masuk'),
                ),
                const SizedBox(height: kSpacerValue),
                Text.rich(
                  TextSpan(children: [
                    const TextSpan(text: 'Belum punya akun? '),
                    TextSpan(
                      text: 'Daftar di sini',
                      style: textTheme.bodyMedium?.copyWith(
                        color: colorScheme.primary,
                      ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () => const RegisterRoute().go(context),
                    ),
                  ]),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
