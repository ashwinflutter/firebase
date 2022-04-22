import 'package:firebase/ggg.dart';
import 'package:firebase/loginpage.dart';
import 'package:firebase/phonepage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'googlecode.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MaterialApp(
    home: mmm(),
  ));
}

class registerpage extends StatefulWidget {
  const registerpage({Key? key}) : super(key: key);

  @override
  State<registerpage> createState() => _registerpageState();
}

class _registerpageState extends State<registerpage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Firebase "),
        backgroundColor: Colors.brown.shade300,
      ),
      body: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        SizedBox(
          height: 20,
        ),
        Container(
          child: TextField(
            controller: email,
            decoration: InputDecoration(
                prefixIcon: Icon(
                  Icons.email,
                  size: 30,
                  color: Colors.blueAccent,
                ),
                labelText: "email",
                fillColor: Colors.white,
                filled: true,
                hintText: "EAMIL ID",
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12))),
          ),
        ),
        SizedBox(
          height: 5,
        ),
        Container(
          child: TextField(
            controller: password,
            decoration: InputDecoration(
                prefixIcon: Icon(
                  Icons.vpn_key_outlined,
                  size: 30,
                  color: Colors.blueAccent,
                ),
                labelText: "password",
                fillColor: Colors.white,
                filled: true,
                hintText: "PASSWORD",
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12))),
          ),
        ),
        SizedBox(
          height: 20,
        ),
        InkWell(
          onTap: () async {

            try {
              final credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
                email: email.text,
                password: password.text,
              );
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return loginpage();
              },));
            } on FirebaseAuthException catch (e) {
              if (e.code == 'weak-password') {
                print('The password provided is too weak.');
              } else if (e.code == 'email-already-in-use') {
                print('The account already exists for that email.');
              }
            } catch (e) {
              print(e);
            }

          },
          child: Container(
            alignment: Alignment.center,
            height: 50,
            child: Text(
              "REGISTER",
              style: TextStyle(fontSize: 22, color: Colors.white),
            ),
            width: 220,
            decoration: BoxDecoration(
                color: Colors.blue, borderRadius: BorderRadius.circular(12)),
          ),
        )
      ]),
    );
  }

  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
}
