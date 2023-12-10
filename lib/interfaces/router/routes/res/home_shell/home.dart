part of '../../routes.dart';

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

/// {@template lib.interfaces.router.routes.courses_route}
/// `/courses` route.
///
/// Queries:
/// - `major`: [SchoolMajor.toString] **required**
/// {@endtemplate}
class CoursesRoute extends GoRouteData {
  /// {@macro lib.interfaces.router.routes.courses_route}
  const CoursesRoute({required this.major});

  /// Please provide [SchoolMajor.toString].
  final String major;

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return CoursesView(SchoolMajor.fromString(major));
  }
}