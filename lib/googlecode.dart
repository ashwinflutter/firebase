import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class googlecode extends StatefulWidget {
  const googlecode({Key? key}) : super(key: key);

  @override
  State<googlecode> createState() => _googlecodeState();
}

class _googlecodeState extends State<googlecode> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Google Code"),
        ),
        body: Center(
          child: ElevatedButton(
            onPressed: () {
              signInWithGoogle().then((value)  {

                print(value);
              });

            },
            child: Text("SUBMIT"),
          ),
        ));
  }
}
Future<UserCredential> signInWithGoogle() async {
  // Trigger the authentication flow
  final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

  // Obtain the auth details from the request
  final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

  // Create a new credential
  final credential = GoogleAuthProvider.credential(
    accessToken: googleAuth?.accessToken,
    idToken: googleAuth?.idToken,
  );

  // Once signed in, return the UserCredential
  return await FirebaseAuth.instance.signInWithCredential(credential);
}