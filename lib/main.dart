import 'package:flutter/material.dart';
import 'package:omegachat/screens/add_chat.dart';
import 'package:omegachat/screens/chats.dart';
import 'package:omegachat/screens/choose_entry_method.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:omegachat/screens/settings.dart';
import 'package:provider/provider.dart';
import 'models/theme.dart';
import 'themes/themes_list.dart';
import 'themes/themes_json.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (_) => ThemeModel(),
        child: Consumer<ThemeModel>(
            builder: (context, ThemeModel themeNotifier, child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Omega Chat',
            home: auth.currentUser == null
                ? ChooseEntryMethodScreen()
                : ChatsPage(),
            theme: themesJson[themeNotifier.themeIndex]["theme"],
            routes: {
              ChatsPage.routeName: (context) => ChatsPage(),
              AddChat.routeName: (context) => AddChat(),
              UserSettings.routeName: (context) => UserSettings()
            },
          );
        }));
  }
}
