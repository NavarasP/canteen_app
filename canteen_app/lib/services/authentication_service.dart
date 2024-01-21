// import 'package:firebase_auth/firebase_auth.dart';

class AuthenticationService {

  Future<void> signIn(String email, String password) async {
    try {
      print('Signed in successfully!');
    } catch (e) {
      print('Error signing in: $e');
      // Handle sign-in errors here
    }
  }

  // You can add more authentication methods as needed

  Future<void> signOut() async {
    // await _auth.signOut();
    print('Signed out successfully!');
  }
}
