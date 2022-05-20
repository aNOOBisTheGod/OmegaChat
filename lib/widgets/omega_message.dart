import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:omegachat/models/message.dart';

final auth = FirebaseAuth.instance;

class OmegaMessage extends StatelessWidget {
  Message message;
  OmegaMessage({required this.message});

  @override
  Widget build(BuildContext context) {
    return auth.currentUser!.uid == message.senderId
        ? Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                color: Colors.amber,
                child: Text(message.content),
              ),
            ],
          )
        : Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                color: Colors.green,
                child: Text(message.content),
              ),
            ],
          );
  }
}
