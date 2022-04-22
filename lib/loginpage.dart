import 'package:firebase/phonepage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class loginpage extends StatefulWidget {
  const loginpage({Key? key}) : super(key: key);

  @override
  State<loginpage> createState() => _loginpageState();
}

class _loginpageState extends State<loginpage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Login Page"),
        backgroundColor: Colors.green,
      ),
      body: Column(
          mainAxisAlignment: MainAxisAlignment.center, children: [
        SizedBox(
          height: 20,
        ),
        Container(
          child: TextField(
            controller: email,
            decoration: InputDecoration(
                prefixIcon: Icon(
                  Icons.email_outlined,
                  size: 30,
                  color: Colors.blueAccent,
                ),
                labelText: "Email",
                fillColor: Colors.green.shade100,
                filled: true,
                hintText: "email",
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
                  Icons.vpn_key,
                  size: 30,
                  color: Colors.blueAccent,
                ),
                labelText: "PASSWORD",
                fillColor: Colors.green.shade100,
                filled: true,
                hintText: "password",
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
              final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
                  email: email.text,
                  password: password.text
              );

              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return phonepage();
              },));
            }
            on FirebaseAuthException catch (e) {
              if (e.code == 'user-not-found') {
                print('No user found for that email.');
              } else if (e.code == 'wrong-password') {
                print('Wrong password provided for that user.');
              }
            }


          },
          child: Container(
            alignment: Alignment.center,
            height: 50,
            child: Text(
              "LOGIN",
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
