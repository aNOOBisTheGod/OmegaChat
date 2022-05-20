import 'package:flutter/material.dart';

class UserCard extends StatelessWidget {
  String imageUrl;
  String username;
  var onClick;
  UserCard({required this.imageUrl, required this.username, this.onClick});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onClick,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.amber,
        ),
        child: Row(children: [
          CircleAvatar(
            radius: 30,
            backgroundImage: imageUrl == ""
                ? NetworkImage(
                    "https://cdn.pixabay.com/photo/2017/08/27/20/53/fishing-2687481_960_720.jpg")
                : NetworkImage(imageUrl),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width * .1,
          ),
          Text(username),
        ]),
      ),
    );
  }
}
