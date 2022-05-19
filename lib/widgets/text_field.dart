import 'package:flutter/material.dart';

class MainTextField extends StatelessWidget {
  TextEditingController controller;
  String hintText;
  MainTextField({required this.controller, required this.hintText});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: this.controller,
      decoration: InputDecoration(hintText: this.hintText),
    );
  }
}
