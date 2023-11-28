import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:edspert_fl_adv/core/services/cache/theme_mode_cache.dart';

final class ThemeModeCacheImpl implements ThemeModeCache {
  const ThemeModeCacheImpl(SharedPreferences sharedPreferences)
      : _cacher = sharedPreferences;

  final SharedPreferences _cacher;

  static const key = 'theme_mode';

  @override
  Future<ThemeMode> get() async {
    await _cacher.reload();

    final mode = ThemeMode.values[_cacher.getInt(key) ?? 0];

    return mode;
  }

  @override
  Future<void> save(ThemeMode mode) async {
    final isSuccess = await _cacher.setInt(key, mode.index);

    if (!isSuccess) throw Exception('Failed to save theme mode');
  }
}
