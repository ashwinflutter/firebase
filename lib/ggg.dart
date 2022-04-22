import 'dart:io';
import 'dart:math';

import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

  class mmm extends StatefulWidget {
  const mmm({Key? key}) : super(key: key);

  @override
  State<mmm> createState() => _mmmState();
}

class _mmmState extends State<mmm> {

  final ImagePicker _picker = ImagePicker();
  String str = "";



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.center,
          children: [
            InkWell(
                onTap: () async {
                  // Pick an image
                  final XFile? image =
                  await _picker.pickImage(source: ImageSource.gallery);
                  setState(() {
                    str = image!.path;
                  });
                },
                child: Container(
                  height: 100,
                  width: 100,
                  child: str != ""
                      ? CircleAvatar(
                    backgroundImage: FileImage(File(str)),
                  )
                      : CircleAvatar(
                    backgroundImage: FileImage(File(str)),
                  ),
                )),
            TextField(
              controller: name,
              decoration: InputDecoration(),
            ),
            ElevatedButton(
                onPressed: () async {
                  final storageRef = FirebaseStorage.instance.ref();

                  String imagename="${name.text}${Random().nextInt(50)}";

                  final spaceRef=storageRef.child("ashwin1/$imagename");
                  spaceRef.putFile(File(str));

                  spaceRef.getDownloadURL().then((value) async {
                    print(value);
                    DatabaseReference rrr=FirebaseDatabase.instance.ref("Realtime").push();

                    String?aa=rrr.key;
                    
                    print(aa);
                    await rrr.set({
                      "name": name.text,
                      "id": aa,
                      "imageurl":value
                    });
                  });
                },
                child: Text("storage")),
            // ElevatedButton(
            //     onPressed: () async {
            //
            //     },
            //     child: Text("send data")),
          ],
        ),
      ),
    );
  }

  TextEditingController name = TextEditingController();
}
