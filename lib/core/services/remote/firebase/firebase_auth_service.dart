import 'package:root_lib/core/entities/auth/firebase_user.dart';

abstract interface class FirebaseAuthService {
  bool checkGoogleSignInUser();
  Future<FirebaseUser?> signInWithGoogle();
  Future<void> logout();
}
