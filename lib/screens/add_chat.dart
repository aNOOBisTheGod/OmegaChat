import 'package:flutter/material.dart';
import 'package:omegachat/screens/chat.dart';
import 'package:omegachat/widgets/app_drawer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:omegachat/widgets/user_card.dart';

final storage = FirebaseFirestore.instance;
final auth = FirebaseAuth.instance;

Future<String?> addChatWithUser(String id) async {
  User? user = auth.currentUser;
  var doc = await storage.collection('users').doc(user!.uid).get();
  Map<String, Object> newDict = Map.from(doc["chats"]);
  if (newDict[id] != null) {
    return newDict[id] as String;
  }
  QuerySnapshot querySnapshot = await storage.collection('chats').get();
  String lastChatId = (querySnapshot.docs.length + 1).toString();
  storage.collection('chats').doc(lastChatId).set({
    "users": [id, user.uid],
    "messages": []
  });
  newDict[id] = lastChatId;
  storage.collection('users').doc(user.uid).update({"chats": newDict});
  doc = await storage.collection('users').doc(id).get();
  newDict = Map.from(doc["chats"]);
  newDict[user.uid] = lastChatId;
  storage.collection('users').doc(id).update({"chats": newDict});
  return lastChatId;
}

class AddChat extends StatefulWidget {
  static const routeName = '/addChat';
  const AddChat({Key? key}) : super(key: key);

  @override
  State<AddChat> createState() => _AddChatState();
}

class _AddChatState extends State<AddChat> {
  List? allData;
  bool _loading = true;

  @override
  void initState() {
    getData().then((value) {
      setState(() {
        _loading = false;
      });
    });
    super.initState();
  }

  Future<void> getData() async {
    QuerySnapshot querySnapshot = await storage.collection('users').get();
    allData = querySnapshot.docs;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
              icon: Icon(Icons.menu)),
          title: Text(
            "Add chat",
            style:
                TextStyle(color: Theme.of(context).textTheme.bodyText2!.color),
          ),
          centerTitle: true,
        ),
        body: _loading
            ? Center(child: CircularProgressIndicator())
            : Container(
                child: ListView.builder(
                itemCount: allData!.length,
                itemBuilder: ((context, index) => UserCard(
                      imageUrl: allData![index].data()["avatar_url"],
                      username: allData![index].data()["username"],
                      onClick: () async {
                        String? chatId =
                            await addChatWithUser(allData![index].id);
                        Navigator.of(context).push(new MaterialPageRoute(
                            builder: (context) => ChatScreen(
                                userId: allData![index].id, chatId: chatId!)));
                      },
                    )),
              )));
  }
}
