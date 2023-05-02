import 'package:chat_app/shared/cubit/cubit.dart';
import 'package:chat_app/shared/styles/colors.dart';
import 'package:flutter/material.dart';

Widget customListTile({
  required IconData leadingIconData,
  required BuildContext context,
  IconData? trailingIconData,
  required String title,
  required String subTitle,
  required void Function()? onPressed,
   void Function()? onTap
})=>ListTile(
  onTap: onTap,
  leading: Icon(
    leadingIconData,
    size: 30,
    color: SharedCubit.getObject(context).light?kPrimaryColor2:Colors.green,
  ),
  title: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
       Text(
        title,
        style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
            color:SharedCubit.getObject(context).light?kPrimaryColor2:Colors.white
        ),
      ),

      const SizedBox(height: 4,),
      Text(
        subTitle,
        style: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 20,
            color:SharedCubit.getObject(context).light?Colors.blue:Colors.grey
        ),
      ),
    ],
  ),
  trailing: IconButton(
    onPressed: onPressed,
    icon:  Icon(
      trailingIconData,
      size: 30,
      color: SharedCubit.getObject(context).light?kPrimaryColor2:Colors.green,
    ),
  ),
);