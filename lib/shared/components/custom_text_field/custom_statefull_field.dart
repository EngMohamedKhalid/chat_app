// ignore_for_file: use_full_hex_values_for_flutter_colors

import 'package:flutter/material.dart';

class CustomStateFullTextField extends StatefulWidget {
  const CustomStateFullTextField({Key? key, required this.text, this.controller}) : super(key: key);
  final String text;
  final TextEditingController? controller;
  @override
  State<CustomStateFullTextField> createState() => _CustomStateFullTextFieldState();
}

class _CustomStateFullTextFieldState extends State<CustomStateFullTextField> {
  bool isShow = true;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      validator: (value) {
        if(value!.isEmpty){
          return "${widget.text} must not be empty";
        }
        return null;
      },
      style: const TextStyle(
          color: Colors.white
      ),
      obscureText: isShow,
      decoration: InputDecoration(
        errorStyle:const TextStyle(fontSize:18,color: Colors.deepOrange),
        label: Text(
          widget.text,
          style: const TextStyle(
              color: Color(0xffE5E2E2FF),
              fontSize: 16
          ),
        ),
        suffixIcon:IconButton(
          onPressed: () {
            setState(() {
              isShow = !isShow;
            });
          },
          icon: Icon(
            isShow?Icons.visibility_off:Icons.visibility,
            color: const Color(0xffe5e2e2ff),
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