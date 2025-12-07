import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter/material.dart';

import '../features/create_user/persentation/view/widgets/create_user_body.dart';

class Auth {
  Auth._();
  static final _instance = Auth._();
  static Auth get instance => _instance;
  final user = FirebaseAuth.instance.currentUser;
  Future<UserCredential> signInWithGoogle(BuildContext context) async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    final UserCredential userCredential =
        await FirebaseAuth.instance.signInWithCredential(credential);
    if (userCredential.user != null) {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) {
            return CreateUserBody();
          },
        ),
      );
    }

    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

  Future<UserCredential?> signUpWithEmail(
      {required String email,
      required String password,
      required BuildContext context}) async {

      final uerCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return uerCredential;
     /*catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('your email is already exist!'),
        ),
      );
      return null;
    }*/
  }


  Future<UserCredential?> signInWithEmail(
      {required String email,
        required String password,
        required BuildContext context}) async {

    try {
      final uerCredential =
      await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);
      return uerCredential;
    }  catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('your email or password not correct!'),
        ),
      );
      return null;
    }

  }
}
