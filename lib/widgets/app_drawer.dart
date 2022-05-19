import 'package:flutter/material.dart';
import 'package:omegachat/screens/add_chat.dart';
import 'package:omegachat/screens/chats.dart';
import 'package:omegachat/screens/choose_entry_method.dart';

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(children: [
        Text("Omega Chat"),
        RawMaterialButton(
          onPressed: () {
            Navigator.of(context).pushReplacementNamed(ChatsPage.routeName);
          },
          child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [Icon(Icons.message_outlined), Text("Chats")]),
        ),
        RawMaterialButton(
          onPressed: () {
            Navigator.of(context).pushReplacementNamed(AddChat.routeName);
          },
          child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [Icon(Icons.add), Text("Add chat")]),
        ),
        RawMaterialButton(
          onPressed: () {},
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
