import 'package:flutter/material.dart';
import 'package:omegachat/screens/add_chat.dart';
import 'package:omegachat/screens/chats.dart';
import 'package:omegachat/widgets/app_drawer.dart';

class OmegaHomePage extends StatefulWidget {
  @override
  State<OmegaHomePage> createState() => _OmegaHomePageState();
}

class _OmegaHomePageState extends State<OmegaHomePage> {
  Widget currentPage = ChatsPage();

  void changePage(Widget route) {
    setState(() {
      currentPage = route;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: AppDrawer(
        changePage: changePage,
      ),
      body: currentPage,
    );
  }
}
