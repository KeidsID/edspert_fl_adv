import 'package:edspert_fl_adv/core/services/cache/auth_cache.dart';

/// {@template edspert_fl_adv.core.use_cases.auth.logout_user}
/// Call [execute] to logout current user (remove user cache).
/// {@endtemplate}
final class LogoutUser {
  final AuthCache _authCache;

  /// {@macro edspert_fl_adv.core.use_cases.auth.logout_user}
  const LogoutUser({required AuthCache authCache}) : _authCache = authCache;

  /// {@macro edspert_fl_adv.core.use_cases.auth.logout_user}
  Future<void> execute() => _authCache.deleteUser();
}
