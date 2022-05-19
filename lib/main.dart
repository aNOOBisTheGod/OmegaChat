import 'package:flutter/material.dart';
import 'package:omegachat/screens/add_chat.dart';
import 'package:omegachat/screens/chats.dart';
import 'package:omegachat/screens/choose_entry_method.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Omega Chat',
      home: auth.currentUser == null ? ChooseEntryMethodScreen() : ChatsPage(),
      routes: {
        ChatsPage.routeName: (context) => ChatsPage(),
        AddChat.routeName: (context) => AddChat()
      },
    );
  }
}
