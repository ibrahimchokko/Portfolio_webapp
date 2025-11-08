import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Login admin
  Future<bool> loginAdmin(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      // optionally: verify user role in Firestore
      return true;
    } catch (e) {
      return false;
    }
  }

  // Logout admin
  Future<void> logoutAdmin() async {
    await _auth.signOut();
  }

  // Check if admin is logged in
  Future<bool> isAdminLoggedIn() async {
    final user = _auth.currentUser;
    return user != null;
  }
}
