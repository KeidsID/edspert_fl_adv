import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'package:root_lib/common/constants.dart';
import 'package:root_lib/interfaces/providers.dart';
import 'package:root_lib/interfaces/providers/utils/future_cubit.dart';
import 'routes/routes.dart';
import 'routes/utils/auth_cubits_listener.dart';

export 'package:go_router/go_router.dart';

/// App Router Configs.
///
/// For redirect trigger. Check [authCubitsListener]
final router = GoRouter(
  navigatorKey: routerNavKey,
  initialLocation: const AuthRoute().location,
  routes: $appRoutes,
  redirect: (context, state) {
    final authValue = context.read<AuthCubit>().state.requireValue;

    final isAuth = authValue.isAuth;
    final isSignedIn = authValue.isSignedIn;
    final isRegistered = authValue.isRegistered;
    final isVerifiedOnce = authValue.isVerifiedOnce;

    final currentRoute = state.uri.path;

    /// `/auth`
    final isAuthRoute = currentRoute.startsWith(const AuthRoute().location);

    /// `/auth/register`
    final isRegisterRoute = currentRoute.startsWith(
      const RegisterRoute().location,
    );

    kLogger.i(
      'Router Redirect Logs\n'
      '- Path: $currentRoute\n'
      '- Query params: <see the next log>\n'
      '- isAuth: $isAuth\n'
      '- isSignedIn: $isSignedIn\n'
      '- isRegistered: $isRegistered\n'
      '- isVerifiedOnce: $isVerifiedOnce',
    );
    kLogger.i(state.uri.queryParameters);

    if (isAuth) {
      if (isAuthRoute) return const HomeRoute().location;

      return null;
    }

    if (isSignedIn) {
      if (!isRegisterRoute) return const RegisterRoute().location;

      return null;
    }

    if (!isAuthRoute || isRegisterRoute) return const AuthRoute().location;

    return null;
  },
);
