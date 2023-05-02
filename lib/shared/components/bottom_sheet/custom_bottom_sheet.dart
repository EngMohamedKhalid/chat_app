import 'package:chat_app/shared/components/custom_buttons/custom_text_button.dart';
import 'package:chat_app/shared/components/bottom_sheet/custom_bottom_sheet_textField.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

void showSheet({required BuildContext context,required TextEditingController controller , required String key}){
  showBottomSheet(
    context: context,
    builder:(context) => Container(
      padding: const EdgeInsets.all( 15 ),
      margin:const EdgeInsets.all(12),
      decoration: BoxDecoration(
          color:Colors.white,
          borderRadius: BorderRadius.circular(20)
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.min,
        children: [
          customBottomSheetTextField(controller: controller),
          const SizedBox(height: 20,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomTextButton(
                onPressed: (){
                  CollectionReference? userRef = FirebaseFirestore.instance.collection("users");
                  userRef.doc(FirebaseAuth.instance.currentUser!.uid).update({
                    key: controller.text
                  });
                  Navigator.of(context).pop();
                  controller.clear();
                },
                text: "save",
              ),
              CustomTextButton(
                onPressed: (){
                  Navigator.of(context).pop();
                },
                text: "Cancel",
              ),
            ],
          )
        ],
      ),
    ),
  );
}