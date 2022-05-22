import 'package:flutter/material.dart';
import 'package:omegachat/models/theme.dart';
import 'package:omegachat/themes/themes_json.dart';
import 'package:omegachat/widgets/app_drawer.dart';
import 'package:omegachat/widgets/theme_chooser.dart';
import 'package:provider/provider.dart';

class UserSettings extends StatefulWidget {
  static const routeName = "/userSettings";
  const UserSettings({Key? key}) : super(key: key);

  @override
  State<UserSettings> createState() => _UserSettingsState();
}

class _UserSettingsState extends State<UserSettings> {
  @override
  Widget build(BuildContext context) {
    // return Consumer<ThemeModel>(
    //     builder: (context, ThemeModel themeNotifier, child) {
    return Scaffold(
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
