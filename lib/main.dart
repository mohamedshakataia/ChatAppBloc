import 'package:chatapp/cubits/bloc/auth_bloc.dart';
import 'package:chatapp/cubits/bloc/simple_bloc_osbserver.dart';
import 'package:chatapp/cubits/chat_cubit/chat_cubit.dart';
import 'package:chatapp/firebase_options.dart';
import 'package:chatapp/page/chat_page.dart';
import 'package:chatapp/page/login.dart';
import 'package:chatapp/page/register.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  Bloc.observer = SimpleBlocOsbserver();
  runApp(Chat());
}

class Chat extends StatelessWidget {
  const Chat({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => AuthBloc()),
        BlocProvider(create: (context) => ChatCubit()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        routes: {
          RegisterPage.id: (context) => RegisterPage(),
          Loginchat.id: (context) => Loginchat(),
          ChatPage.id: (context) => ChatPage(),
        },
        initialRoute: Loginchat.id,
      ),
    );
  }
}
