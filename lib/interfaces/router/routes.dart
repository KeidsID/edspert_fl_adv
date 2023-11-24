/// Contain app routes to navigate.
///
/// Example:
/// ```
/// import 'package:edspert_fl_adv/interfaces/router/routes.dart';
///
/// Builder(
///   builder: (context) {
///     return ElevatedButton(
///       onPressed: () => const LoginDialogRoute().go(context),
///       child: const Text('Login'),
///     );
///   },
/// );
/// ```
library routes;

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:edspert_fl_adv/interfaces/router/utils/dialog_page.dart';
import 'package:edspert_fl_adv/interfaces/views/auth/auth_view.dart';
import 'package:edspert_fl_adv/interfaces/views/auth/register_view.dart';
import 'package:edspert_fl_adv/interfaces/views/home/home_layout.dart';
import 'package:edspert_fl_adv/interfaces/views/home/home_view.dart';
import 'package:edspert_fl_adv/interfaces/widgets/dialog/login_dialog.dart';

part 'routes.g.dart';
part 'routes/auth.dart';
part 'routes/home_shell.dart';

final GlobalKey<NavigatorState> routerNavKey = GlobalKey<NavigatorState>();
final GlobalKey<NavigatorState> homeShellNavKey = GlobalKey<NavigatorState>();

/// {@template lib.interfaces.router.routes.auth_route}
/// `/auth` route.
/// {@endtemplate}
@TypedGoRoute<AuthRoute>(
  path: AuthRoute.path,
  routes: [
    TypedGoRoute<LoginDialogRoute>(path: 'login'),
    TypedGoRoute<RegisterRoute>(path: 'register')
  ],
)
class AuthRoute extends GoRouteData {
  /// {@macro lib.interfaces.router.routes.auth_route}
  const AuthRoute();

  static const path = '/auth';

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const AuthView();
  }
}

/// Layout for `/` and `/profile` routes.
@TypedShellRoute<HomeShellRoute>(
  routes: [
    TypedGoRoute<HomeRoute>(path: '/'),
    TypedGoRoute<ProfileRoute>(path: '/profile'),
  ],
)
class HomeShellRoute extends ShellRouteData {
  const HomeShellRoute();

  static final GlobalKey<NavigatorState> $navigatorKey = homeShellNavKey;

  @override
  Widget builder(BuildContext context, GoRouterState state, Widget navigator) {
    return HomeLayout(child: navigator);
  }
}
