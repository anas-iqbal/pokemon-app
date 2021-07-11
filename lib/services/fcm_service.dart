import 'package:firebase_auth/firebase_auth.dart';
import 'package:pokemon_app/api_manager/http_wrapper.dart';
import 'package:pokemon_app/utils/global.dart';

class FCMService {
  static isUserLoggedIn() {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    if (_auth.currentUser != null) {
      cache.userEmail = _auth.currentUser.email;
      return true;
    } else
      return false;
  }

  static registerUser(String email, String password) async {
    try {
      final FirebaseAuth _auth = FirebaseAuth.instance;
      final User user = (await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      ))
          .user;
      if (user != null) {
        cache.userEmail = user.email;
        return true;
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        throw HttpCustomException(
            code: 404, message: "The password provided is too weak.");
      } else if (e.code == 'email-already-in-use') {
        throw HttpCustomException(
            code: 404, message: "The account already exists for that email.");
      }
    } catch (e) {
      throw HttpCustomException(code: 404, message: "Something went wront");
    }
  }

  static loginUser(String email, String password) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      return true;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        throw HttpCustomException(code: 404, message: "User not found");
      } else if (e.code == 'wrong-password') {
        throw HttpCustomException(
            code: 404, message: "User or passowrd in correct");
      }
    } catch (e) {
      throw HttpCustomException(code: 404, message: "Something went wront");
    }
  }

  static logout() async {
    await FirebaseAuth.instance.signOut();
  }
}
