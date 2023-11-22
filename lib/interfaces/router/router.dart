import 'package:go_router/go_router.dart';

import 'routes.dart';

/// App router config.
final router = GoRouter(
  navigatorKey: routerNavKey,
  initialLocation: AuthRoute.path,
  routes: $appRoutes,
);
