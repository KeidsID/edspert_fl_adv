import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import 'package:root_lib/core/entities/auth/user.dart';
import 'package:root_lib/core/services/cache/user_cache.dart';

class UserCacheImpl implements UserCache {
  const UserCacheImpl(SharedPreferences sharedPreferences)
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
