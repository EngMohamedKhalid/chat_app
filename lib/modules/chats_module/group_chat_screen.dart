
import 'package:chat_app/shared/components/custom_chat_bubble/custom__me_chat_bubble.dart';
import 'package:chat_app/shared/components/custom_chat_bubble/custom_friend_chat_bubble.dart';
import 'package:chat_app/shared/styles/colors.dart';
import 'package:chat_app/models/message_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class GroupChatScreen extends StatelessWidget {
   GroupChatScreen({Key? key}) : super(key: key);
  final TextEditingController messageController = TextEditingController();
  final controller = ScrollController();
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream:FirebaseFirestore.instance.collection('groups').orderBy('time', descending: true).snapshots(),
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
                appBar: AppBar(
                  backgroundColor: kPrimaryColor2,
                   title:const Text(
                      "Our tiny castle 🏰🔥" ,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 17
                      ),
                    )
                ),
                body:
                Column(
                  children: [
                    Expanded(
                      child: ListView.builder(
                        reverse: true,
                        controller: controller,
                        itemCount: listMessages.length,
                        itemBuilder: (context, index) {
                          return Column(
                            children: [
                              listMessages[index].email == snapshot.data!.docs[index]["userEmail"]?
                              CustomChatBubble(
                                message: listMessages[index],
                              ):
                              CustomFriendChatBubble(
                                message: listMessages[index],
                              )
                            ],
                          );

                        },
                      ),
                    ),
                    // TextField(
                    //   controller: messageController,
                    //   decoration:
                    //   InputDecoration(
                    //       enabledBorder: OutlineInputBorder(
                    //         borderRadius: BorderRadius.circular(20),
                    //         borderSide: BorderSide(
                    //             width: 1.5,
                    //             color: kPrimaryColor2
                    //         ),
                    //       ),
                    //       focusedBorder: OutlineInputBorder(
                    //         borderRadius: BorderRadius.circular(20),
                    //         borderSide: BorderSide(
                    //           width: 1.5,
                    //           color: kPrimaryColor2,
                    //         ),
                    //       ),
                    //       hintText: "Type a Message",
                    //       suffixIcon: Row(
                    //         mainAxisSize: MainAxisSize.min,
                    //         children: [
                    //           IconButton(
                    //             padding: const EdgeInsets.all(5),
                    //             onPressed: () async {
                    //               await MessageStoreService.storeGroupMessage(
                    //                 userMessage: messageController.text,
                    //               );
                    //               controller.jumpTo(
                    //                   0
                    //               );
                    //               // FirebaseFirestore.instance.collection("users").doc(FirebaseAuth.instance.currentUser!.uid).update({
                    //               //   "message":messages.collection('chatroom').doc(widget.chatRoomId).collection('chats')
                    //               // });
                    //               messageController.clear();
                    //
                    //             },
                    //             icon: Icon(
                    //               Icons.send_sharp,
                    //               size: 30,
                    //               color: kPrimaryColor2,
                    //             ),
                    //           ),
                    //         ],
                    //       )
                    //   ),
                    // )
                  ],
                ),
              );
            }
            else{

            }
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
}
