import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:omegachat/models/omega_user.dart';
import 'package:omegachat/screens/chat.dart';
import 'package:omegachat/widgets/app_drawer.dart';
import 'package:omegachat/widgets/user_card.dart';

final auth = FirebaseAuth.instance;
final storage = FirebaseFirestore.instance;

class ChatsPage extends StatefulWidget {
  static const routeName = '/chats';
  const ChatsPage({Key? key}) : super(key: key);

  @override
  State<ChatsPage> createState() => _ChatsPageState();
}

class _ChatsPageState extends State<ChatsPage> {
  int counter = 0;
  OmegaUser? user;
  bool _loading = true;
  List<OmegaUser> chats = [];
  @override
  void initState() {
    getData();
    super.initState();
  }

  Future getData() async {
    String uid = auth.currentUser!.uid;
    var doc = await storage.collection('users').doc(uid).get();
    user = OmegaUser.fromJson(uid, doc.data()!);
    if (user!.chats.length == 0) {
      setState(() {
        _loading = false;
      });
      return;
    }
    user!.chats.forEach((key, value) async {
      chats.add(await OmegaUser.fromId(key));
      if (user!.chats.length == chats.length)
        setState(() {
          _loading = false;
        });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
            onPressed: () => setState(() {
                  print(chats);
                })),
        appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
              icon: Icon(Icons.menu)),
          backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
          centerTitle: true,
          title: Text(
            "Omega Chat",
            style:
                TextStyle(color: Theme.of(context).textTheme.bodyText2!.color),
          ),
        ),
        body: _loading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : chats.length != 0
                ? Container(
                    child: ListView.builder(
                        itemCount: chats.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: UserCard(
                                onClick: () {
                                  Navigator.of(context)
                                      .push(new MaterialPageRoute(
                                          builder: ((context) => ChatScreen(
                                                chatId: user!
                                                    .chats[chats[index].id],
                                                userId: chats[index].id,
                                              ))));
                                },
                                imageUrl: chats[index].avatarUrl,
                                username: chats[index].username),
                          );
                        }))
                : Padding(
                    padding: const EdgeInsets.all(70.0),
                    child: Center(
                      child: Text(
                        "So empty in here... Try to add chat(swipe to the right)",
                        style: TextStyle(
                            color:
                                Theme.of(context).textTheme.bodyText1!.color),
                      ),
                    ),
                  ));
  }
}
