import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'package:root_lib/core/entities/auth/firebase_user.dart';
import 'package:root_lib/core/services/remote/firebase/firebase_auth_service.dart';

final class FirebaseAuthServiceImpl implements FirebaseAuthService {
  final FirebaseAuth _firebaseAuth;
  final GoogleSignIn _googleSignIn;

  const FirebaseAuthServiceImpl({
    required FirebaseAuth firebaseAuth,
    required GoogleSignIn googleSignIn,
  })  : _firebaseAuth = firebaseAuth,
        _googleSignIn = googleSignIn;

  @override
  bool checkGoogleSignInUser() {
    return _googleSignIn.currentUser != null ||
        _firebaseAuth.currentUser != null;
  }

  @override
  Future<FirebaseUser?> signInWithGoogle() async {
    final GoogleSignInAccount? user = await _googleSignIn.signIn();
    final GoogleSignInAuthentication? auth = await user?.authentication;

    final credential = GoogleAuthProvider.credential(
      idToken: auth?.idToken,
      accessToken: auth?.accessToken,
    );
    final UserCredential firebaseCredential =
        await _firebaseAuth.signInWithCredential(credential);

    return firebaseCredential.user;
  }

  @override
  Future<void> logout() async {
    await _googleSignIn.signOut();
    await _firebaseAuth.signOut();
  }
}
