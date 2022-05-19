import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:omegachat/models/user.dart';
import 'package:omegachat/screens/chat.dart';
import 'package:omegachat/widgets/app_drawer.dart';

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
          centerTitle: true,
          title: Text("Omega Chat"),
        ),
        drawer: AppDrawer(),
        body: _loading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : chats.length != 0
                ? Container(
                    child: ListView.builder(
                        itemCount: chats.length,
                        itemBuilder: (context, index) {
                          return RawMaterialButton(
                            onPressed: () => Navigator.of(context).push(
                                new MaterialPageRoute(
                                    builder: ((context) => ChatScreen(
                                        chatId:
                                            user!.chats[chats[index].id])))),
                            child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [Text(chats[index].username)]),
                          );
                        }))
                : Padding(
                    padding: const EdgeInsets.all(70.0),
                    child: Center(
                      child: Text(
                          "So empty in here... Try to add chat(swipe to the right)"),
                    ),
                  ));
  }
}
