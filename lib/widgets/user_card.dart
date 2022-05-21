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
          color: Theme.of(context).cardColor,
        ),
        child: Row(children: [
          CircleAvatar(
            radius: 30,
            backgroundImage: imageUrl == ""
                ? NetworkImage(
                    "https://firebasestorage.googleapis.com/v0/b/omegachat-d6870.appspot.com/o/main.jpg?alt=media&token=e6820f66-807d-4611-9e1f-f93b4bfedb4e")
                : NetworkImage(imageUrl),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width * .1,
          ),
          Text(
            username,
            style:
                TextStyle(color: Theme.of(context).textTheme.bodyText2!.color),
          ),
        ]),
      ),
    );
  }
}
