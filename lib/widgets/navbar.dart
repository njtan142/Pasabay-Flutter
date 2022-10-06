import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:taralets/widgets/kyc_widget.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:taralets/widgets/profile/profile_picture_view_widget.dart';

class NavBarWidget extends StatefulWidget {
  const NavBarWidget({Key? key}) : super(key: key);

  @override
  State<NavBarWidget> createState() => _NavBarWidgetState();
}

class _NavBarWidgetState extends State<NavBarWidget> {
  @override
  Widget build(BuildContext context) {
    CollectionReference users = FirebaseFirestore.instance.collection('users');
    return FutureBuilder<DocumentSnapshot>(
      future: users.doc(FirebaseAuth.instance.currentUser!.uid).get(),
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          Map<String, dynamic> data =
              snapshot.data!.data() as Map<String, dynamic>;
          return Drawer(
              child: ListView(
            padding: const EdgeInsets.all(0),
            children: [
              UserAccountsDrawerHeader(
                  decoration: const BoxDecoration(
                    color: Colors.black,
                  ),
                  currentAccountPicture: GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ProfilePictureView(
                                profileURL: data['profile_url'] != null
                                    ? data['profile_url']
                                    : "https://t3.ftcdn.net/jpg/03/46/83/96/360_F_346839683_6nAPzbhpSkIpb8pmAwufkC7c5eD7wYws.jpg"),
                          ));
                    },
                    child: CircleAvatar(
                        child: ClipOval(
                      child: data['profile_url'] == null
                          ? Image.network(
                              "https://t3.ftcdn.net/jpg/03/46/83/96/360_F_346839683_6nAPzbhpSkIpb8pmAwufkC7c5eD7wYws.jpg",
                              fit: BoxFit.cover,
                            )
                          : Image.network(
                              data['profile_url'],
                              fit: BoxFit.cover,
                              width: 100,
                              height: 100,
                            ),
                    )),
                  ),
                  accountName:
                      Text(data['first_name'] + " " + data['last_name']),
                  accountEmail:
                      Text(FirebaseAuth.instance.currentUser!.email!)),
              const ListTile(
                leading: Icon(Icons.map_outlined),
                title: Text("Open Maps"),
              ),
              ListTile(
                leading: const Icon(Icons.cloud_upload_outlined),
                title: const Text("Upload KYC"),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => KYCWidget(
                          id: snapshot.data!.id,
                        ),
                      ));
                },
              ),
              const ListTile(
                leading: Icon(Icons.edit_note_outlined),
                title: Text("Edit Profile"),
              ),
              ListTile(
                leading: const Icon(Icons.exit_to_app),
                title: const Text("Logout"),
                onTap: () {
                  FirebaseAuth.instance.signOut();
                },
              ),
            ],
          ));
        }
        return const Drawer(
          child: Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }
}
