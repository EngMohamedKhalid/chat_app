import 'dart:io';

import 'package:chat_app/models/take_photo.dart';
import 'package:chat_app/modules/photo_module/photo_view_screen.dart';
import 'package:chat_app/shared/components/attachments/pick_profile_photo.dart';
import 'package:chat_app/shared/styles/text_style.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class StoriesScreen extends StatefulWidget {
  const StoriesScreen({Key? key}) : super(key: key);

  @override
  State<StoriesScreen> createState() => _StoriesScreenState();
}

class _StoriesScreenState extends State<StoriesScreen> {
  void takePhotoRequiredFunction() {
    setState(() {
      TakePhoto.image = File(TakePhoto.pickedImage.path);
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          FloatingActionButton(
            heroTag: "btn1",
            backgroundColor: Colors.deepOrange,
            onPressed: ()async{
              await TakePhoto.pickFromCamera(
                  fn: takePhotoRequiredFunction
              ).then((value) {
                pickStoryPhoto();
              });
            },
            child: const Icon(
              Icons.camera_alt,
              size: 30,
            ),
          ),
          const SizedBox(height: 8,),
          FloatingActionButton(
            heroTag: "btn2",
            backgroundColor: Colors.deepOrange,
            onPressed: ()async{
              await TakePhoto.pickFromGallery(
                  fn: takePhotoRequiredFunction
              ).then((value) {
                pickStoryPhoto();
              });
            },
            child: const Icon(
              Icons.photo,
              size: 30,
            ),
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          StreamBuilder<DocumentSnapshot>(
              stream: FirebaseFirestore.instance.collection("users").doc(FirebaseAuth.instance.currentUser!.uid).snapshots(),
              builder: (context, snapshot) {
                if (snapshot.data != null) {
                  return
                    Padding(
                      padding: const EdgeInsets.only(left: 15,top: 10),
                      child: InkWell(
                        onTap: () {},
                        child: Row(
                          children: [
                            CircleAvatar(
                              radius: 30,
                              backgroundImage: snapshot.data!["story"] == null? NetworkImage(snapshot.data!["image"]) : NetworkImage(snapshot.data!["story"]),
                            ),
                            const SizedBox(width: 8,),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  "My Status",
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold
                                  ),
                                ),
                                SizedBox(height: 8,),
                                Text(
                                  "Tap to add status update",
                                  style: TextStyle(
                                      fontSize: 15,
                                      color: Colors.grey,
                                      fontWeight: FontWeight.w400
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                }
                else{
                  return Container();
                }
              }
          ),
          const SizedBox(height: 15,),
          const Padding(
           padding: EdgeInsets.only(left: 15,),
            child: Text(
              "Recent updates",
              style: TextStyle(
                  fontSize: 19,
                  color: Colors.grey,
                  fontWeight: FontWeight.w400
              ),
            ),
          ),
          const SizedBox(height: 15,),
          StreamBuilder(
              stream: FirebaseFirestore.instance.collection("users").where("userid",isNotEqualTo: FirebaseAuth.instance.currentUser!.uid).snapshots(),
              builder: (context, snapshot) {
                switch(snapshot.connectionState) {
                  case ConnectionState.none:
                  case ConnectionState.done:
                  case ConnectionState.waiting:
                  case ConnectionState.active :
                    if (snapshot.hasData){
                      return ListView.builder(
                        padding: EdgeInsets.only(bottom: 15),
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: snapshot.data!.docs.length ,
                        itemBuilder: (context, index) {
                          return ListTile(
                            contentPadding: const EdgeInsets.all(6),
                            onTap: (){
                              Navigator.of(context).push(
                                  MaterialPageRoute(builder: (context) =>PhotoView(
                                    path: snapshot.data!.docs[index]["story"],
                                  ),)
                              );
                            },
                            leading:snapshot.data!.docs[index]["story"] == null?
                            CircleAvatar(
                              radius: 30,
                              backgroundImage:snapshot.data!.docs[index]["image"] == null? null : NetworkImage(snapshot.data!.docs[index]["image"]),
                            ):
                            Stack(
                              alignment: Alignment.center,
                              children: [
                                Container(
                                  width: 70,
                                  decoration: const BoxDecoration(
                                      color: Colors.green,
                                      shape: BoxShape.circle
                                  ),
                                ),
                                CircleAvatar(
                                  radius: 25,
                                  backgroundImage:snapshot.data!.docs[index]["story"] == null? NetworkImage(snapshot.data!.docs[index]["image"]) : NetworkImage(snapshot.data!.docs[index]["story"]),
                                ),
                              ],
                            ),
                            title: bodyText(context: context,size: 20, text: snapshot.data!.docs[index]["name"]),
                          );
                        },
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
          ),
        ],
      ),
    );
  }
}
