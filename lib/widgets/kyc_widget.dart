import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:image_picker/image_picker.dart';

class KYCWidget extends StatefulWidget {
  final String id;
  const KYCWidget({Key? key, required this.id}) : super(key: key);

  @override
  State<KYCWidget> createState() => _KYCWidgetState();
}

class _KYCWidgetState extends State<KYCWidget> {
  File? image;

  Future pickImage() async {
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (image == null) return;

    final imageTemporary = File(image.path);
    setState(() {
      this.image = imageTemporary;
    });
  }

  Future pickCamera() async {
    final image = await ImagePicker().pickImage(source: ImageSource.camera);
    if (image == null) return;

    final imageTemporary = File(image.path);
    setState(() {
      this.image = imageTemporary;
    });
  }

  Future uploadKYC() async {
    final path = "KYC/" + widget.id;
    final file = this.image;
    final ref = FirebaseStorage.instance.ref().child(path);
    ref.putFile(file!).then((p0) => print("done"));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Upload KYC")),
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Text(
          //   "Upload KYC",
          //   style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
          // ),
          // SizedBox(
          //   height: 20,
          // ),
          image != null
              ? Image.file(
                  image!,
                  height: 300,
                )
              : SizedBox(
                  height: 300,
                ),
          SizedBox(height: 20),
          ElevatedButton(onPressed: pickImage, child: Text("From Gallery")),
          ElevatedButton(onPressed: pickCamera, child: Text("From Camera")),
          SizedBox(
            height: 50,
          ),
          image != null
              ? Padding(
                  padding: const EdgeInsets.only(left: 30.0, right: 30.0),
                  child: Row(
                    children: [
                      Expanded(
                          child: ElevatedButton(
                              onPressed: uploadKYC, child: Text("Submit"))),
                    ],
                  ),
                )
              : Row(),
        ],
      )),
    );
  }
}
