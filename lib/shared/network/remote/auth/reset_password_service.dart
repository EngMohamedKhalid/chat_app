import 'package:chat_app/shared/components/loading.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

Future<void >reseatPassword({required BuildContext context,required String email}) async{
  showLoading;
  await FirebaseAuth.instance.sendPasswordResetEmail(
    email: email,
  ).then((value) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        backgroundColor: Colors.orangeAccent,
        content: Text(
          'verification send to your gmail ',
          style: TextStyle(fontSize: 18.0, color: Colors.black),
        ),
      ),
    );
  });


}