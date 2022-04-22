import 'package:firebase/googlecode.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class phonepage extends StatefulWidget {
  const phonepage({Key? key}) : super(key: key);

  @override
  State<phonepage> createState() => _phonepageState();
}

class _phonepageState extends State<phonepage> {

  TextEditingController number = TextEditingController();
  TextEditingController otp = TextEditingController();
  String mycode = "";
  String verid = "";
  @override
  Widget build(BuildContext context) {
    return  Scaffold (
      appBar: AppBar(
        title: Text("MOBILE PAGE"),
      ),
      backgroundColor: Colors.grey.shade400,
      body: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        SizedBox(
          height: 20,
        ),
        Container(
          child: TextField(
            controller: number,
            decoration: InputDecoration(
                prefixIcon: Icon(
                  Icons.mobile_screen_share,
                  size: 30,
                  color: Colors.blueAccent,
                ),
                labelText: "MOBILE NUMBER",
                fillColor: Colors.green.shade100,
                filled: true,
                hintText: "number",
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12))),
          ),
        ),
        SizedBox(
          height: 20,
        ),
        Container(
          child: TextField(
            controller: otp,
            decoration: InputDecoration(
                prefixIcon: Icon(
                  Icons.vpn_key,
                  size: 30,
                  color: Colors.blueAccent,
                ),
                labelText: "ENTER OTP",
                fillColor: Colors.green.shade100,
                filled: true,
                hintText: "OTP",
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12))),
          ),
        ),
        SizedBox(
          height: 20,
        ),
        InkWell(
          onTap: () async {

            FirebaseAuth auth = FirebaseAuth.instance;

            String smsCode = otp.text;

            // Create a PhoneAuthCredential with the code
            PhoneAuthCredential credential = PhoneAuthProvider.credential(verificationId: verid, smsCode: smsCode);

            // Sign the user in (or link) with the credential
            await auth.signInWithCredential(credential);

            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return googlecode();
            },));

          },
          child: Container(
            alignment: Alignment.center,
            height: 50,
            child: Text(
              " OTP",
              style: TextStyle(fontSize: 22, color: Colors.white),
            ),
            width: 220,
            decoration: BoxDecoration(
                color: Colors.purpleAccent.shade100,
                borderRadius: BorderRadius.circular(12)),
          ),
        ),
        SizedBox(
          height: 30,
        ),
        InkWell(
          onTap: () async {

            await FirebaseAuth.instance.verifyPhoneNumber(
              phoneNumber: '+91${number.text}',
              verificationCompleted: (PhoneAuthCredential credential) {},
              verificationFailed: (FirebaseAuthException e) {},
              codeSent: (String verificationId, int? resendToken) {
                setState(() {
                  verid=verificationId;
                });
              },
              codeAutoRetrievalTimeout: (String verificationId) {},
            );

          },
          child: Container(
            alignment: Alignment.center,
            height: 50,
            child: Text(
              "PHOne Number",
              style: TextStyle(fontSize: 22, color: Colors.white),
            ),
            width: 220,
            decoration: BoxDecoration(
                color: Colors.pink.shade200,
                borderRadius: BorderRadius.circular(12)),
          ),
        ),
      ]),
    );
  }

}
