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

import 'package:edspert_fl_adv/interfaces/providers/res/user_cache_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'package:edspert_fl_adv/core/entities/auth/editable_user.dart';
import 'package:edspert_fl_adv/core/entities/auth/school_detail.dart';
import 'package:edspert_fl_adv/core/entities/auth/user.dart';
import 'package:edspert_fl_adv/interfaces/router/utils/dialog_page.dart';
import 'package:edspert_fl_adv/interfaces/views.dart';

part 'routes.g.dart';
part 'routes/auth.dart';
part 'routes/home_shell.dart';

final GlobalKey<NavigatorState> routerNavKey = GlobalKey<NavigatorState>();
final GlobalKey<NavigatorState> homeShellNavKey = GlobalKey<NavigatorState>();

/// {@template lib.interfaces.router.routes.auth_route}
/// `/auth` route.
/// {@endtemplate}
@TypedGoRoute<AuthRoute>(
  path: '/auth',
  routes: [
    TypedGoRoute<LoginDialogRoute>(path: 'login'),
    TypedGoRoute<RegisterRoute>(path: 'register')
  ],
)
class AuthRoute extends GoRouteData {
  /// {@macro lib.interfaces.router.routes.auth_route}
  const AuthRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return BlocListener<UserCacheCubit, UserCacheState>(
      listener: (context, _) => GoRouter.maybeOf(context)?.refresh(),
      child: const AuthView(),
    );
  }
}

/// Layout for `/` and `/profile` routes.
@TypedShellRoute<HomeShellRoute>(
  routes: [
    TypedGoRoute<HomeRoute>(path: '/'),
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
    return BlocListener<UserCacheCubit, UserCacheState>(
      listener: (context, _) => GoRouter.maybeOf(context)?.refresh(),
      child: HomeLayout(child: navigator),
    );
  }
}
