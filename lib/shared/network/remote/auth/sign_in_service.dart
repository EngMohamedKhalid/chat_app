// ignore_for_file: avoid_single_cascade_in_expression_statements

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:chat_app/shared/components/loading.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SignInModel{
  static UserCredential? credential;
  static Future signIn({required String emailAddress,required String password , required BuildContext context}) async{
    try {
      showLoading(context);
      credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailAddress,
        password: password,
      );
      return credential;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'wrong-password') {
        Navigator.of(context).pop();
        AwesomeDialog(
          context: context,
          dialogType: DialogType.error,
          animType: AnimType.rightSlide,
          title: 'Error',
          desc: 'Wrong password provided for that user.',
          btnCancelOnPress: () {},
          btnOkOnPress: () {},
        )..show();
      } else if (e.code == 'user-not-found') {
        Navigator.of(context).pop();
        AwesomeDialog(
          context: context,
          dialogType: DialogType.error,
          animType: AnimType.rightSlide,
          title: 'Error',
          desc: 'No user found for that email,,please Sign Up',
          btnCancelOnPress: () {},
          btnOkOnPress: () {},
        )..show();
      }
    }
  }
}