import 'package:chat_app/shared/cubit/cubit.dart';
import 'package:chat_app/shared/styles/colors.dart';
import 'package:flutter/material.dart';
Widget homeText({required BuildContext context, required String text ,double size = 17.5, FontWeight? fontWeight }) {
  return Text(
  text,
  style: TextStyle(
    fontSize: size,
      //color:SharedCubit.getObject(context).light?Colors.white:Colors.grey,
      color:SharedCubit.getObject(context).light?color7:color1,
  ),
);
}
Widget appBarText({required BuildContext context, required String text , double size = 25, FontWeight fontWeight = FontWeight.bold,}) {
  return Text(
  text,
  style: TextStyle(
      fontSize: size,
      fontWeight: fontWeight,
      color:SharedCubit.getObject(context).light?color7:color1
  ),
);
}
Widget profileText({required BuildContext context, required String text , double size = 20, FontWeight fontWeight = FontWeight.bold,}) {
  return Text(
  text,
  style: TextStyle(
      fontSize: size,
      fontWeight: fontWeight,
      color:SharedCubit.getObject(context).light?Colors.black:Colors.white
  ),
);
}
Widget bodyText({required BuildContext context, required String text ,double size = 17.5, FontWeight fontWeight = FontWeight.bold }) {
  return Text(
  text,
  style: TextStyle(
      fontSize: size,
      color:SharedCubit.getObject(context).light? Colors.black :const Color(0xff65b0bb)
  ),
);
}
Widget buttonStyle({ void Function()? onPressed,required EdgeInsetsGeometry padding ,double size = 35,required BuildContext context,required IconData icon}) {
  return IconButton(
      padding:padding ,
      onPressed: onPressed,
      icon: Icon(
        icon,
        size: size,
        color: SharedCubit.getObject(context).light?color7:color1,
      ),
  );
}