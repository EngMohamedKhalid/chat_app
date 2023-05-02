import 'package:chat_app/layout/home_layout/home_screen.dart';
import 'package:chat_app/modules/auth_module/sign_in_screen.dart';
import 'package:chat_app/modules/auth_module/sign_up_screen.dart';
import 'package:chat_app/shared/cubit/cubit.dart';
import 'package:chat_app/shared/cubit/states.dart';
import 'package:chat_app/shared/network/local/cash_helper.dart';
import 'package:chat_app/shared/styles/colors.dart';
import 'package:chat_app/test.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await CashHelper.init();
  runApp(const MyApp());
}
 bool? dark = CashHelper.getPool(key: "isDark");
class MyApp extends StatelessWidget {
  const MyApp({super.key,});
  @override
  Widget build(BuildContext context) {
    return  BlocProvider(
        create: (context) => SharedCubit()..changeLight(fromShared: dark),
      child:BlocConsumer<SharedCubit,SharedStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = SharedCubit.getObject(context);
          return  MaterialApp(
            routes: {
              "signIn" : (context) => SignInScreen(),
              "signUp" : (context) => SignUpScreen(),
            },
            theme: ThemeData(
                scaffoldBackgroundColor: Colors.white,
                appBarTheme: AppBarTheme(
                    backgroundColor: kPrimaryColor2,
                    titleTextStyle: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold),
                    systemOverlayStyle: const SystemUiOverlayStyle(
                      statusBarColor: Colors.black12,
                      statusBarIconBrightness: Brightness.light,
                    )),
                bottomNavigationBarTheme: BottomNavigationBarThemeData(
                    type: BottomNavigationBarType.fixed,
                    selectedItemColor: kPrimaryColor2,
                    elevation: 12.5)),
            darkTheme: ThemeData(
                appBarTheme: const AppBarTheme(
                    backgroundColor: Color(0xff333739),
                    titleTextStyle:
                    TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    systemOverlayStyle: SystemUiOverlayStyle(
                      statusBarColor: Color(0xff333739),
                      statusBarIconBrightness: Brightness.light,
                    )),
                bottomNavigationBarTheme: const BottomNavigationBarThemeData(
                    backgroundColor: Color(0xff333739),
                    type: BottomNavigationBarType.fixed,
                    selectedItemColor: Colors.white,
                    unselectedItemColor: Colors.grey,
                    elevation: 12.5),
                scaffoldBackgroundColor: const Color(0xff333739)),
            themeMode: cubit.light?ThemeMode.light:ThemeMode.dark,
            home://SignInScreen()
            FirebaseAuth.instance.currentUser==null? SignInScreen():const HomeTapScreen()
            ,debugShowCheckedModeBanner: false,

          );
        },
      )
    );
  }
}

