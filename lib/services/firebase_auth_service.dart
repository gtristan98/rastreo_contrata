import 'package:firebase_auth/firebase_auth.dart';

class FirebaseAuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<UserCredential> signInAnonymously() async {
    return await _auth.signInAnonymously();
  }

  User? getCurrentUser() {
    return _auth.currentUser;
  }
}
