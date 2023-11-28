import 'package:flutter/material.dart';

import 'package:edspert_fl_adv/core/services/cache/theme_mode_cache.dart';

/// {@template edspert_fl_adv.core.use_cases.others.set_theme_mode}
/// Call [execute] to save [ThemeMode] into cache.
/// {@endtemplate}
final class SetThemeMode {
  final ThemeModeCache _themeModeCache;

  /// {@macro edspert_fl_adv.core.use_cases.others.set_theme_mode}
  const SetThemeMode({required ThemeModeCache themeModeCache})
      : _themeModeCache = themeModeCache;

  /// {@macro edspert_fl_adv.core.use_cases.others.set_theme_mode}
  Future<void> execute(ThemeMode mode) => _themeModeCache.save(mode);
}
