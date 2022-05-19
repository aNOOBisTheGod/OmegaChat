import 'package:flutter/material.dart';
import 'package:omegachat/screens/email_verification.dart';
import 'package:omegachat/screens/chats.dart';
import '../widgets/text_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';

final auth = FirebaseAuth.instance;
final storage = FirebaseFirestore.instance;

Future<void> createAccount(context, String username, String email,
    String password, File? image) async {
  // ignore: avoid_single_cascade_in_expression_statements
  auth.createUserWithEmailAndPassword(email: email, password: password)
    ..then((value) async {
      String avatarUrl = "";
      if (image != null) {
        final storageRef = FirebaseStorage.instance.ref();
        final avatarRef = storageRef.child(auth.currentUser!.uid);
        await avatarRef.putFile(image).then((p0) async {
          avatarUrl = await avatarRef.getDownloadURL();
        });
      }
      final User user = await auth.currentUser!;
      final uid = user.uid;
      storage.collection('users').doc(uid).set({
        "username": username,
        "email": email,
        "password": password,
        "chats": {},
        "avatar_url": avatarUrl
      }).then((value) => Navigator.of(context).pushReplacement(
          new MaterialPageRoute(builder: (context) => ChatsPage())));
    });
}

class CreateAccountScreen extends StatefulWidget {
  @override
  State<CreateAccountScreen> createState() => _CreateAccountScreenState();
}

class _CreateAccountScreenState extends State<CreateAccountScreen> {
  TextEditingController usernameController = new TextEditingController();

  TextEditingController emailController = new TextEditingController();

  TextEditingController passwordController = new TextEditingController();

  File? _image;

  _getFromGallery() async {
    PickedFile? pickedFile = await ImagePicker().getImage(
      source: ImageSource.gallery,
      maxWidth: 1800,
      maxHeight: 1800,
    );
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Omega Chat"),
          automaticallyImplyLeading: false,
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            createAccount(context, usernameController.text,
                emailController.text, passwordController.text, _image);
          },
          child: Icon(Icons.create),
        ),
        body: SingleChildScrollView(
          child: Container(
            child: Center(
                child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 40.0, top: 40),
                    child: Stack(
                      clipBehavior: Clip.none,
                      children: [
                        CircleAvatar(
                            radius: MediaQuery.of(context).size.height * .2,
                            backgroundImage: _image == null
                                ? NetworkImage(
                                    "https://cdn.pixabay.com/photo/2017/08/27/20/53/fishing-2687481_960_720.jpg")
                                : FileImage(_image!) as ImageProvider<Object>),
                        Positioned(
                          top: MediaQuery.of(context).size.height * .3,
                          left: MediaQuery.of(context).size.height * .3,
                          child: TextButton(
                              style: TextButton.styleFrom(
                                  backgroundColor: Colors.white,
                                  shape: CircleBorder(),
                                  padding: EdgeInsets.all(
                                      MediaQuery.of(context).size.height *
                                          .02)),
                              child: Icon(
                                Icons.image,
                                color: Colors.black,
                                size: MediaQuery.of(context).size.height * .05,
                              ),
                              onPressed: _getFromGallery),
                        ),
                      ],
                    ),
                  ),
                  MainTextField(
                      controller: usernameController,
                      hintText: "Insert your username"),
                  MainTextField(
                      controller: emailController,
                      hintText: "Insert your e-mail"),
                  MainTextField(
                      controller: passwordController,
                      hintText: "Insert your password"),
                ],
              ),
            )),
          ),
        ));
  }
}
