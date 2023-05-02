// ignore_for_file: avoid_print, use_full_hex_values_for_flutter_colors
import 'dart:io';
import 'package:chat_app/layout/home_layout/home_screen.dart';
import 'package:chat_app/models/take_photo.dart';
import 'package:chat_app/shared/components/attachments/pick_profile_photo.dart';
import 'package:chat_app/shared/components/custom_buttons/custom_button.dart';
import 'package:chat_app/shared/components/custom_text_field/custom_statefull_field.dart';
import 'package:chat_app/shared/components/custom_text_field/custom_stateless_field.dart';
import 'package:chat_app/shared/components/custom_buttons/custom_text_button.dart';
import 'package:chat_app/shared/network/remote/auth/sign_up_service.dart';
import 'package:flutter/material.dart';

class SignUpScreen extends StatefulWidget {
 const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController userNameController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  void takePhotoRequiredFunction() {
    setState(() {
      TakePhoto.image = File(TakePhoto.pickedImage.path);
    });
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        body:SingleChildScrollView(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 20,horizontal: 15),
              child: Form(
                key: formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(height: 20,),
                    InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: const [
                          Icon(
                            Icons.arrow_back_ios_sharp,
                            size: 25,
                            color:  Colors.deepOrange
                            //Color(0xffE5E2E2FF),
                          ),
                          SizedBox(width: 15,),
                          Text(
                            "Create Account",
                            style: TextStyle(
                                fontSize: 21,
                                fontWeight: FontWeight.w700,
                                color: Colors.deepOrange
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 60,),
                    InkWell(
                      onTap: ()async{
                        await TakePhoto.pickFromGallery(
                            fn: takePhotoRequiredFunction
                        );
                      },
                      child: Stack(
                        alignment: Alignment.bottomRight,
                        children:  [
                          CircleAvatar(
                          backgroundImage: TakePhoto.image == null ? null : FileImage(TakePhoto.image!),
                            radius: 78,
                            backgroundColor: Colors.deepOrange,
                          ),
                          const Padding(
                            padding: EdgeInsets.only(top: 10,left: 30),
                            child: CircleAvatar(
                              radius: 25,
                              backgroundColor: Colors.black,
                              child: Icon(
                                Icons.camera_alt,
                                size: 30,
                                color:   Colors.white,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    const SizedBox(height: 45,),
                     CustomStatelessTextField(controller: userNameController,lableText: "Full Name"),
                    const SizedBox(height: 20,),
                     CustomStatelessTextField(controller: emailController ,lableText: "Email"),
                    const SizedBox(height: 20,),
                     CustomStateFullTextField(controller: passwordController ,text: "Password"),
                    const SizedBox(height: 40,),
                    CustomButton(
                        onPressed: (){
                          if(formKey.currentState!.validate()){
                            SignUpModel.signUp(
                                username: userNameController.text,
                                emailAddress: emailController.text,
                                password: passwordController.text,
                                context: context
                            ).then((value){
                              pickProfilePhoto().then((value) {
                                Navigator.of(context).pushReplacement(
                                    MaterialPageRoute(builder: (context) => const HomeTapScreen(),)
                                );
                              }).catchError((error){
                                ScaffoldMessenger.of(context).showSnackBar(
                                   const SnackBar(
                                      backgroundColor: Colors.deepOrange,
                                      content: Text(
                                        'You Must Choose your Profile Photo ',
                                        style: TextStyle(fontSize: 18.0, color: Colors.white),
                                      ),
                                    )
                                );
                              });
                            });
                          }
                    }, text: "Create Account", minWidth: 411),
                    const SizedBox(height: 20,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Already have an account?",
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w400,
                              color: Colors.grey
                          ),
                        ),
                        const SizedBox(width: 2),
                        CustomTextButton(onPressed: (){
                          Navigator.pop(context);
                        },
                            text: "Login",
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ) ,
      )
    );
  }
}
