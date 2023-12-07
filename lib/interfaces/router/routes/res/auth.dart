part of '../routes.dart';

// /// {@template lib.interfaces.router.routes.login_dialog_route}
// /// `/auth/login` route.
// /// {@endtemplate}
// class LoginDialogRoute extends GoRouteData {
//   /// {@macro lib.interfaces.router.routes.login_dialog_route}
//   const LoginDialogRoute();

//   @override
//   Page<void> buildPage(BuildContext context, GoRouterState state) {
//     return DialogPage(
//       barrierDismissible: false,
//       builder: (_) => const LoginDialogView(),
//     );
//   }
// }

/// {@template lib.interfaces.router.routes.register_route}
/// `/auth/register` route.
/// {@endtemplate}
class RegisterRoute extends GoRouteData {
  /// {@macro lib.interfaces.router.routes.register_route}
  const RegisterRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    final signedInUser = context.read<FirebaseUserCubit>().state.value;

    return RegisterView(signedInUser: signedInUser);
  }
}
