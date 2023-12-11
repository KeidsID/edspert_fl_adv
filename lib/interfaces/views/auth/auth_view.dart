import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:root_lib/common/assets_paths.dart';
import 'package:root_lib/common/constants.dart';
import 'package:root_lib/interfaces/providers.dart';

class AuthView extends StatelessWidget {
  const AuthView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: SizedBox.expand(
          child: Builder(builder: (context) {
            final firebaseUserCubit = context.watch<FirebaseUserCubit>();
            final firbaseUserAsync = firebaseUserCubit.state;

            if (!firbaseUserAsync.hasValue && !firbaseUserAsync.isError) {
              return _SplashView(key: key);
            }

            return _LoginView(key: key);
          }),
        ),
      ),
    );
  }
}

class _LoginView extends StatelessWidget {
  const _LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final textTheme = theme.textTheme;
    final textColor = textTheme.bodyMedium?.color;

    return Padding(
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
          Builder(builder: (context) {
            final firebaseUserCubit = context.watch<FirebaseUserCubit>();
            final isLoading = firebaseUserCubit.state.isLoading;

            return ElevatedButton(
              onPressed: isLoading
                  ? null
                  : () async {
                      final showSnackBar =
                          ScaffoldMessenger.of(context).showSnackBar;

                      try {
                        await firebaseUserCubit.fetch();
                      } catch (e, trace) {
                        kLogger.f(
                          'Google Sign In Error',
                          error: e,
                          stackTrace: trace,
                        );

                        showSnackBar(const SnackBar(
                          content: Text('Google Login Gagal'),
                        ));
                      }
                    },
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    height: 32.0,
                    child: Image.asset(AssetsPaths.googleIcon),
                  ),
                  const SizedBox(width: kSpacerValue),
                  const Text('Masuk dengan Google'),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }
}

class _SplashView extends StatelessWidget {
  const _SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xff3a7fd5),
      child: Center(
        child: SizedBox(
          height: MediaQuery.of(context).size.height * 0.05,
          child: Image.asset(AssetsPaths.edspertLong),
        ),
      ),
    );
  }
}
