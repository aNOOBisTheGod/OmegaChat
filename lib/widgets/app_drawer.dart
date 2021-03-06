import 'package:flutter/material.dart';
import 'package:omegachat/screens/add_chat.dart';
import 'package:omegachat/screens/chats.dart';
import 'package:omegachat/screens/choose_entry_method.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:omegachat/screens/settings.dart';

final auth = FirebaseAuth.instance;

class AppDrawer extends StatefulWidget {
  var changePage;
  AppDrawer({required this.changePage});
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
      backgroundColor: Theme.of(context).drawerTheme.backgroundColor,
      child: Column(children: [
        Stack(
          children: [
            FadeInImage(
                image: NetworkImage(user!.photoURL!),
                placeholder: AssetImage("assets/images/main.jpg")),
            Padding(
              padding: const EdgeInsets.only(left: 10, top: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Omega Chat",
                    style: TextStyle(
                        color: Theme.of(context).textTheme.bodyText1!.color),
                  ),
                  Text(
                    user!.email!,
                    style: TextStyle(
                        color: Theme.of(context).textTheme.bodyText1!.color),
                  ),
                ],
              ),
            )
          ],
        ),
        RawMaterialButton(
          onPressed: () {
            // if (ModalRoute.of(context)!.settings.name != ChatsPage.routeName)
            //   Navigator.of(context).pushReplacementNamed(ChatsPage.routeName);
            // else
            widget.changePage(ChatsPage());
            Navigator.of(context).pop();
          },
          child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            Icon(Icons.message_outlined),
            Text(
              "Chats",
              style: TextStyle(
                  color: Theme.of(context).textTheme.bodyText2!.color),
            )
          ]),
        ),
        RawMaterialButton(
          onPressed: () {
            // if (ModalRoute.of(context)!.settings.name != AddChat.routeName)
            //   Navigator.of(context).pushReplacementNamed(AddChat.routeName);
            // else
            widget.changePage(AddChat());
            Navigator.of(context).pop();
          },
          child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            Icon(Icons.add),
            Text(
              "Add chat",
              style: TextStyle(
                  color: Theme.of(context).textTheme.bodyText2!.color),
            )
          ]),
        ),
        RawMaterialButton(
          onPressed: () {
            // if (ModalRoute.of(context)!.settings.name != UserSettings.routeName)
            //   Navigator.of(context)
            //       .pushReplacementNamed(UserSettings.routeName);
            // else
            widget.changePage(UserSettings());
            Navigator.of(context).pop();
          },
          child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            Icon(Icons.settings_outlined),
            Text(
              "Settings",
              style: TextStyle(
                  color: Theme.of(context).textTheme.bodyText2!.color),
            )
          ]),
        ),
        RawMaterialButton(
          onPressed: () {
            Navigator.of(context).pushReplacement(new MaterialPageRoute(
                builder: (context) => ChooseEntryMethodScreen()));
          },
          child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            Icon(Icons.logout),
            Text(
              "Log out",
              style: TextStyle(
                  color: Theme.of(context).textTheme.bodyText2!.color),
            )
          ]),
        ),
      ]),
    );
  }
}
