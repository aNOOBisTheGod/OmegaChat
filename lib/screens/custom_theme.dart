import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:omegachat/widgets/color_editor.dart';
import 'package:omegachat/widgets/text_field.dart';

final storage = FirebaseFirestore.instance;
final auth = FirebaseAuth.instance;

extension Convert on ThemeData {
  Map<String, dynamic> toJson(String name) {
    return {
      "name": name,
      'appBar': this.appBarTheme.backgroundColor.toString(),
      'scaffold': this.scaffoldBackgroundColor.toString(),
      'drawer': this.drawerTheme.backgroundColor.toString(),
      'buttons': this.accentColor.toString(),
      'messageSent': this.primaryColorDark.toString(),
      'messageReceived': this.primaryColorLight.toString(),
      'textField': this.primaryColor.toString(),
      'userCard': this.cardColor.toString(),
    };
  }
}

class CustomThemePage extends StatefulWidget {
  static const routeName = '/customThemePage';
  const CustomThemePage({Key? key}) : super(key: key);

  @override
  State<CustomThemePage> createState() => _CustomThemePageState();
}

Future<void> createTheme(
    String themeName,
    Color? appbarColor,
    Color? scaffoldBackground,
    Color? drawerColor,
    Color? buttonsColor,
    Color? messageSent,
    Color? messageReceive,
    Color? textFieldColor,
    Color? userCardColor) async {
  var doc = await storage.collection('users').doc(auth.currentUser!.uid).get();
  List themes = [];
  try {
    themes = doc["themes"];
  } catch (e) {}
  Map<String, dynamic> theme = new ThemeData(
          appBarTheme: AppBarTheme(backgroundColor: appbarColor),
          accentColor: buttonsColor,
          scaffoldBackgroundColor: scaffoldBackground,
          cardColor: userCardColor,
          drawerTheme: DrawerThemeData(backgroundColor: drawerColor),
          primaryColorDark: messageSent,
          primaryColorLight: messageReceive,
          primaryColor: textFieldColor)
      .toJson(themeName);
  themes.add(theme);
  storage
      .collection('users')
      .doc(auth.currentUser!.uid)
      .update({"themes": themes});
}

class _CustomThemePageState extends State<CustomThemePage> {
  TextEditingController _nameController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    ColorEditor appBarColorEditor = ColorEditor(
        "AppBar color", Theme.of(context).appBarTheme.backgroundColor!);
    ColorEditor scaffoldBackgroundColorEditor = ColorEditor(
        "Main background color", Theme.of(context).scaffoldBackgroundColor);
    ColorEditor drawerColorEditor = ColorEditor("Drawer background color",
        Theme.of(context).drawerTheme.backgroundColor!);
    ColorEditor buttonsColorEditor =
        ColorEditor("Buttons color", Theme.of(context).accentColor);
    ColorEditor messageSentColorEditor =
        ColorEditor("Message sent color", Theme.of(context).primaryColorDark);
    ColorEditor messageReceivedColorEditor = ColorEditor(
        "Message received color", Theme.of(context).primaryColorLight);
    ColorEditor textFieldColorEditor =
        ColorEditor("Text field color", Theme.of(context).primaryColor);
    ColorEditor userCardColorEditor =
        ColorEditor("User card color", Theme.of(context).cardColor);
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () => createTheme(
            _nameController.text,
            appBarColorEditor.getColor,
            scaffoldBackgroundColorEditor.getColor,
            drawerColorEditor.getColor,
            buttonsColorEditor.getColor,
            messageSentColorEditor.getColor,
            messageReceivedColorEditor.getColor,
            textFieldColorEditor.getColor,
            userCardColorEditor.getColor),
        child: const Icon(Icons.create),
        tooltip: "Create theme",
      ),
      appBar: AppBar(
        title: Text("Create custom theme"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40),
          child: Column(children: [
            MainTextField(
                controller: _nameController, hintText: "Insert name of theme"),
            appBarColorEditor,
            scaffoldBackgroundColorEditor,
            drawerColorEditor,
            buttonsColorEditor,
            messageSentColorEditor,
            messageReceivedColorEditor,
            textFieldColorEditor,
            userCardColorEditor
          ]),
        ),
      ),
    );
  }
}
