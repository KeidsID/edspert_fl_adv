part of '../routes.dart';

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
