/// A dependencies container.
///
/// Call [init] before use the [locator].
///
/// Example:
/// ```
/// import 'core/services/cache/auth_cache.dart';
/// import 'infrastructures/container.dart' as container;
///
/// void main () async {
///   await container.init();
///
///   final authCache = container.locator<AuthCache>();
/// }
/// ```
library container;

import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:root_lib/core/services.dart';
import 'package:root_lib/core/use_cases.dart';
import 'services/services.dart';

final locator = GetIt.instance;

Future<void> init() async {
  // services
  locator
    // api
    ..registerSingleton<Dio>(client)
    //
    ..registerLazySingleton<CoursesService>(() => CoursesServiceImpl(locator()))
    ..registerLazySingleton<EventsService>(() => EventsServiceImpl(locator()))
    ..registerLazySingleton<UsersService>(() => UsersServiceImpl(locator()))

    // firebase
    ..registerSingleton(FirebaseAuth.instance)
    ..registerLazySingleton(() => GoogleSignIn())
    //
    ..registerLazySingleton<FirebaseAuthService>(() => FirebaseAuthServiceImpl(
          firebaseAuth: locator(),
          googleSignIn: locator(),
        ))

    // cache
    ..registerSingletonAsync(() => SharedPreferences.getInstance())
    //
    ..registerLazySingleton<AuthCache>(() => AuthCacheImpl(locator()))
    ..registerLazySingleton<ThemeModeCache>(
        () => ThemeModeCacheImpl(locator()));

  // use cases
  locator
    // auth
    ..registerLazySingleton(() => GetUserFromCache(authCache: locator()))
    ..registerLazySingleton(() => CheckFirebaseSignedInUser(
          firebaseAuthService: locator(),
        ))
    ..registerLazySingleton(() => LoginWithFirebase(
          firebaseAuthService: locator(),
        ))
    ..registerLazySingleton(() => LoginByEmail(
          usersService: locator(),
          authCache: locator(),
        ))
    ..registerLazySingleton(() => RegisterUser(
          usersService: locator(),
          authCache: locator(),
        ))
    ..registerLazySingleton(() => LogoutUser(
          authCache: locator(),
          firebaseAuthService: locator(),
        ))
    ..registerLazySingleton(() => UpdateUserByEmail(
          usersService: locator(),
          authCache: locator(),
        ))

    // courses
    ..registerLazySingleton(() => GetCoursesByMajor(coursesService: locator()))

    // events
    ..registerLazySingleton(() => GetEventBanners(eventService: locator()))

    // others
    ..registerLazySingleton(() => GetThemeMode(themeModeCache: locator()))
    ..registerLazySingleton(() => SetThemeMode(themeModeCache: locator()));

  await locator.allReady();
}
