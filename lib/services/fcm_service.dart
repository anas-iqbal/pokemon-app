import 'package:firebase_auth/firebase_auth.dart';

class FCMService {
  static isUserLoggedIn() {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    if (_auth.currentUser != null)
      return true;
    else
      return false;
  }

  static registerUser(String email, String password) async {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    final User user = (await _auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    ))
        .user;
    if (user != null) {
      return true;
    } else {
      return false;
    }
  }

  static loginUser(String email, String password) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      return true;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
    }
  }

  static logout() async {
    await FirebaseAuth.instance.signOut();
  }
}
