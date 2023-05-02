import 'package:chat_app/shared/cubit/cubit.dart';
import 'package:chat_app/shared/cubit/states.dart';
import 'package:chat_app/modules/chats_module/chat_screen.dart';
import 'package:chat_app/modules/profile_module/friend_profile_screen.dart';
import 'package:chat_app/shared/styles/colors.dart';
import 'package:chat_app/shared/styles/text_style.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatsScreen extends StatefulWidget  {
    const ChatsScreen({Key? key, }) : super(key: key);
  @override
  State<ChatsScreen> createState() => _ChatsScreenState();
}

class _ChatsScreenState extends State<ChatsScreen> with WidgetsBindingObserver {
   @override
  void initState() {
     WidgetsBinding.instance.addObserver(this);
     setStatus("Online");
    super.initState();
  }

   void setStatus(String status) async {
     await FirebaseFirestore.instance.collection("users").doc(FirebaseAuth.instance.currentUser!.uid).update({
       "status":status,
     });
   }
   @override
   void didChangeAppLifecycleState(AppLifecycleState state) {
     if (state == AppLifecycleState.resumed) {
       // online
       setStatus("Online");
     } else {
       String amPm= DateTime.now().hour<12?"Am" :"Pm" ;
       var time1 = DateTime.now().hour.remainder(12)==0?DateTime.now().hour.remainder(12)+12:DateTime.now().hour.remainder(12);
       var time2 = DateTime.now().minute;
       //var time = DateTime.;
       // offline
       setStatus("last seen at $time1:$time2 $amPm");
     }
   }

    String? id ;
    String chatRoomId(String user1, String user2) {
      if (user1[0].toLowerCase().codeUnits[0] >
          user2.toLowerCase().codeUnits[0]) {
        return "$user1$user2";
      } else {
        return "$user2$user1";
      }
    }

   @override
  Widget build(BuildContext context) {
    return
      StreamBuilder(
        stream: FirebaseFirestore.instance.collection("users").where("userid",isNotEqualTo:FirebaseAuth.instance.currentUser!.uid ).snapshots(),
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
                body: Center(child: Text("done...............",
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
              if (snapshot.hasData){
                return Scaffold(
                    body :snapshot.data!.docs.isEmpty?
                    Center(
                      child:bodyText(context: context,size: 20, text: "Sorry!no users have been Signed..."),
                    ) :ListView.separated(
                      padding: EdgeInsets.only(top: 15),
                      itemCount: snapshot.data!.docs.length ,
                      itemBuilder: (context, index) {
                        return
                          ListTile(
                          onTap: (){
                            String roomId = chatRoomId(
                                FirebaseAuth.instance.currentUser!.uid,
                                snapshot.data!.docs[index]["userid"]
                            );
                            Navigator.of(context).push(
                                MaterialPageRoute(builder: (context) => ChatScreen(
                                  chatRoomId: roomId,
                                  username:snapshot.data!.docs[index]["name"] ,
                                  image: snapshot.data!.docs[index]["image"],
                                  id: snapshot.data!.docs[index]["userid"],
                                  about: snapshot.data!.docs[index]["about"],
                                ),
                                )
                            );
                          },
                          leading: InkWell(
                            onTap: () {
                              Navigator.of(context).push(
                                  MaterialPageRoute(builder: (context) => FriendProfileScreen(
                                    friendId:snapshot.data!.docs[index]["userid"] ,
                                  ),)
                              );
                            },
                            child: Stack(
                              alignment: AlignmentDirectional.topEnd,
                              children: [
                                CircleAvatar(
                                  radius: 30,
                                  backgroundImage:snapshot.data!.docs[index]["image"] == null? null : NetworkImage(snapshot.data!.docs[index]["image"]),
                                ),
                                snapshot.data!.docs[index]["status"]==null?
                                const CircleAvatar(
                                  radius: 0,

                                ):snapshot.data!.docs[index]["status"]=="Online"?
                                const CircleAvatar(
                                  backgroundColor: Colors.green,
                                  radius: 9,
                                )
                                    :const CircleAvatar(
                                  radius: 0,
                                ),
                              ],
                            ),
                          ),
                          title: bodyText(context: context,size: 20, text: snapshot.data!.docs[index]["name"]),
                        );
                      },
                      separatorBuilder: (context, index) {
                        return Container(
                          margin:const EdgeInsets.symmetric(horizontal: 60,vertical: 10),
                          padding: const EdgeInsets.all(5),
                          color: Colors.black54,
                          width: 100,
                          height: 1,
                        );
                      },
                    )
                );
              }
              else{}
              return const SizedBox(
                  height: 50,
                  width: 50,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                  )
              );
          }
        }
    );
  }
}
