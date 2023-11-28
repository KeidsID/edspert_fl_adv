part of '../routes.dart';

/// {@template lib.interfaces.router.routes.home_route}
/// `/` route.
/// {@endtemplate}
class HomeRoute extends GoRouteData {
  /// {@macro lib.interfaces.router.routes.home_route}
  const HomeRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const HomeView();
  }
}

/// {@template lib.interfaces.router.routes.profile_route}
/// `/profile` route.
/// {@endtemplate}
class ProfileRoute extends GoRouteData {
  /// {@macro lib.interfaces.router.routes.profile_route}
  const ProfileRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const ProfileView();
  }
}
