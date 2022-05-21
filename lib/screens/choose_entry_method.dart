import 'package:flutter/material.dart';
import 'package:omegachat/screens/chats.dart';
import 'package:omegachat/screens/create_account.dart';
import 'package:omegachat/screens/login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import '../models/theme.dart';

final auth = FirebaseAuth.instance;

class ChooseEntryMethodScreen extends StatefulWidget {
  static const routeName = "/chooseEntryMethod";
  const ChooseEntryMethodScreen({Key? key}) : super(key: key);

  @override
  State<ChooseEntryMethodScreen> createState() =>
      _ChooseEntryMethodScreenState();
}

class _ChooseEntryMethodScreenState extends State<ChooseEntryMethodScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Omega Chat",
          style: TextStyle(color: Theme.of(context).textTheme.bodyText2!.color),
        ),
      ),
      body: Container(
          child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            RawMaterialButton(
              onPressed: () => Navigator.of(context).push(
                  new MaterialPageRoute(builder: (context) => LogInAccount())),
              child: Text(
                "Log In",
                style: TextStyle(
                    color: Theme.of(context).textTheme.bodyText1!.color),
              ),
            ),
            RawMaterialButton(
              onPressed: () => Navigator.of(context).push(new MaterialPageRoute(
                  builder: (context) => CreateAccountScreen())),
              child: Text(
                "Sign Up",
                style: TextStyle(
                    color: Theme.of(context).textTheme.bodyText1!.color),
              ),
            )
          ],
        ),
      )),
    );
  }
}
