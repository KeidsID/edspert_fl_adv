import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'package:root_lib/common/constants.dart';
import 'package:root_lib/interfaces/providers/res/user_cache_cubit.dart';

import 'routes/routes.dart';

export 'package:go_router/go_router.dart';

final router = GoRouter(
  navigatorKey: routerNavKey,
  initialLocation: const AuthRoute().location,
  routes: $appRoutes,
  redirect: (context, state) {
    final userCacheCubit = context.read<UserCacheCubit>();

    final userCache = userCacheCubit.state;

    final currentRoute = state.uri.path;
    final isAuthRoute = currentRoute.startsWith(const AuthRoute().location);

    kLogger.i(
      'Router Redirect Logs\n'
      '- Path: $currentRoute\n'
      '- Query params: <see below this log>',
    );
    kLogger.i(state.uri.queryParameters);

    if (userCache.isLoading) return null;

    final isAuth = userCache.value != null;

    if (isAuth) {
      if (isAuthRoute) return const HomeRoute().location;

      return null;
    }

    if (!isAuthRoute) return const AuthRoute().location;

    return null;
  },
);
