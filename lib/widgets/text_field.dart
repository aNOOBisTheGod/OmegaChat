import 'package:flutter/material.dart';

class MainTextField extends StatelessWidget {
  TextEditingController controller;
  String hintText;
  MainTextField({required this.controller, required this.hintText});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: this.controller,
      cursorColor: Theme.of(context).primaryColor,
      decoration: InputDecoration(
          hintText: this.hintText,
          fillColor: Theme.of(context).primaryColor,
          focusColor: Theme.of(context).primaryColor,
          hoverColor: Theme.of(context).primaryColor),
    );
  }
}
