import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:taralets/widgets/profile/profile_picture_edit_widget.dart';

class ProfilePictureView extends StatefulWidget {
  final String profileURL;
  const ProfilePictureView({Key? key, required this.profileURL})
      : super(key: key);

  @override
  State<ProfilePictureView> createState() => _ProfilePictureViewState();
}

class _ProfilePictureViewState extends State<ProfilePictureView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Profile"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Image.network(
              widget.profileURL,
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 50, left: 10, right: 10),
              child: Row(
                children: [
                  Expanded(
                      child: ElevatedButton(
                    child: Text("Edit Profile"),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  ProfilePictureEditWidget()));
                    },
                  ))
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
