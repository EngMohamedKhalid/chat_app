// ignore_for_file: use_full_hex_values_for_flutter_colors

import 'package:flutter/material.dart';

class CustomStatelessTextField extends StatelessWidget {
  const CustomStatelessTextField({Key? key, required this.lableText, this.controller}) : super(key: key);
  final String lableText;
  final TextEditingController? controller;
  @override
  Widget build(BuildContext context) {
    return  TextFormField(
      controller: controller,
      validator: (value) {
        if(value!.isEmpty){
          return "$lableText must not be empty";
        }
        return null;
      },
      style: const TextStyle(
          color: Colors.white
      ),
      decoration: InputDecoration(
        errorStyle:const TextStyle(fontSize:18,color: Colors.deepOrange),
        label: Text(
          lableText,
          style: const TextStyle(
              color: Color(0xffE5E2E2FF),
              fontSize: 16
          ),
        ),
        border: const UnderlineInputBorder(
          borderSide: BorderSide(
              color: Colors.grey,
              width: 1.25
          ),
        ),
        enabledBorder: const UnderlineInputBorder(
          borderSide: BorderSide(
              color: Colors.grey,
              width: 1.25
          ),
        ),
        errorBorder: const UnderlineInputBorder(
          borderSide: BorderSide(
              color: Colors.deepOrange,
              width: 1.25
          ),
        ),
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(
              color: Colors.grey,
              width: 1.25
          ),
        ),
      ),
    );
  }
}