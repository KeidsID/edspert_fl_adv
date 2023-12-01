/// Service Locator.
///
/// Call [init] before use the [locator].
///
/// Example:
/// ```
/// import 'core/services/cache/auth_cache.dart';
/// import 'infrastructures/services.dart' as services;
///
/// void main () async {
///   await services.init();
///
///   final authCache = services.locator<AuthCache>();
/// }
/// ```
library services;

import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:edspert_fl_adv/core/services.dart';
import 'package:edspert_fl_adv/core/use_cases.dart';
import 'package:edspert_fl_adv/infrastructures/api/client/client.dart';
import 'package:edspert_fl_adv/infrastructures/api/services/events_service_impl.dart';
import 'package:edspert_fl_adv/infrastructures/api/services/users_service_impl.dart';
import 'package:edspert_fl_adv/infrastructures/cache/auth_cache_impl.dart';
import 'package:edspert_fl_adv/infrastructures/cache/theme_mode_cache_impl.dart';

final locator = GetIt.instance;

Future<void> init() async {
  // external
  locator.registerSingletonAsync(() => SharedPreferences.getInstance());

  // services
  locator
    // api
    ..registerSingleton<Dio>(client)
    ..registerLazySingleton<UsersService>(() => UsersServiceImpl(locator()))
    ..registerLazySingleton<EventsService>(() => EventsServiceImpl(locator()))

    // cache
    ..registerLazySingleton<AuthCache>(() => AuthCacheImpl(locator()))
    ..registerLazySingleton<ThemeModeCache>(
        () => ThemeModeCacheImpl(locator()));

  // use cases
  locator
    // auth
    ..registerLazySingleton(() => GetUserFromCache(authCache: locator()))
    ..registerLazySingleton(
        () => LoginByEmail(usersService: locator(), authCache: locator()))
    ..registerLazySingleton(() => LogoutUser(authCache: locator()))
    ..registerLazySingleton(
        () => RegisterUser(usersService: locator(), authCache: locator()))
    ..registerLazySingleton(
        () => UpdateUserByEmail(usersService: locator(), authCache: locator()))

    // event
    ..registerLazySingleton(() => GetEventBanners(eventService: locator()))

    // others
    ..registerLazySingleton(() => GetThemeMode(themeModeCache: locator()))
    ..registerLazySingleton(() => SetThemeMode(themeModeCache: locator()));

  await locator.allReady();
}
