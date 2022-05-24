import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:omegachat/models/theme.dart';
import 'package:omegachat/screens/custom_theme.dart';
import 'package:omegachat/themes/themes_json.dart';
import 'package:omegachat/widgets/app_drawer.dart';
import 'package:omegachat/widgets/theme_chooser.dart';
import 'package:provider/provider.dart';

extension ToColor on String {
  Color toColor() {
    return Color(int.parse(this.split('(0x')[1].split(')')[0], radix: 16));
  }
}

final auth = FirebaseAuth.instance;
final storage = FirebaseFirestore.instance;

ThemeData toThemeData(Map<String, String> theme) {
  return ThemeData(
      appBarTheme: AppBarTheme(backgroundColor: theme['appBar']!.toColor()),
      scaffoldBackgroundColor: theme['scaffold']!.toColor(),
      drawerTheme: DrawerThemeData(backgroundColor: theme['drawer']!.toColor()),
      accentColor: theme['buttons']!.toColor(),
      primaryColorDark: theme['messageSent']!.toColor(),
      primaryColorLight: theme['messageReceived']!.toColor(),
      primaryColor: theme['textField']!.toColor(),
      cardColor: theme['userCard']!.toColor());
}

class UserSettings extends StatefulWidget {
  static const routeName = "/userSettings";
  const UserSettings({Key? key}) : super(key: key);

  @override
  State<UserSettings> createState() => _UserSettingsState();
}

class _UserSettingsState extends State<UserSettings> {
  Future<void> fetchCustomThemes() async {
    var doc =
        await storage.collection('users').doc(auth.currentUser!.uid).get();
    List themes = [];
    try {
      themes = List.from(doc["themes"]);
    } catch (e) {}
    print(themes);
    for (var i in themes) {
      bool closer = false;
      themesJson.forEach((key, value) {
        if (value["name"] == i["name"]) {
          closer = true;
        }
      });
      if (!closer)
        themesJson[themesJson.length] = {
          "name": Map.from(i)["name"],
          "theme": toThemeData(Map.from(i))
        };
    }
    setState(() {});
  }

  @override
  void initState() {
    fetchCustomThemes();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () =>
              Navigator.of(context).pushNamed(CustomThemePage.routeName),
          child: Icon(Icons.palette),
        ),
        appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
              icon: Icon(Icons.menu)),
          title: Text(
            "Settings",
            style:
                TextStyle(color: Theme.of(context).textTheme.bodyText2!.color),
          ),
          centerTitle: true,
        ),
        // floatingActionButton: FloatingActionButton(onPressed: () {
        //   themeNotifier.isDark
        //       ? themeNotifier.themeIndex = 1
        //       : themeNotifier.themeIndex = 0;
        // }),
        body: ListView.builder(
          itemBuilder: (context, index) => ThemeChooser(themeId: index),
          itemCount: themesJson.length,
        ));
    // });
  }
}
