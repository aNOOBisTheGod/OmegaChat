import 'package:flutter/material.dart';
import 'package:omegachat/screens/chats.dart';
import 'package:omegachat/widgets/text_field.dart';
import 'package:firebase_auth/firebase_auth.dart';

final auth = FirebaseAuth.instance;

class LogInAccount extends StatelessWidget {
  TextEditingController emailContoller = new TextEditingController();
  TextEditingController passwordContoller = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Omega Chat"),
      ),
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.login),
          onPressed: () => auth
              .signInWithEmailAndPassword(
                  email: emailContoller.text, password: passwordContoller.text)
              .then((value) => Navigator.of(context).pushReplacement(
                  new MaterialPageRoute(builder: (context) => ChatsPage())))),
      body: Container(
        child: Center(
            child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              MainTextField(
                  controller: emailContoller, hintText: "Insert Email"),
              MainTextField(
                  controller: passwordContoller, hintText: "Insert Password")
            ],
          ),
        )),
      ),
    );
  }
}
