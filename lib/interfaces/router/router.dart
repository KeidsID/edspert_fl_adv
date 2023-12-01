import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:edspert_fl_adv/common/constants.dart';
import 'package:edspert_fl_adv/interfaces/providers/auth/user_cache_provider.dart';
import 'package:edspert_fl_adv/interfaces/router/routes.dart';

part 'router.g.dart';

@Riverpod(dependencies: [UserCache])
GoRouter router(RouterRef ref) {
  final isAuthNotifier = ValueNotifier<AsyncValue<bool>>(const AsyncLoading());

  ref
    ..onDispose(isAuthNotifier.dispose)
    ..listen(
      userCacheProvider.select(
        (value) => value.whenData((value) => value != null),
      ),
      (_, next) {
        isAuthNotifier.value = next;
      },
    );

  final router = GoRouter(
    navigatorKey: routerNavKey,
    refreshListenable: isAuthNotifier,
    initialLocation: const AuthRoute().location,
    routes: $appRoutes,
    redirect: (context, state) {
      final isAuthAsync = isAuthNotifier.value;

      final currentRoute = state.uri.path;
      final isAuthRoute = currentRoute.startsWith(const AuthRoute().location);

      kLogger.i('currentRoute: ${state.uri}');

      // if (isAuthAsync.unwrapPrevious().hasError) {
      //   return const AuthRoute().location;
      // }

      if (isAuthAsync.isLoading || !isAuthAsync.hasValue) return null;

      final isAuth = isAuthNotifier.value.requireValue;

      if (isAuth) {
        if (isAuthRoute) return const HomeRoute().location;

        return null;
      }

      if (!isAuthRoute) return const AuthRoute().location;

      return null;
    },
  );
  ref.onDispose(router.dispose);

  return router;
}
