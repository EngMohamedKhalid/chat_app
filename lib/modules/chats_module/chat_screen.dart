import 'dart:io';
import 'package:chat_app/shared/components/attachments/show_attaches_method.dart';
import 'package:chat_app/shared/components/custom_chat_bubble/custom__me_chat_bubble.dart';
import 'package:chat_app/shared/components/custom_chat_bubble/custom_friend_chat_bubble.dart';
import 'package:chat_app/shared/styles/colors.dart';
import 'package:chat_app/models/message_model.dart';
import 'package:chat_app/shared/network/remote/fire_store/message_store_service.dart';
import 'package:chat_app/modules/profile_module/friend_profile_screen.dart';
import 'package:chat_app/models/take_photo.dart';
import 'package:chat_app/shared/styles/text_style.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key, this.username, this.image,this.id,  this.chatRoomId, this.about,  }) : super(key: key);
 final String? username;
 final String? image;
 final String? id;
 final String? chatRoomId;
 final String? about;
  @override
  State<ChatScreen> createState() => _ChatScreenState();
}
class _ChatScreenState extends State<ChatScreen> {
 final TextEditingController messageController = TextEditingController();
 final controller = ScrollController();
 String? ema = FirebaseAuth.instance.currentUser!.email;
 var messages = FirebaseFirestore.instance;
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream:messages.collection('chatroom').doc(widget.chatRoomId).collection('chats').orderBy('time', descending: true).snapshots(),
        builder: (context, snapshot) {
        switch(snapshot.connectionState) {
          case ConnectionState.none:
            return const Scaffold(
              body: Center(child: Text("None...............",
                  style: TextStyle(
                    fontSize: 42,
                    fontWeight: FontWeight.w400
                  ),
              )
              ),
            );
          case ConnectionState.done:
             return const Scaffold(
               body: Center(child:  Text("done...............",
                 style: TextStyle(
                     fontSize: 42,
                     fontWeight: FontWeight.w400
                 ),
               )),
             );
          case ConnectionState.waiting:
            return const Scaffold(
              body: Center(child: CircularProgressIndicator()),
            );
          case ConnectionState.active :
            if (snapshot.hasData) {
              List <Message> listMessages = [];
              for (int i = 0; i < snapshot.data!.docs.length; i++) {
                listMessages.add(Message.fromJson(snapshot.data!.docs[i]));
              }
              return Scaffold(
                appBar:
                AppBar(
                  backgroundColor: kPrimaryColor2,
                  title: StreamBuilder<DocumentSnapshot>(
                      stream: messages.collection("users").doc(widget.id).snapshots(),
                      builder: (context, snapshot) {
                        if (snapshot.data != null) {
                          return
                            InkWell(
                              onTap: () {
                                Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) => FriendProfileScreen(
                                          friendId: widget.id!
                                      ),
                                    )
                                );
                              },
                              child: Row(
                                children: [
                                  CircleAvatar(
                                    radius: 25,
                                    backgroundImage: NetworkImage(widget.image!,),
                                  ),
                                  const SizedBox(width: 8,),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                       Text(
                                         snapshot.data!["name"],
                                        style: const TextStyle(
                                            fontSize: 22,
                                            fontWeight: FontWeight.w400
                                        ),
                                      ),
                                        snapshot.data!["status"]=="Online"?
                                       Text(
                                         snapshot.data!["status"],
                                          style:const TextStyle(fontSize: 14),
                                          ):
                                        Text(

                                          snapshot.data!["status"],
                                           style:const TextStyle(fontSize: 14)
                                        )
                                    ],
                                  )
                                ],
                              ),
                            );
                        }
                        else{
                         return Container();
                        }
                      }
                  )
                ),
                body:
                Column(
                  children: [
                    Container(
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(.05),
                      ),
                      width: double.infinity,
                      height: 25,
                      child: StreamBuilder<DocumentSnapshot>(
                        stream: messages.collection("users").doc(widget.id).snapshots(),
                        builder: (context, snapshot) {
                          if (snapshot.data != null) {
                            return
                              Text(
                                snapshot.data!["about"],
                                style:  TextStyle(
                                    fontSize: 15,
                                    color: kPrimaryColor2,
                                    overflow: TextOverflow.ellipsis
                                ),
                              );
                          }
                          else{
                            return const SizedBox();
                          }
                        },
                      ) ,
                    ),
                    Expanded(
                      child: ListView.builder(
                        reverse: true,
                        controller: controller,
                        itemCount: listMessages.length,
                        itemBuilder: (context, index) {
                          return Column(
                            children: [
                          listMessages[index].email == ema?
                            CustomChatBubble(
                            message: listMessages[index],
                          ): CustomFriendChatBubble(
                          message: listMessages[index],
                          )
                            ],
                          );
                        },
                      ),
                    ),
                    TextField(
                      controller: messageController,
                      decoration:
                      InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: BorderSide(
                              width: 1.5,
                                color: kPrimaryColor2
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: BorderSide(
                              width: 1.5,
                              color: kPrimaryColor2,
                            ),
                          ),
                          hintText: "Type a Message",
                          prefixIcon: IconButton(
                            padding:const EdgeInsets.all(5),
                            onPressed: (){},
                            icon: Icon(
                              Icons.emoji_emotions_outlined,
                              size: 35,
                              color: kPrimaryColor2,
                            ),
                          ),
                          suffixIcon: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                padding:const EdgeInsets.all(5),
                                onPressed: () async{
                                  showAttaches(
                                      context: context,
                                      userName: widget.username!,
                                      chatId: widget.chatRoomId!,
                                      takePhotoRequiredFunction: takePhotoRequiredFunction
                                  );
                                },
                                icon: Icon(
                                  Icons.attach_file_sharp,
                                  size: 25,
                                  color: kPrimaryColor2,
                                ),
                              ),
                              IconButton(
                                padding:const EdgeInsets.all(5),
                                onPressed: () async{},
                                icon: Icon(
                                  Icons.mic,
                                  size: 25,
                                  color: kPrimaryColor2,
                                ),
                              ),
                              IconButton(
                                padding: const EdgeInsets.all(5),
                                onPressed: () async {
                                  await MessageStoreService.storeMessage(
                                   chatId: widget.chatRoomId!,
                                    name: widget.username!,
                                    userMessage: messageController.text,
                                  );
                                  controller.jumpTo(
                                  0
                                  );
                                  messageController.clear();
                                },
                                icon: Icon(
                                  Icons.send_sharp,
                                  size: 30,
                                  color: kPrimaryColor2,
                                ),
                              ),
                            ],
                          )
                      ),
                    )
                  ],
                ),
              );
            }
          else{}
          return const SizedBox(
              height: 50,
              width: 50,
              child: CircularProgressIndicator(
                strokeWidth: 2,
              ),
            );
        }
        },
    );

  }
 void takePhotoRequiredFunction() {
   setState(() {
     TakePhoto.image = File(TakePhoto.pickedImage.path);
   });
 }
}


