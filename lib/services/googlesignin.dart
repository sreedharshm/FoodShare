import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../view/Navigation.dart';

class GoogleSignInClass {
  static googleSigniN(BuildContext context) async {
    try {
      final GoogleSignInAccount? user = await GoogleSignIn().signIn();

      final GoogleSignInAuthentication userauth = await user!.authentication;
      final credential = GoogleAuthProvider.credential(
          idToken: userauth.accessToken, accessToken: userauth.accessToken);
      await FirebaseAuth.instance.signInWithCredential(credential);
      return "success";
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.message.toString())));
    }
  }
}
//Not Working
