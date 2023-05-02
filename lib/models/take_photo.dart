import 'dart:io';
import 'package:flutter/animation.dart';
import 'package:image_picker/image_picker.dart';

class TakePhoto{
 static File? image;
 static var  pickedImage;
 static var  url;
 static final imagePicker = ImagePicker();

 static Future<void> pickFromCamera ({ required  VoidCallback fn}) async{
      pickedImage = await imagePicker.pickImage(
      source: ImageSource.camera,
    );
    if(pickedImage != null){
      fn();

    }
    else{}
  }


 static Future<void> pickFromGallery ({ required  VoidCallback fn}) async{
   pickedImage = await imagePicker.pickImage(
     source: ImageSource.gallery,
   );
   if(pickedImage != null){
     fn();
   }
   else{}
 }

 static Future<void> pickVidoeFromGallery ({ required  VoidCallback fn}) async{
   pickedImage = await imagePicker.pickVideo(
     source: ImageSource.gallery,
   );
   if(pickedImage != null){
     fn();
   }
   else{}
 }

}


