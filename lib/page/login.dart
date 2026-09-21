import 'package:chatapp/helper/showsnackbar.dart';
import 'package:chatapp/page/chat_page.dart';
import 'package:chatapp/page/register.dart';
import 'package:chatapp/widget/constants.dart';
import 'package:chatapp/widget/custom_button.dart';
import 'package:chatapp/widget/custom_field.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';

class Loginchat extends StatelessWidget {
  Loginchat({super.key});
  static String id = 'Loginchat';
  String? email;
  String? password;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryColor,
      body: ListView(
        children: [
          Image.asset('assets/images/scholar.png', height: 100),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Scholar Chat',
                style: TextStyle(
                  fontSize: 32,
                  fontFamily: 'Pacifico',
                  color: Colors.white,
                ),
              ),
            ],
          ),
          SizedBox(height: 60),
          Container(
            padding: EdgeInsets.only(left: 10),
            alignment: Alignment.topLeft,
            child: Text(
              'Login',

              style: TextStyle(
                fontSize: 24,
                fontFamily: 'Pacifico',
                color: Colors.white,
              ),
            ),
          ),
          SizedBox(height: 15),
          CustomField(
            onChanged: (data) {
              email = data;
            },
            hint: 'Email',
          ),
          SizedBox(height: 10),
          CustomField(
            onChanged: (data) {
              password = data;
            },
            hint: 'Password',
          ),
          SizedBox(height: 10),
          CustomButton(
            ontap: () async {
              try {
                final credential = await FirebaseAuth.instance
                    .signInWithEmailAndPassword(
                      email: email!,
                      password: password!,
                    );
                messagesnackbar(context, 'Success');
                Navigator.pushNamed(context, ChatPage.id, arguments: email);
              } on FirebaseAuthException catch (e) {
                if (e.code == 'user-not-found') {
                  messagesnackbar(context, 'No user found for that email');
                } else if (e.code == 'wrong-password') {
                  messagesnackbar(
                    context,
                    'Wrong password provided for that user.',
                  );
                }
              } catch (e) {
                messagesnackbar(context, e.toString());
              }
              ;
            },
            button: 'Login',
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'don’t have an account ',
                style: TextStyle(color: Colors.white),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, RegisterPage.id);
                },
                child: Text(
                  ' Register ',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
