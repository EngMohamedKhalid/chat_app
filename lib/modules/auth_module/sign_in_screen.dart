// ignore_for_file: avoid_print
import 'package:chat_app/layout/home_layout/home_screen.dart';
import 'package:chat_app/shared/components/custom_buttons/custom_button.dart';
import 'package:chat_app/shared/components/custom_text_field/custom_statefull_field.dart';
import 'package:chat_app/shared/components/custom_text_field/custom_stateless_field.dart';
import 'package:chat_app/shared/components/custom_buttons/custom_text_button.dart';
import 'package:chat_app/shared/network/remote/auth/sign_in_service.dart';
import 'package:chat_app/modules/chats_module/chats_screen.dart';
import 'package:flutter/material.dart';

class SignInScreen extends StatelessWidget {
   SignInScreen({Key? key}) : super(key: key);
static final TextEditingController emailController = TextEditingController();
final TextEditingController passwordController = TextEditingController();
GlobalKey<FormState> formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 15),
              child: Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Wellcome back!",
                      style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.w700,
                          color: Colors.deepOrange
                      ),
                    ),
                    const SizedBox(height: 12,),
                    const Text(
                      "Login into your account",
                      style: TextStyle(
                          fontSize: 16.5,
                          fontWeight: FontWeight.w400,
                          color: Colors.grey
                      ),
                    ),
                    const SizedBox(height: 100,),
                     CustomStatelessTextField(controller: emailController,lableText: "Email",),
                    const SizedBox(height: 25,),
                     CustomStateFullTextField(controller: passwordController,text: "Password"),
                    const SizedBox(height: 60,),
                    CustomButton(
                      minWidth: 411,
                      onPressed: (){
                        if(formKey.currentState!.validate()){
                          SignInModel.signIn(
                              emailAddress: emailController.text,
                              password: passwordController.text,
                              context: context
                          ).then((value) {
                            Navigator.pushReplacement(context,
                                MaterialPageRoute(builder: (context) =>  const HomeTapScreen())
                            );
                          });
                        }
                      },
                      text: "Login",
                    ),
                    const SizedBox(height: 20,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Don't have an account yet?",
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w400,
                              color: Colors.grey
                          ),
                        ),
                        const SizedBox(width: 2),
                        CustomTextButton(onPressed: (){
                          Navigator.pushNamed(context, "signUp",);
                        }, text: "Sign Up")
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      )
    );
  }
}



