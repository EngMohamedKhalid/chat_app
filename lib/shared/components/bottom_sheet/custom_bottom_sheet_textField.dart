import 'package:chat_app/shared/styles/colors.dart';
import 'package:flutter/material.dart';

Widget customBottomSheetTextField({required TextEditingController controller})=>
TextField(
  controller: controller,
  decoration: InputDecoration(
    enabledBorder:UnderlineInputBorder(
        borderSide:  BorderSide(color: kPrimaryColor2)) ,
    focusedBorder:UnderlineInputBorder(
        borderSide:  BorderSide(color: kPrimaryColor2)
    ),
    border: UnderlineInputBorder(
        borderSide:  BorderSide(color: kPrimaryColor2)
    ),
  ),
);