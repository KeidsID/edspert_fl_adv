import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../api/models/user.dart';

class AuthCache {
  const AuthCache(SharedPreferences sharedPreferences)
      : _cacher = sharedPreferences;

  final SharedPreferences _cacher;

  static const key = 'auth';

  Future<void> saveUser(User user) async {
    final isSuccess = await _cacher.setString(key, jsonEncode(user.toJson()));

    if (!isSuccess) throw Exception('Failed to save user');
  }

  Future<User?> getUser() async {
    await _cacher.reload();

    final rawUser = _cacher.getString(key);

    if (rawUser == null) return null;

    return User.fromJson(jsonDecode(rawUser));
  }
}
