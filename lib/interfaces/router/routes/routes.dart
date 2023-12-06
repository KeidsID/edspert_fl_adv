/// Contain app routes to navigate.
///
/// Example:
/// ```
/// import 'package:root_lib/interfaces/router/routes.dart';
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
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'package:root_lib/core/entities/auth/editable_user.dart';
import 'package:root_lib/core/entities/auth/school_detail.dart';
import 'package:root_lib/core/entities/auth/user.dart';
import 'package:root_lib/interfaces/providers/res/user_cache_cubit.dart';
import 'package:root_lib/interfaces/router/utils/dialog_page.dart';
import 'package:root_lib/interfaces/views.dart';

part 'res/auth.dart';
part 'res/home_shell.dart';
part 'routes.g.dart';

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
