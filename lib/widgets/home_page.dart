import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:taralets/widgets/navbar.dart';

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
    print(user.uid);
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
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavBarWidget(),
      appBar: AppBar(
        title: const Text("Pasabay"),
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
    );
  }
}
