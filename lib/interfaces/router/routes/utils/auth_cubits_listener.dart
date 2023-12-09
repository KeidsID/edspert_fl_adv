import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'package:root_lib/common/constants.dart';
import 'package:root_lib/interfaces/providers.dart';
import 'package:root_lib/interfaces/providers/utils/future_cubit.dart';

/// [AuthCubit] listener is the one that triggers the router redirect.
///
/// Wrap this on each root routes located in
/// `lib/intefaces/router/routes/routes.dart`.
Widget authCubitsListener({required Widget child}) {
  return MultiBlocListener(
    listeners: [
      /// When signed in, verify the signed in user. If the user registered, then
      /// login the user in [UserCacheCubit].
      BlocListener<AuthCubit, AuthCubitState>(
        listenWhen: (_, state) => !state.isLoading && state.hasValue,
        listener: (context, state) async {
          GoRouter.maybeOf(context)?.refresh(); // trigger router redirect.

          if (state.isLoading) return;

          final authValue = state.requireValue;
          final isSignedIn = authValue.isSignedIn;
          final isRegistered = authValue.isRegistered;
          final isVerifiedOnce = authValue.isVerifiedOnce;

          // To avoid context async gap.

          final showSnackBar = ScaffoldMessenger.maybeOf(context)?.showSnackBar;
          Future<T?> showDialogApi<T>(
            WidgetBuilder builder, {
            bool barrierDismissible = true,
          }) {
            return showDialog<T>(
              context: context,
              builder: builder,
              barrierDismissible: barrierDismissible,
            );
          }

          Future<void> verifySignedInUser() {
            return context.read<AuthCubit>().verifySignedInUser(context);
          }

          final userCacheCubit = context.read<UserCacheCubit>();

          if (isSignedIn) {
            // register route condition inside this block

            if (isRegistered) {
              try {
                await userCacheCubit
                    .loginByEmail(authValue.signedInUser?.email ?? '');
              } catch (e, trace) {
                kLogger.w(
                  'AuthCubit listener loginByEmail error',
                  error: e,
                  stackTrace: trace,
                );

                showDialogApi(
                  barrierDismissible: false,
                  (_) => Builder(builder: (context) {
                    final userCacheCubit = context.watch<UserCacheCubit>();

                    return AlertDialog(
                      content: const Text('Verifikasi Gagal'),
                      actions: [
                        TextButton(
                          onPressed: userCacheCubit.state.isLoading
                              ? null
                              : () async {
                                  await userCacheCubit.loginByEmail(
                                      authValue.signedInUser?.email ?? '');
                                },
                          child: const Text('Masuk Ulang'),
                        )
                      ],
                    );
                  }),
                );
              }

              return;
            }

            try {
              if (!isVerifiedOnce) await verifySignedInUser();
            } catch (e, trace) {
              kLogger.f(
                'AuthCubit listener verifySignedInUser error',
                error: e,
                stackTrace: trace,
              );

              showSnackBar?.call(const SnackBar(
                content: Text('Akun belum terdaftar, silahkan mendaftar.'),
              ));
            }
          }
        },
      ),

      /// When [FirebaseUser] exists, update [AuthCubit] to signed in state.
      BlocListener<FirebaseUserCubit, FirebaseUserCubitState>(
        listenWhen: (_, state) {
          return !state.isLoading && state.hasValue && state.value != null;
        },
        listener: (context, state) {
          final authCubit = context.read<AuthCubit>();
          final firebaseUser = state.value!; // filtered on listenWhen

          authCubit.toSignedInState(firebaseUser);
        },
      ),

      /// Update [AuthCubit] auth state based on [User] from cache.
      BlocListener<UserCacheCubit, UserCacheCubitState>(
        listenWhen: (_, state) => !state.isLoading && state.hasValue,
        listener: (context, state) {
          final authCubit = context.read<AuthCubit>();
          final user = state.value;

          if (authCubit.state.value?.isVerifiedOnce ?? false) return;

          authCubit.updateAuthorization(user != null);
        },
      ),
    ],
    child: child,
  );
}
