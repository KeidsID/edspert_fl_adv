import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'api/client.dart';
import 'api/services/users_service.dart';

final locator = GetIt.instance;

Future<void> init() async {
  // external
  locator.registerSingletonAsync(() => SharedPreferences.getInstance());

  // api services
  locator.registerSingleton<BaseOptions>(clientOptions);
  locator.registerLazySingleton(() => UsersService(locator()));

  await locator.allReady();
}
