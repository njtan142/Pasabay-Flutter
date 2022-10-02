import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final user = FirebaseAuth.instance.currentUser!;
  Map<String, dynamic> userData = {'first_name': ""};

  @override
  void initState() {
    // TODO: implement initState
    FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .get()
        .then((value) {
      setState(() {
        userData = value.data() as Map<String, dynamic>;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Pasabay"),
        actions: [
          ElevatedButton(
              onPressed: () {
                FirebaseAuth.instance.signOut();
              },
              child: const Text("Logout"))
        ],
      ),
      body: Center(
          child: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          children: [
            Text(
              "Welcome ${userData['first_name']}",
              style: TextStyle(fontSize: 30),
            ),
          ],
        ),
      )),
      floatingActionButton: SpeedDial(
        animatedIcon: AnimatedIcons.menu_close,
        animatedIconTheme: IconThemeData(size: 22),
        visible: true,
        curve: Curves.bounceIn,
        children: [
          // FAB 1
          SpeedDialChild(
            child: Icon(Icons.upload),
            onTap: () {/* do anything */},
            label: 'Upload KYC',
            labelStyle: TextStyle(fontWeight: FontWeight.w500, fontSize: 16.0),
          ),
          // FAB 2
          SpeedDialChild(
            child: Icon(Icons.edit_note),
            label: 'Edit Profile',
            labelStyle: TextStyle(fontWeight: FontWeight.w500, fontSize: 16.0),
          ),
          SpeedDialChild(
            child: Icon(Icons.map),
            label: 'Open Maps',
            labelStyle: TextStyle(fontWeight: FontWeight.w500, fontSize: 16.0),
          )
        ],
      ),
    );
  }
}
