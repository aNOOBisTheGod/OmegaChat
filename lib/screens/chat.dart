import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import '../models/message.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:math';

final storage = FirebaseFirestore.instance;
final auth = FirebaseAuth.instance;
const _chars = 'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
Random _rnd = Random();
String getRandomString(int length) => String.fromCharCodes(Iterable.generate(
    length, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))));

Future<void> writeMessage(String chatId, content) async {
  var chat = await storage.collection('chats').doc(chatId).get();
  List messages = chat.data()!["messages"];
  Message message = new Message(
      id: getRandomString(20),
      dateTime: DateTime.now(),
      senderId: auth.currentUser!.uid,
      content: content);
  ;
  messages.add(message.toJson());
  storage.collection('chats').doc(chatId).update({"messages": messages});
}

class ChatScreen extends StatefulWidget {
  String chatId;
  ChatScreen({required this.chatId});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () =>
            writeMessage(widget.chatId, "yay this shit works fine))"),
      ),
      appBar: AppBar(
        title: Text("Omega Chat"),
        centerTitle: true,
      ),
      body: StreamBuilder(
          stream: storage.collection('chats').doc(widget.chatId).snapshots(),
          builder: (BuildContext ctx, AsyncSnapshot snapShot) {
            if (!snapShot.hasData) {
              return Center(
                child: Text("Nothing here"),
              );
            } else {
              return ListView(
                  children: List.from(snapShot.data["messages"]
                      .map((message) => Text(message["content"]))));
            }
          }),
    );
  }
}
