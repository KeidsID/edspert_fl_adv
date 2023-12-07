part of '../../use_cases.dart';

/// {@template lib.core.use_cases.auth.logout_user}
/// Call [execute] to logout current user (remove user cache).
/// {@endtemplate}
final class LogoutUser {
  final AuthCache _authCache;
  final FirebaseAuthService _firebaseAuthService;

  /// {@macro lib.core.use_cases.auth.logout_user}
  const LogoutUser({
    required AuthCache authCache,
    required FirebaseAuthService firebaseAuthService,
  })  : _authCache = authCache,
        _firebaseAuthService = firebaseAuthService;

  /// {@macro lib.core.use_cases.auth.logout_user}
  Future<void> execute() async {
    await _firebaseAuthService.logout();
    await _authCache.delete();
  }
}
