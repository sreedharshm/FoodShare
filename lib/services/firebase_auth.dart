import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class FireAuth {
  static String s = "wrong";
  static final _firebaseAuth = FirebaseAuth.instance;
  static Future<String> signIn(
      {required String emailController,
      required String passwordController}) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
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
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailController, password: passwordController);
      s = "success";
    } on FirebaseAuthException catch (e) {
      s = e.toString();
    }
    return s;
  }

  static Future sendEmail({required String email, context}) async {
    try {
      await _firebaseAuth.sendPasswordResetEmail(email: email);
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("Email send")));
    } on FirebaseAuthException catch (e) {
      String? err = e.message;
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Email not send $err")));
    }
  }

  static Future logout() async {
    await _firebaseAuth.signOut();
  }
}
