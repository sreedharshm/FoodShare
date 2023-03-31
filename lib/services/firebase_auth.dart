import 'package:firebase_auth/firebase_auth.dart';

class FireAuth {
  static String s = "wrong";
  static final _firebaseAuth = FirebaseAuth.instance;
  static Future<String> signIn(
      {required String emailController,
      required String passwordController}) async {
    try {
      final credential = await _firebaseAuth.signInWithEmailAndPassword(
          email: emailController, password: passwordController);
      s = "success";
    } on FirebaseAuthException catch (e) {
      s = e.toString();
    }
    return s;
  }

  static Future<String> signUp(
      {required String emailController,
      required String passwordController}) async {
    try {
      final credential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: emailController, password: passwordController);
      s = "success";
    } on FirebaseAuthException catch (e) {
      s = e.toString();
    }
    return s;
  }
}
