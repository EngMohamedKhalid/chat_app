import 'dart:math';
import 'package:chat_app/models/take_photo.dart';
import 'package:chat_app/shared/network/remote/fire_store/message_store_service.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart';

void saveAttach({required String chatId,required String userName ,required String folderName}) async{
  var name = basename(TakePhoto.pickedImage.path);
  var rand = Random().nextInt(100000000);
  name = rand.toString()+name;
  var refStorage= FirebaseStorage.instance.ref("$folderName/$name");
  await refStorage.putFile(TakePhoto.image!);
  var url = await refStorage.getDownloadURL();
  await MessageStoreService.storeMessage(
    chatId:chatId,
    name: userName,
    userMessage: url,
  );
}