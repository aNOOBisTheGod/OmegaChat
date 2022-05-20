import 'package:cloud_firestore/cloud_firestore.dart';

class Message {
  String id;
  DateTime dateTime;
  String senderId;
  String content;
  Message(
      {required this.id,
      required this.dateTime,
      required this.senderId,
      required this.content});

  Map<String, dynamic> toJson() {
    return {
      "id": this.id,
      "date_time": this.dateTime,
      "sender_id": this.senderId,
      "content": this.content
    };
  }

  factory Message.fromJson(Map message) {
    return Message(
        id: message["id"],
        dateTime: (message['date_time'] as Timestamp).toDate(),
        senderId: message["sender_id"],
        content: message["content"]);
  }
}
