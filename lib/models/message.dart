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
}
