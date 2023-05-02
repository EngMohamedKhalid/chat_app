// ignore_for_file: avoid_single_cascade_in_expression_statements

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:chat_app/shared/components/loading.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SignUpModel{
static UserCredential? credential;
static CollectionReference? userRef;
 static Future signUp({required String emailAddress,required String password,required String username , required BuildContext context}) async{
    try {
      showLoading(context);
     credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailAddress,
        password: password,
      ).then((value) {
         userRef = FirebaseFirestore.instance.collection("users");
        userRef!.doc(value.user!.uid).set({
          "userid":value.user!.uid,
          "name":username,
          "email":emailAddress,
          "password":password,
          "about":"Hey there! I am using ChatApp.",
          "image" : null,
          "status":null,
          "story":null,
        });
        return credential;
     },
     );
    return credential;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        Navigator.of(context).pop();
        AwesomeDialog(
          context: context,
          dialogType: DialogType.error,
          animType: AnimType.rightSlide,
          title: 'Error',
          desc: 'The password provided is too weak.',
          btnCancelOnPress: () {},
          btnOkOnPress: () {},
        )..show();
      } else if (e.code == 'email-already-in-use') {
        Navigator.of(context).pop();
        AwesomeDialog(
            context: context,
            dialogType: DialogType.error,
            animType: AnimType.rightSlide,
            title: 'Error',
            desc: 'The account already exists for that email.',
            btnCancelOnPress: () {},
            btnOkOnPress: () {},
   )..show();
      }
    }

  }
}