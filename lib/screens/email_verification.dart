import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'chats.dart';

final auth = FirebaseAuth.instance;

class VerifyEmail extends StatefulWidget {
  @override
  State<VerifyEmail> createState() => _VerifyEmailState();
}

Future sendVerificationEmail() async {
  final user = auth.currentUser!;
  await user.sendEmailVerification();
}

class _VerifyEmailState extends State<VerifyEmail> {
  @override
  void initState() {
    super.initState();
    bool isEmailVerified = auth.currentUser!.emailVerified;

    if (!isEmailVerified) {
      sendVerificationEmail();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(
        "Email verification",
        style: TextStyle(
          color: Theme.of(context).textTheme.bodyText2!.color,
        ),
      )),
      body: Container(
        child: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(50.0),
              child: Text(
                "Email has been sent to email you've provided. Click the link  in there",
                style: TextStyle(
                    color: Theme.of(context).textTheme.bodyText1!.color),
              ),
            ),
          ],
        )),
      ),
    );
  }
}
