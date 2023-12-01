import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import 'package:edspert_fl_adv/core/entities/auth/user.dart';
import 'package:edspert_fl_adv/core/services/cache/auth_cache.dart';

class AuthCacheImpl implements AuthCache {
  const AuthCacheImpl(SharedPreferences sharedPreferences)
      : _cacher = sharedPreferences;

  final SharedPreferences _cacher;

  static const key = 'auth';

  @override
  Future<void> save(User user) async {
    final isSuccess = await _cacher.setString(key, jsonEncode(user.toJson()));

    if (!isSuccess) throw Exception('Failed to save user');
  }

  @override
  Future<User?> get() async {
    await _cacher.reload();

    final rawUser = _cacher.getString(key);

    if (rawUser == null) return null;

    return User.fromJson(jsonDecode(rawUser));
  }

  @override
  Future<void> delete() async {
    await _cacher.remove(key);
  }
}
