import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class PasswordRecoveryWidget extends StatefulWidget {
  const PasswordRecoveryWidget({Key? key}) : super(key: key);

  @override
  State<PasswordRecoveryWidget> createState() => _PasswordRecoveryWidgetState();
}

class _PasswordRecoveryWidgetState extends State<PasswordRecoveryWidget> {
  final emailController = TextEditingController();

  String notify = "";

  void successful() {
    setState(() {
      notify = "You will receive an email, you might find it on spam";
    });
  }

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(children: [
            const Text(
              "Reset your passwordff", 
              style: TextStyle(fontSize: 30),
            ),
            const SizedBox(
              height: 50,
            ),
            Text(notify),
            TextField(
              controller: emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(hintText: "Email"),
            ),
            Row(
              children: [
                Expanded(
                    child: ElevatedButton(
                  onPressed: () {
                    FirebaseAuth.instance
                        .sendPasswordResetEmail(
                            email: emailController.text.trim())
                        .then((value) {
                      successful();
                    });
                  },
                  child: Text("Submit"),
                ))
              ],
            )
          ]),
        ),
      )),
    );
  }
}
