// ignore_for_file: avoid_single_cascade_in_expression_statements
import 'package:chat_app/modules/auth_module/sign_in_screen.dart';
import 'package:chat_app/shared/components/custom_buttons/custom_button.dart';
import 'package:chat_app/shared/components/custom_text_field/custom_stateless_field.dart';
import 'package:chat_app/shared/network/remote/auth/reset_password_service.dart';
import 'package:flutter/material.dart';

class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({Key? key}) : super(key: key);

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
 final  TextEditingController emailCont = TextEditingController();
@override
  void dispose() {
    super.dispose();
    emailCont.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ListView(
        children: [
          CustomStatelessTextField(
            controller: emailCont,
              lableText: "Enter Your Email",
          ),
          const SizedBox(height: 25,),
          CustomButton(
            minWidth: 300,
              text: "Save Changes",
              onPressed: ()async {
              await reseatPassword(context: context ,email: emailCont.text.trim() ).then((value) {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => SignInScreen())
                );
              });
              },
          )
        ],
      ),
    );
  }
}
