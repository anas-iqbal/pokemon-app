import 'package:firebase_auth/firebase_auth.dart';

class FCMService {
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
}
