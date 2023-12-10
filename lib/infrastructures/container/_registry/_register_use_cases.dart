part of '../container.dart';

void _registerUseCases() {
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
    ..registerLazySingleton(
        () => GetExercisesFromCourse(coursesService: locator()))

    // events
    ..registerLazySingleton(() => GetEventBanners(eventService: locator()))

    // others
    ..registerLazySingleton(() => GetThemeMode(themeModeCache: locator()))
    ..registerLazySingleton(() => SetThemeMode(themeModeCache: locator()));
}
