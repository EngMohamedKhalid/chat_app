import 'package:chat_app/modules/photo_module/photo_view_screen.dart';
import 'package:chat_app/shared/cubit/cubit.dart';
import 'package:chat_app/shared/styles/colors.dart';
import 'package:chat_app/shared/styles/text_style.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class FriendProfileScreen extends StatelessWidget {
  const FriendProfileScreen({Key? key,  this.friendId}) : super(key: key);
final String? friendId;
  @override

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor:appBarColor,
      ),
      body:
      StreamBuilder <DocumentSnapshot<Map<String, dynamic>>>(
        stream: FirebaseFirestore.instance.collection("users").doc(friendId).snapshots(),
        builder: (context, snapshot) {
          switch(snapshot.connectionState){
            case ConnectionState.none:
              return const Scaffold(
                body: Center(child: Text("None............")),
              );
            case ConnectionState.waiting:
              return const Scaffold(
                body: Center(child: CircularProgressIndicator()),
              );
            case ConnectionState.done:
              return const Scaffold(
                body: Center(child: Text("done............")),
              );
            case ConnectionState.active:
              if(snapshot.hasData){
                return ListView(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 30,bottom: 40),
                      child: InkWell(
                        onTap: () {
                          Navigator.of(context).push(
                              MaterialPageRoute(builder: (context) => PhotoView(path:snapshot.data!["image"] ,),)
                          );
                        },
                        child: CircleAvatar(
                          backgroundImage: NetworkImage(snapshot.data!["image"]),
                          radius: 130,
                        ),
                      ),
                    ),
                    ListTile(
                      leading: Icon(
                        size: 30,
                        Icons.person,
                        color: SharedCubit.getObject(context).light?kPrimaryColor2:Colors.green,
                      ),
                      title: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          profileText(
                            context: context,
                            text: "Name",
                          ),
                          const SizedBox(height: 7,),
                          profileText(
                            context: context,
                            text: snapshot.data?["name"],
                            fontWeight: FontWeight.w400,
                          ),

                        ],
                      ),
                    ),
                    const SizedBox(height: 40,),
                    ListTile(
                      leading: Icon(
                        size: 30,
                        Icons.info_outline,
                        color: SharedCubit.getObject(context).light?kPrimaryColor2:Colors.green,
                      ),
                      title: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          profileText(
                            context: context,
                            text: "About",
                          ),
                          const SizedBox(height: 7,),
                          profileText(
                            context: context,
                            text: snapshot.data?["about"],
                            fontWeight: FontWeight.w400,
                          ),
                        ],
                      ),
                    ),

                  ],
                );
              }

          }
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        },

      ),
    );
  }
}
