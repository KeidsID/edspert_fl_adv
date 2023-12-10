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
import '../services/services.dart';

part '_registry/_register_services.dart';
part '_registry/_register_use_cases.dart';

final locator = GetIt.instance;

Future<void> init() async {
  _registerServices();
  _registerUseCases();

  await locator.allReady();
}
