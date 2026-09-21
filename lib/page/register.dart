import 'package:chatapp/helper/showsnackbar.dart';
import 'package:chatapp/page/login.dart';
import 'package:chatapp/widget/constants.dart';
import 'package:chatapp/widget/custom_button.dart';
import 'package:chatapp/widget/custom_field.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';

class RegisterPage extends StatelessWidget {
  RegisterPage({super.key});
  static String id = 'RegisterPage';

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
              'Register',

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
                    .createUserWithEmailAndPassword(
                      email: email!,
                      password: password!,
                    );
                messagesnackbar(context, 'Success Register');
              } on FirebaseAuthException catch (e) {
                if (e.code == 'weak-password') {
                  messagesnackbar(
                    context,
                    'The password provided is too weak.',
                  );
                } else if (e.code == 'email-already-in-use') {
                  messagesnackbar(
                    context,
                    'TThe account already exists for that email.',
                  );
                }
              } catch (e) {
                messagesnackbar(context, e.toString());
              }
            },
            button: 'Register',
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
                  Navigator.pushNamed(context, Loginchat.id);
                },
                child: Text(' Login ', style: TextStyle(color: Colors.white)),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
