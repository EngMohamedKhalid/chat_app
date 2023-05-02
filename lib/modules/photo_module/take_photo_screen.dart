import 'dart:io';
import 'package:chat_app/shared/components/attachments//pick_profile_photo.dart';
import 'package:chat_app/shared/styles/colors.dart';
import 'package:chat_app/shared/components/custom_buttons/custom_button.dart';
import 'package:chat_app/models/take_photo.dart';
import 'package:chat_app/modules/chats_module/chats_screen.dart';
import 'package:chat_app/shared/styles/text_style.dart';
import 'package:flutter/material.dart';


class TakePhotoScreen extends StatefulWidget {
  const TakePhotoScreen({Key? key,  this.username}) : super(key: key);
  final String? username;
  @override
  State<TakePhotoScreen> createState() => _TakePhotoScreenState();
}

class _TakePhotoScreenState extends State<TakePhotoScreen> {
  void takePhotoRequiredFunction() {
    setState(() {
      TakePhoto.image = File(TakePhoto.pickedImage.path);
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        //backgroundColor: kPrimaryColor2,
        title:appBarText(context: context, text: "Choose Your Pic")
      ),
      body: Column(
        children: [
          const SizedBox(height: 30,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              bodyText(
                  context: context,
                  text:  "Welcome ",
                  fontWeight: FontWeight.bold,
                  size: 20
              ),
              bodyText(
                  context: context,
                  text:  widget.username!,
                  fontWeight: FontWeight.bold,
                  size: 22
              ),
            ],
          ),
          const SizedBox(height: 5),
          bodyText(
              context: context,
              text: "please choose a photo",
              fontWeight: FontWeight.bold,
              size: 25
          ),
          const SizedBox(height: 50,),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                backgroundImage: TakePhoto.image == null ? null : FileImage(TakePhoto.image!),
                radius: 80,
              ),
              IconButton(
                onPressed: () async {
                  await TakePhoto.pickFromCamera(
                      fn: takePhotoRequiredFunction
                  );
                },
                icon: Icon(
                  Icons.camera_alt,
                  color: kPrimaryColor2,
                  size: 42,
                ),
              ),
              IconButton(
                onPressed: () async {
                  await TakePhoto.pickFromGallery(
                      fn: takePhotoRequiredFunction
                  );
                },
                icon: Icon(
                  Icons.photo_library,
                  color: kPrimaryColor2,
                  size: 42,
                ),
              )
            ],
          ),
          const SizedBox(height: 50,),
          CustomButton(
            minWidth: 300,
            onPressed: ()  {
               pickProfilePhoto().then((value){
                 Navigator.of(context).pushReplacement(
                     MaterialPageRoute(builder: (context) => const ChatsScreen(),)
                 );
               }).catchError((error){
                 ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                       backgroundColor: kPrimaryColor2,
                       content:const Text(
                         'You Must Choose your Profile Photo ',
                         style: TextStyle(fontSize: 18.0, color: Colors.white),
                       ),
                     )
                 );
               });
            },
            text: "Save Changes",
          )
        ],
      ),
    );
  }
}
