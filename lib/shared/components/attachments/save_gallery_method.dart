import 'package:chat_app/shared/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:gallery_saver/gallery_saver.dart';

void savePhotoToGallery({
  required BuildContext context,
  required String path
 }){
 path.contains("https://firebasestorage.googleapis.com/v0/b/socialapp-c4833.appspot.com/o/videos")?
  GallerySaver.saveVideo(
    path,
    albumName: "ChatApp",
  ).then((value) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: kPrimaryColor2,
        content:const Text(
          'Saved Successfully',
          style: TextStyle(fontSize: 18.0, color: Colors.white),
        ),
      ),
    );
  }).catchError((onError){
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: kPrimaryColor2,
        content:const Text(
          "Please,Check Your Connection",
          style: TextStyle(fontSize: 18.0, color: Colors.white),
        ),
      ),
    );
  }):
  GallerySaver.saveImage(
    path,
    albumName: "ChatApp",
  ).then((value) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: kPrimaryColor2,
        content:const Text(
          'Saved Successfully',
          style: TextStyle(fontSize: 18.0, color: Colors.white),
        ),
      ),
    );
  }).catchError((onError){
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: kPrimaryColor2,
        content:const Text(
          "Please,Check Your Connection",
          style: TextStyle(fontSize: 18.0, color: Colors.white),
        ),
      ),
    );
  });
}