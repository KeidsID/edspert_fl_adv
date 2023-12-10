part of '../container.dart';

void _registerServices() {
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
    ..registerLazySingleton<UserCache>(() => UserCacheImpl(locator()))
    ..registerLazySingleton<ThemeModeCache>(
        () => ThemeModeCacheImpl(locator()));
}
