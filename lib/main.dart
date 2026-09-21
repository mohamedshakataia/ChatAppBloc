import 'package:chatapp/firebase_options.dart';
import 'package:chatapp/page/chat_page.dart';
import 'package:chatapp/page/login.dart';
import 'package:chatapp/page/register.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(Chat());
}

class Chat extends StatelessWidget {
  const Chat({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        RegisterPage.id: (context) => RegisterPage(),
        Loginchat.id: (context) => Loginchat(),
        ChatPage.id: (context) => ChatPage(),
      },
      initialRoute: Loginchat.id,
    );
  }
}
