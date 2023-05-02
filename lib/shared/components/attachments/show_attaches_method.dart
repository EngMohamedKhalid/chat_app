// ignore_for_file: avoid_single_cascade_in_expression_statements

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:chat_app/models/take_photo.dart';
import 'package:chat_app/shared/components/attachments/save_attach_message_service.dart';
import 'package:chat_app/shared/styles/colors.dart';
import 'package:flutter/material.dart';

void showAttaches(
    {required BuildContext context,
    required String chatId,
    required String userName,
    required VoidCallback takePhotoRequiredFunction ,
    }){
  AwesomeDialog(
    dialogType: DialogType.question,
    body: Text(
      "Choose",
      style: TextStyle(
          fontWeight:FontWeight.bold,
          fontSize: 17,
          color: kPrimaryColor2
      ),
    ),
    context: context,
    btnCancel:Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        IconButton(
          icon: Icon(
            Icons.camera_alt,
            size: 40,
            color: kPrimaryColor2,
          ),
          onPressed: ()async {
            await TakePhoto.pickFromCamera(
                fn: takePhotoRequiredFunction
            ).then((value) {
              Navigator.pop(context);
              saveAttach(chatId: chatId, userName: userName, folderName: "images");
            });
          },
        ),
        IconButton(
          icon: Icon(
            Icons.photo_library,
            size: 40,
            color: kPrimaryColor2,
          ) ,
          onPressed: ()async {
            await TakePhoto.pickFromGallery(
                fn: takePhotoRequiredFunction
            ).then((value) {
              Navigator.pop(context);
              saveAttach(chatId: chatId, userName: userName, folderName: "images");
            }) ;
          },
        ),
        IconButton(
          icon: Icon(
            Icons.video_camera_back_sharp,
            size: 40,
            color: kPrimaryColor2,
          ) ,
          onPressed: ()async {
            await TakePhoto.pickVidoeFromGallery(
                fn: takePhotoRequiredFunction
            ).then((value) {
              Navigator.pop(context);
              saveAttach(chatId: chatId, userName: userName, folderName: "videos");
            }) ;
          },
        )
      ],
    ),
  )..show();
}