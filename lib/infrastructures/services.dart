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

import 'package:edspert_fl_adv/core/services/api/users_service.dart';
import 'package:edspert_fl_adv/core/services/cache/auth_cache.dart';
import 'package:edspert_fl_adv/core/use_cases.dart';
import 'package:edspert_fl_adv/infrastructures/api/client.dart';
import 'package:edspert_fl_adv/infrastructures/api/services/users_service_impl.dart';
import 'package:edspert_fl_adv/infrastructures/cache/auth_cache_impl.dart';

final locator = GetIt.instance;

Future<void> init() async {
  // external
  locator.registerSingletonAsync(() => SharedPreferences.getInstance());

  // api services
  locator
    ..registerSingleton<BaseOptions>(clientOptions)
    ..registerLazySingleton<UsersService>(() => UsersServiceImpl(locator()));

  // cache services
  locator.registerLazySingleton<AuthCache>(() => AuthCacheImpl(locator()));

  // use cases
  locator
    ..registerLazySingleton(() => GetUserFromCache(authCache: locator()))
    ..registerLazySingleton(
        () => LoginByEmail(usersService: locator(), authCache: locator()))
    ..registerLazySingleton(() => LogoutUser(authCache: locator()))
    ..registerLazySingleton(
        () => RegisterUser(usersService: locator(), authCache: locator()));

  await locator.allReady();
}
