import 'package:flutter/material.dart';
import 'package:omegachat/screens/chats.dart';
import 'package:omegachat/screens/create_account.dart';
import 'package:omegachat/screens/login.dart';
import 'package:firebase_auth/firebase_auth.dart';

final auth = FirebaseAuth.instance;

class ChooseEntryMethodScreen extends StatelessWidget {
  const ChooseEntryMethodScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Omega Chat")),
      body: Container(
          child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            RawMaterialButton(
              onPressed: () => Navigator.of(context).push(
                  new MaterialPageRoute(builder: (context) => LogInAccount())),
              child: Text("Log In"),
            ),
            RawMaterialButton(
              onPressed: () => Navigator.of(context).push(new MaterialPageRoute(
                  builder: (context) => CreateAccountScreen())),
              child: Text("Sign Up"),
            )
          ],
        ),
      )),
    );
  }
}
