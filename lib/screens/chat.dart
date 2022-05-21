import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:omegachat/widgets/omega_message.dart';
import 'package:omegachat/widgets/text_field.dart';
import '../models/message.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:math';
import '../models/omega_user.dart';

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
  String userId;
  String chatId;
  OmegaUser? receiver;
  bool _loading = true;
  ChatScreen({required this.userId, required this.chatId});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  TextEditingController _messageController = new TextEditingController();

  @override
  void initState() {
    getData();
    super.initState();
  }

  Future<void> getData() async {
    widget.receiver = await OmegaUser.fromId(widget.userId);
    setState(() {
      widget._loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.send),
        onPressed: () {
          writeMessage(widget.chatId, _messageController.text);
          _messageController.text = "";
        },
      ),
      appBar: AppBar(
        title: widget._loading
            ? Text(
                "Omega Chat",
                style: TextStyle(
                    color: Theme.of(context).textTheme.bodyText2!.color),
              )
            : Row(
                children: [
                  CircleAvatar(
                    backgroundImage: NetworkImage(widget.receiver!.avatarUrl),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: Text(
                      widget.receiver!.username,
                      style: TextStyle(
                          color: Theme.of(context).textTheme.bodyText1!.color),
                    ),
                  ),
                ],
              ),
        centerTitle: true,
      ),
      body: widget._loading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Column(
              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                StreamBuilder(
                    stream: storage
                        .collection('chats')
                        .doc(widget.chatId)
                        .snapshots(),
                    builder: (BuildContext ctx, AsyncSnapshot snapShot) {
                      if (!snapShot.hasData) {
                        return Center(
                          child: Text(
                            "Nothing here",
                            style: TextStyle(
                                color: Theme.of(context)
                                    .textTheme
                                    .bodyText1!
                                    .color),
                          ),
                        );
                      } else {
                        return Expanded(
                          child: ListView(
                              children: List.from(snapShot.data["messages"]
                                  .map((message) => OmegaMessage(
                                        message: Message.fromJson(message),
                                      )))),
                        );
                      }
                    }),
                MainTextField(
                    controller: _messageController,
                    hintText: "Insert email content"),
              ],
            ),
    );
  }
}
