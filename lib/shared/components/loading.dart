
import 'package:chat_app/shared/styles/colors.dart';
import 'package:flutter/material.dart';

showLoading(context){
  return showDialog(
    context: context,
    builder: (context){
      return AlertDialog(
        backgroundColor: Colors.white,
        title:  Text("Please Wait",
          style: TextStyle(
             color: kPrimaryColor2
          ),
        ),
        content: SizedBox(
            height: 50,
            child:  Center(child: CircularProgressIndicator(
              color: kPrimaryColor2,
            ))),
      );
    },

  );
}