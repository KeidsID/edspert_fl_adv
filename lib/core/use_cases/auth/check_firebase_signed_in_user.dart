part of '../../use_cases.dart';

/// {@template lib.core.use_cases.auth.check_google_signed_in_user}
/// Check user from [GoogleSignIn] instance. Because its cached in app.
/// {@endtemplate}
final class CheckFirebaseSignedInUser {
  /// {@macro lib.core.use_cases.auth.check_google_signed_in_user}
  const CheckFirebaseSignedInUser(
      {required FirebaseAuthService firebaseAuthService})
      : _firebaseAuthService = firebaseAuthService;

  final FirebaseAuthService _firebaseAuthService;

  /// {@macro lib.core.use_cases.auth.check_google_signed_in_user}
  bool execute() => _firebaseAuthService.checkGoogleSignInUser();
}
