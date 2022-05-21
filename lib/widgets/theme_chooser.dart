import 'package:flutter/material.dart';
import 'package:omegachat/themes/themes_json.dart';
import 'package:provider/provider.dart';
import '../models/theme.dart';

class ThemeChooser extends StatelessWidget {
  int themeId;
  ThemeChooser({required this.themeId});

  @override
  Widget build(BuildContext context) {
    ThemeData theme = themesJson[themeId]!["theme"];
    return Consumer<ThemeModel>(
        builder: (context, ThemeModel themeNotifier, child) {
      return GestureDetector(
        onTap: () {
          if (themeNotifier.themeIndex == themeId) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(
                "Theme ${themesJson[themeId]!["name"]} is already in use",
                style: TextStyle(
                    color: Theme.of(context).textTheme.bodyText2!.color),
              ),
              duration: Duration(seconds: 1),
            ));
            return;
          }
          themeNotifier.themeIndex = themeId;
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(
              "Theme ${themesJson[themeId]!["name"]} has been setted up",
              style: TextStyle(
                  color: Theme.of(context).textTheme.bodyText2!.color),
            ),
            duration: Duration(seconds: 1),
          ));
        },
        child: Container(
          alignment: Alignment.center,
          child: Text(
            themesJson[themeId]!["name"],
            style: TextStyle(
                color: Theme.of(context).textTheme.bodyText1!.color,
                fontWeight: FontWeight.w700),
          ),
          color: theme.cardColor,
          width: 100,
          height: 100,
        ),
      );
    });
  }
}
