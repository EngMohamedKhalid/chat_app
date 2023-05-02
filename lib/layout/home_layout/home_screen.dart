import 'package:chat_app/modules/stories_module/stories_screen.dart';
import 'package:chat_app/shared/cubit/cubit.dart';
import 'package:chat_app/shared/cubit/states.dart';
import 'package:chat_app/modules/profile_module/profile_screen.dart';
import 'package:chat_app/modules/chats_module/chats_screen.dart';
import 'package:chat_app/modules/chats_module/group_screen.dart';
import 'package:chat_app/shared/styles/colors.dart';
import 'package:chat_app/shared/styles/text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeTapScreen extends StatelessWidget {
  const HomeTapScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return
      BlocConsumer<SharedCubit,SharedStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return DefaultTabController(
            length: 3,
            child: Scaffold(
              appBar: AppBar(
                //backgroundColor: color7,
               // backgroundColor:SharedCubit.getObject(context).light? Colors.deepOrange:Colors.black,
                backgroundColor:SharedCubit.getObject(context).light? color1:color7,
                title:appBarText(
                    context: context,
                    text: "ChatApp"
                ),
                actions: [
                  buttonStyle(
                    onPressed: () {
                        SharedCubit.getObject(context).changeLight();
                      },
                      padding:const EdgeInsets.only(right: 10),
                      context: context,
                      icon: SharedCubit.getObject(context).light? Icons.nights_stay_outlined:Icons.wb_sunny_outlined,
                  ),
                  buttonStyle(
                    onPressed: () {
                      Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) => const ProfileScreen()
                          )
                      );
                    },
                    padding:const EdgeInsets.only(right: 10),
                    context: context,
                    icon: Icons.account_circle_sharp,
                  ),
                ],
                // backgroundColor: kPrimaryColor2,
                bottom: TabBar(
                  //indicatorColor:SharedCubit.getObject(context).light?Colors.white:Colors.deepOrange,
                  indicatorColor:SharedCubit.getObject(context).light?color7:color1,
                  tabs: [
                    Tab(
                      child:homeText(
                        context: context,
                        text: "Chats",
                      ),
                    ),
                    Tab(
                      child:homeText(
                        context: context,
                        text: "Groups"
                      ),
                    ),
                    Tab(
                      child:homeText(
                        context: context,
                        text: "Status"
                      ),
                    ),
                  ],
                ),
              ),
              body: const TabBarView(
                children:[
                  ChatsScreen(),
                  GroupScreen(),
                  StoriesScreen()
                ],
              ),
            ),
          );
        },
      );
  }
}
