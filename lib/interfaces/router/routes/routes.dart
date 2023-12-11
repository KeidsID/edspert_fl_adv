/// Contain app routes to navigate.
///
/// Example:
/// ```
/// import 'package:root_lib/interfaces/router/routes.dart';
///
/// Builder(
///   builder: (context) {
///     return ElevatedButton(
///       onPressed: () => const ProfileRoute().go(context),
///       child: const Text('Login'),
///     );
///   },
/// );
/// ```
library routes;

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'package:root_lib/core/entities.dart';
import 'package:root_lib/interfaces/providers/res/auth/firebase_user_cubit.dart';
import 'package:root_lib/interfaces/router/utils/dialog_page.dart';
import 'package:root_lib/interfaces/views.dart';
import 'utils/auth_cubits_listener.dart';

part 'res/auth.dart';
part 'res/home_shell/home.dart';
part 'res/home_shell/profile.dart';
part 'routes.g.dart';

final GlobalKey<NavigatorState> routerNavKey = GlobalKey<NavigatorState>();
final GlobalKey<NavigatorState> homeShellNavKey = GlobalKey<NavigatorState>();

/// {@template lib.interfaces.router.routes.auth_route}
/// `/auth` route.
/// {@endtemplate}
@TypedGoRoute<AuthRoute>(
  path: '/auth',
  routes: [TypedGoRoute<RegisterRoute>(path: 'register')],
)
class AuthRoute extends GoRouteData {
  /// {@macro lib.interfaces.router.routes.auth_route}
  const AuthRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return authCubitsListener(child: const AuthView());
  }
}

/// Layout for `/` and `/profile` routes.
@TypedShellRoute<HomeShellRoute>(
  routes: [
    TypedGoRoute<HomeRoute>(
      path: '/',
      routes: [
        TypedGoRoute<CoursesRoute>(
          path: 'courses',
          routes: [TypedGoRoute<ExercisesRoute>(path: ':courseId')],
        ),
      ],
    ),
    TypedGoRoute<ProfileRoute>(
      path: '/profile',
      routes: [
        TypedGoRoute<EditProfileDialogRoute>(path: 'edit'),
      ],
    ),
  ],
)
class HomeShellRoute extends ShellRouteData {
  const HomeShellRoute();

  static final GlobalKey<NavigatorState> $navigatorKey = homeShellNavKey;

  @override
  Widget builder(BuildContext context, GoRouterState state, Widget navigator) {
    return authCubitsListener(child: HomeLayout(child: navigator));
  }
}
