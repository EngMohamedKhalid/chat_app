import 'package:chat_app/modules/photo_module/photo_view_screen.dart';
import 'package:chat_app/shared/styles/colors.dart';
import 'package:chat_app/models/message_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_bubble/bubble_type.dart';
import 'package:flutter_chat_bubble/chat_bubble.dart';
import 'package:flutter_chat_bubble/clippers/chat_bubble_clipper_5.dart';
class CustomFriendChatBubble extends StatelessWidget {
  CustomFriendChatBubble({Key? key, required this.message, }) : super(key: key);
  final Message message;
  final String amPm= DateTime.now().hour<12?"Am" :"Pm" ;
  final  time1 = DateTime.now().hour.remainder(12)==0?DateTime.now().hour.remainder(12)+12:DateTime.now().hour.remainder(12);
  final  time2 = DateTime.now().minute;
  @override
  Widget build(BuildContext context) {
    return
      Align(
          alignment: Alignment.centerLeft,
          child:
          message.message.contains("https://firebasestorage.googleapis.com/v0/b/socialapp-c4833.appspot.com/o/images")?

          ChatBubble(
            clipper: ChatBubbleClipper5(type: BubbleType.receiverBubble),
            alignment: Alignment.topLeft,
            margin:const EdgeInsets.only(top: 20,right: 10,left: 10,bottom: 20),
            backGroundColor: Colors.white,
            child: Container(
              constraints: BoxConstraints(
                maxWidth: MediaQuery.of(context).size.width * 0.7,
              ),
              child: InkWell(
                onTap: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => PhotoView(path: message.message,),)
                  );
                },
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.network(
                    message.message,
                  ),
                ),
              ),
            ),
          )
              :
          message.message.contains("https://firebasestorage.googleapis.com/v0/b/socialapp-c4833.appspot.com/o/videos")?

          ChatBubble(
            clipper: ChatBubbleClipper5(type: BubbleType.receiverBubble),
            alignment: Alignment.topLeft,
            margin:const EdgeInsets.only(top: 20,right: 10,left: 10,bottom: 20),
            backGroundColor: Colors.white,
            child: Container(
              constraints: BoxConstraints(
                maxWidth: MediaQuery.of(context).size.width * 0.7,
              ),
              child: InkWell(
                onTap: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => PhotoView(path: message.message,),)
                  );
                },
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.asset(
                    "assets/images/vid.jpg",
                  ),
                ),
              ),
            ),
          )
              :
          ChatBubble(
            clipper: ChatBubbleClipper5(type: BubbleType.receiverBubble),
            alignment: Alignment.topLeft,
            margin:const EdgeInsets.only(top: 20,right: 10,left: 10,bottom: 20),
            backGroundColor: Colors.white,
            child: Container(
              constraints: BoxConstraints(
                maxWidth: MediaQuery.of(context).size.width * 0.7,
              ),
              child: Text(
                message.message,
                style: TextStyle(color: kPrimaryColor2 ,fontSize: 20),
              ),
            ),
          )
      );
  }
}