import 'package:flutter/material.dart';

import 'package:root_lib/core/services/cache/theme_mode_cache.dart';

/// {@template root_lib.core.use_cases.others.set_theme_mode}
/// Call [execute] to save [ThemeMode] into cache.
/// {@endtemplate}
final class SetThemeMode {
  final ThemeModeCache _themeModeCache;

  /// {@macro root_lib.core.use_cases.others.set_theme_mode}
  const SetThemeMode({required ThemeModeCache themeModeCache})
      : _themeModeCache = themeModeCache;

  /// {@macro root_lib.core.use_cases.others.set_theme_mode}
  Future<void> execute(ThemeMode mode) => _themeModeCache.save(mode);
}
