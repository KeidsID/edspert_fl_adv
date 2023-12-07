part of '../../use_cases.dart';

/// {@template lib.core.use_cases.auth.get_firebase_user}
/// Get Firebase User from google sign in.
/// {@endtemplate}
final class LoginWithFirebase {
  const LoginWithFirebase({required FirebaseAuthService firebaseAuthService})
      : _firebaseAuthService = firebaseAuthService;

  /// {@macro lib.core.use_cases.auth.get_firebase_user}
  final FirebaseAuthService _firebaseAuthService;

  /// {@macro lib.core.use_cases.auth.get_firebase_user}
  Future<FirebaseUser?> execute() => _firebaseAuthService.signInWithGoogle();
}
