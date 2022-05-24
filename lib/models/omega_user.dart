import 'package:cloud_firestore/cloud_firestore.dart';

final storage = FirebaseFirestore.instance;

class OmegaUser {
  String id;
  String username;
  String email;
  String password;
  String avatarUrl;
  Map chats;
  List? customThemes;
  OmegaUser(
      {required this.id,
      required this.username,
      required this.email,
      required this.password,
      required this.avatarUrl,
      required this.chats,
      this.customThemes});

  factory OmegaUser.fromJson(String id, Map data) {
    return OmegaUser(
        id: id,
        username: data["username"],
        email: data["email"],
        password: data["password"],
        avatarUrl: data["avatar_url"],
        chats: data["chats"],
        customThemes: data['themes']);
  }

  static Future<OmegaUser> fromId(String id) async {
    var user = await storage.collection('users').doc(id).get();
    Map<String, dynamic> newDict = Map.from(user.data()!);
    return OmegaUser(
        id: id,
        username: newDict["username"],
        email: newDict["email"],
        password: newDict["password"],
        avatarUrl: newDict["avatar_url"],
        chats: newDict["chats"],
        customThemes: newDict["themes"]);
  }
}
