import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class GoogleSignInClass {
  static googleSigniN() async {
    try {
      final GoogleSignInAccount? user = await GoogleSignIn().signIn();

      final GoogleSignInAuthentication userauth = await user!.authentication;
      final credential = GoogleAuthProvider.credential(
          idToken: userauth.accessToken, accessToken: userauth.accessToken);
      return await FirebaseAuth.instance.signInWithCredential(credential);
    } catch (e) {
      print("error");
    }
  }
}
