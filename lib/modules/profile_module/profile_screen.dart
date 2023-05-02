import 'dart:io';
import 'package:chat_app/modules/photo_module/photo_view_screen.dart';
import 'package:chat_app/modules/auth_module/sign_in_screen.dart';
import 'package:chat_app/shared/components/bottom_sheet/custom_bottom_sheet.dart';
import 'package:chat_app/shared/components/custom_list_tile.dart';
import 'package:chat_app/shared/components/attachments//pick_profile_photo.dart';
import 'package:chat_app/shared/cubit/cubit.dart';
import 'package:chat_app/shared/styles/colors.dart';
import 'package:chat_app/models/take_photo.dart';
import 'package:chat_app/shared/styles/text_style.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);
  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {

  void takePhotoRequiredFunction() {
    setState(() {
      TakePhoto.image = File(TakePhoto.pickedImage.path);
    });
  }
  @override
  Widget build(BuildContext context) {
    return
      Scaffold(
      appBar: AppBar(
        title: appBarText(context: context, text: "Profile")
      ),
      body: StreamBuilder <DocumentSnapshot<Map<String, dynamic>>>(
        stream: FirebaseFirestore.instance.collection("users").doc(FirebaseAuth.instance.currentUser!.uid).snapshots(),
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
                      padding: const EdgeInsets.only(top: 10,bottom: 30),
                      child:
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          InkWell(
                            onTap: () {
                              Navigator.of(context).push(
                                  MaterialPageRoute(builder: (context) => PhotoView(path:snapshot.data!["image"] ,),)
                              );
                            },
                            child: CircleAvatar(
                              backgroundImage:snapshot.data!["image"]==null? null: NetworkImage(snapshot.data!["image"]),
                              radius: 110,
                            ),
                          ),
                          IconButton(
                            onPressed: () async {
                              await TakePhoto.pickFromCamera(
                                  fn: takePhotoRequiredFunction
                              );
                              await pickProfilePhoto();
                            },
                            icon: Icon(
                              Icons.camera_alt,
                              color: SharedCubit.getObject(context).light?kPrimaryColor2:Colors.green,
                              size: 42,
                            ),
                          ),
                          IconButton(
                            onPressed: () async {
                              await TakePhoto.pickFromGallery(
                                  fn: takePhotoRequiredFunction
                              );
                             await pickProfilePhoto();
                            },
                            icon: Icon(
                              Icons.photo_library,
                              color: SharedCubit.getObject(context).light?kPrimaryColor2:Colors.green,
                              size: 42,
                            ),
                          )
                        ],
                      ),
                    ),
                    customListTile(
                      context: context,
                        leadingIconData: Icons.person,
                        trailingIconData: Icons.edit,
                        title: "Name",
                        subTitle: snapshot.data?["name"],
                        onPressed: () {
                          TextEditingController controller = TextEditingController(text:snapshot.data?["name"]);
                          showSheet(context: context, controller: controller, key: "name");
                        },
                    ),
                    const SizedBox(height: 40,),
                    customListTile(
                      context: context,
                        leadingIconData: Icons.info_outline,
                        trailingIconData: Icons.edit,
                        title: "About",
                        subTitle: snapshot.data?["about"],
                        onPressed: () {
                          TextEditingController controller = TextEditingController(text:snapshot.data?["about"]);
                          showSheet(context: context, controller: controller, key: "about");
                        },
                    ),
                    const SizedBox(height: 40,),
                    customListTile(
                      context: context,
                        leadingIconData: Icons.email,
                        title: "Email",
                        subTitle: snapshot.data?["email"],
                        onPressed: () {},
                    ),
                    const SizedBox(height: 40,),
                    customListTile(
                      context: context,
                        leadingIconData: Icons.dark_mode,
                        trailingIconData: Icons.nights_stay,
                        title: "Dark Mode",
                        subTitle: "Make App Appearance Dark",
                        onPressed: () {},
                        onTap:() {},
                    ),
                    const SizedBox(height: 40,),
                    customListTile(
                      context: context,
                      leadingIconData:Icons.logout,
                      title: "Log Out",
                      subTitle: "Log Out From Your Account",
                      onPressed: () {},
                      onTap: () {
                        FirebaseAuth.instance.signOut();
                            Navigator.of(context).pushReplacement(
                              MaterialPageRoute(builder: (context) => SignInScreen(),)
                            );
                      },
                    ),
                  ],
                );
              }
          }
          return const SizedBox(
            width: 100,
              height: 100,
              child: CircularProgressIndicator());
        },
      ),
    );
  }
}



























