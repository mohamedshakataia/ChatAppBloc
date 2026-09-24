import 'package:chatapp/bloc/auth_bloc/auth_bloc.dart';
import 'package:chatapp/bloc/chat_bloc/chat_bloc.dart';

import 'package:chatapp/helper/showsnackbar.dart';
import 'package:chatapp/page/chat_page.dart';
import 'package:chatapp/page/register.dart';
import 'package:chatapp/widget/constants.dart';
import 'package:chatapp/widget/custom_button.dart';
import 'package:chatapp/widget/custom_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class Loginchat extends StatefulWidget {
  const Loginchat({super.key});
  static String id = 'Loginchat';

  @override
  State<Loginchat> createState() => _LoginchatState();
}

class _LoginchatState extends State<Loginchat> {
  String? email;

  String? password;

  bool isloading = false;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is LoginLoading) {
          isloading = true;
        } else if (state is LoginSuccess) {
          BlocProvider.of<ChatBloc>(context).add(GetMessageBloc());
          Navigator.pushNamed(context, ChatPage.id, arguments: email);
          isloading = false;
        } else if (state is LoginFailure) {
          messagesnackbar(context, state.errorMessage);
          isloading = false;
        }
      },
      builder: (context, state) {
        return ModalProgressHUD(
          inAsyncCall: isloading,
          child: Scaffold(
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
                  ontap: () {
                    BlocProvider.of<AuthBloc>(
                      context,
                    ).add(LoginEvent(email: email!, password: password!));
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
          ),
        );
      },
    );
  }
}
