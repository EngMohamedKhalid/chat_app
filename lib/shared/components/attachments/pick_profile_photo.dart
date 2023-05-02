import 'dart:math';
import 'package:chat_app/models/take_photo.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart';

Future<void > pickProfilePhoto()async {
  var name = basename(TakePhoto.pickedImage.path);
  var rand = Random().nextInt(100000000);
  name = rand.toString()+name;
  var refStorage= FirebaseStorage.instance.ref("images/$name");
  await refStorage.putFile(TakePhoto.image!);
  var url = await  refStorage.getDownloadURL();
  CollectionReference? userRef = FirebaseFirestore.instance.collection("users");
  userRef.doc(FirebaseAuth.instance.currentUser!.uid).update({
    "image": url
  });
}


Future<void > pickStoryPhoto()async {
  var name = basename(TakePhoto.pickedImage.path);
  var rand = Random().nextInt(100000000);
  name = rand.toString()+name;
  var refStorage= FirebaseStorage.instance.ref("story/$name");
  await refStorage.putFile(TakePhoto.image!);
  var url = await  refStorage.getDownloadURL();
  CollectionReference? userRef = FirebaseFirestore.instance.collection("users");
  userRef.doc(FirebaseAuth.instance.currentUser!.uid).update({
    "story": url
  });
}