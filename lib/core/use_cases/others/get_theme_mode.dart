import 'package:flutter/material.dart';

import 'package:edspert_fl_adv/core/services/cache/theme_mode_cache.dart';

/// {@template edspert_fl_adv.core.use_cases.others.get_theme_mode}
/// Call [execute] to get [ThemeMode] from cache. Default are [ThemeMode.system].
/// {@endtemplate}
final class GetThemeMode {
  final ThemeModeCache _themeModeCache;

  /// {@macro edspert_fl_adv.core.use_cases.others.get_theme_mode}
  const GetThemeMode({required ThemeModeCache themeModeCache})
      : _themeModeCache = themeModeCache;

  /// {@macro edspert_fl_adv.core.use_cases.others.get_theme_mode}
  Future<ThemeMode> execute() => _themeModeCache.get();
}
