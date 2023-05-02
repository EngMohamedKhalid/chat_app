import 'package:chat_app/modules/chats_module/group_chat_screen.dart';
import 'package:chat_app/models/message_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class GroupScreen extends StatelessWidget {
  const GroupScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:InkWell(
        onTap: () {
          // Navigator.of(context).push(
          //     MaterialPageRoute(
          //         builder: (context) =>  GroupChatScreen()
          //     )
         // );
        },
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            children:const [
              CircleAvatar(
                backgroundImage: null,
                radius: 32,
              ),
              SizedBox(width: 20,),
              Text(
                "Our tiny castle 🏰🔥" ,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 17
                ),
              )
            ],
          ),
        ),
      )
    );
  }
}
