import 'package:chatapp/bloc/auth_bloc/auth_bloc.dart';
import 'package:chatapp/helper/showsnackbar.dart';
import 'package:chatapp/page/login.dart';
import 'package:chatapp/widget/constants.dart';
import 'package:chatapp/widget/custom_button.dart';
import 'package:chatapp/widget/custom_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});
  static String id = 'RegisterPage';
  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  String? email;
  String? password;
  bool isloaging = false;
  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: false,
      child: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is RegisterLoading) {
            isloaging = true;
          } else if (state is RegisterSuccess) {
            messagesnackbar(context, 'Success Register');
            Navigator.pushNamed(context, Loginchat.id);
            isloaging = false;
          } else if (state is RegisterFailure) {
            messagesnackbar(context, state.errorMessage);
          }
        },
        builder: (context, state) {
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
                  ontap: () {
                    BlocProvider.of<AuthBloc>(
                      context,
                    ).add(RegisterEvent(email: email!, password: password!));
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
                      child: Text(
                        ' Login ',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
