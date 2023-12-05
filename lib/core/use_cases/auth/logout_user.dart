import 'package:root_lib/core/services/cache/auth_cache.dart';

/// {@template lib.core.use_cases.auth.logout_user}
/// Call [execute] to logout current user (remove user cache).
/// {@endtemplate}
final class LogoutUser {
  final AuthCache _authCache;

  /// {@macro lib.core.use_cases.auth.logout_user}
  const LogoutUser({required AuthCache authCache}) : _authCache = authCache;

  /// {@macro lib.core.use_cases.auth.logout_user}
  Future<void> execute() => _authCache.delete();
}
