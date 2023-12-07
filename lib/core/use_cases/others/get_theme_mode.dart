part of '../../use_cases.dart';

/// {@template root_lib.core.use_cases.others.get_theme_mode}
/// Call [execute] to get [ThemeMode] from cache. Default are [ThemeMode.system].
/// {@endtemplate}
final class GetThemeMode {
  final ThemeModeCache _themeModeCache;

  /// {@macro root_lib.core.use_cases.others.get_theme_mode}
  const GetThemeMode({required ThemeModeCache themeModeCache})
      : _themeModeCache = themeModeCache;

  /// {@macro root_lib.core.use_cases.others.get_theme_mode}
  Future<ThemeMode> execute() => _themeModeCache.get();
}
