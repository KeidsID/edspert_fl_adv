import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'package:edspert_fl_adv/common/assets_paths.dart';
import 'package:edspert_fl_adv/interfaces/widgets/dialog/login_dialog.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    final textTheme = theme.textTheme;
    final textColor = textTheme.bodyMedium?.color;

    return Scaffold(
      body: SafeArea(
        child: SizedBox.expand(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text('Login', style: textTheme.displaySmall),
                ),
                const SizedBox(height: 16.0),
                Flexible(
                  flex: 4,
                  child: Image.asset(AssetsPaths.loginPageHeadline),
                ),
                const SizedBox(height: 16.0),
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
                  onPressed: () => showDialog(
                    context: context,
                    builder: (_) => const LoginDialog(),
                  ),
                  child: const Text('Masuk'),
                ),
                const SizedBox(height: 16.0),
                Text.rich(
                  TextSpan(children: [
                    const TextSpan(text: 'Belum punya akun? '),
                    TextSpan(
                      text: 'Daftar di sini',
                      style: textTheme.bodyMedium?.copyWith(
                        color: colorScheme.primary,
                      ),
                      recognizer: TapGestureRecognizer()
                        ..onTap =
                            () => Navigator.pushNamed(context, '/register'),
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
