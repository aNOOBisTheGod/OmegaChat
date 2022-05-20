import 'package:flutter/material.dart';
import 'package:omegachat/screens/add_chat.dart';
import 'package:omegachat/screens/chats.dart';
import 'package:omegachat/screens/choose_entry_method.dart';
import 'package:firebase_auth/firebase_auth.dart';

final auth = FirebaseAuth.instance;

class AppDrawer extends StatefulWidget {
  @override
  State<AppDrawer> createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
  User? user;
  @override
  void initState() {
    user = auth.currentUser;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(children: [
        Stack(
          children: [
            Image.network(user!.photoURL!, fit: BoxFit.cover),
            Padding(
              padding: const EdgeInsets.only(left: 10, top: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Omega Chat"),
                  Text(user!.email!),
                ],
              ),
            )
          ],
        ),
        RawMaterialButton(
          onPressed: () {
            if (ModalRoute.of(context)!.settings.name != ChatsPage.routeName)
              Navigator.of(context).pushReplacementNamed(ChatsPage.routeName);
            else
              Navigator.of(context).pop();
          },
          child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [Icon(Icons.message_outlined), Text("Chats")]),
        ),
        RawMaterialButton(
          onPressed: () {
            if (ModalRoute.of(context)!.settings.name != AddChat.routeName)
              Navigator.of(context).pushReplacementNamed(AddChat.routeName);
            else
              Navigator.of(context).pop();
          },
          child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [Icon(Icons.add), Text("Add chat")]),
        ),
        RawMaterialButton(
          onPressed: () {
            print(ModalRoute.of(context)!.settings.name);
          },
          child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [Icon(Icons.settings_outlined), Text("Settings")]),
        ),
        RawMaterialButton(
          onPressed: () {
            Navigator.of(context).pushReplacement(new MaterialPageRoute(
                builder: (context) => ChooseEntryMethodScreen()));
          },
          child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [Icon(Icons.logout), Text("Log out")]),
        ),
      ]),
    );
  }
}
