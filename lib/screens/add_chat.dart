import 'package:flutter/material.dart';
import 'package:omegachat/widgets/app_drawer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

final storage = FirebaseFirestore.instance;
final auth = FirebaseAuth.instance;

Future<void> addChatWithUser(String id) async {
  User? user = auth.currentUser;
  var doc = await storage.collection('users').doc(user!.uid).get();
  Map<String, Object> newDict = Map.from(doc["chats"]);
  if (newDict[id] != null) {
    return;
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
        title: Text("Add chat"),
        centerTitle: true,
      ),
      drawer: AppDrawer(),
      body: _loading
          ? Center(child: CircularProgressIndicator())
          : Container(
              child: ListView.builder(
                  itemCount: allData!.length,
                  itemBuilder: ((context, index) => RawMaterialButton(
                        onPressed: () => addChatWithUser(allData![index].id),
                        child: Text(allData![index].data()["username"]),
                      ))),
            ),
    );
  }
}
