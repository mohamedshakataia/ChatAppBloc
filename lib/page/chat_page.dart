import 'package:chatapp/bloc/chat_bloc/chat_bloc.dart';
import 'package:chatapp/models/chatmodel.dart';
import 'package:chatapp/widget/chat_Buble.dart';
import 'package:chatapp/widget/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatPage extends StatelessWidget {
  ChatPage({super.key});
  static String id = 'ChatPage';
  List<ChatModel> m = [];

  CollectionReference messages = FirebaseFirestore.instance.collection(
    'messages',
  );
  TextEditingController controller = TextEditingController();
  final ScrollController controllerscroll = ScrollController();

  @override
  Widget build(BuildContext context) {
    var email = ModalRoute.of(context)!.settings.arguments as String;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/images/scholar.png', height: 50),
            Text('Chat', style: TextStyle(color: Colors.white)),
          ],
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: BlocConsumer<ChatBloc, ChatState>(
              listener: (context, state) {
                if (state is ChatSuccess) {
                  m = state.messageList;
                }
              },
              builder: (context, state) {
                return ListView.builder(
                  controller: controllerscroll,
                  reverse: true,
                  itemCount: m.length,
                  itemBuilder: (context, index) {
                    return m[index].emailaccount == email
                        ? ChatBuble(mesaage: m[index])
                        : ChatBubleFriend(mesaage: m[index]);
                  },
                );
              },
            ),
          ),
          Row(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 10,
                  ),
                  child: TextField(
                    controller: controller,
                    onSubmitted: (value) {
                      BlocProvider.of<ChatBloc>(context).add(
                        SendMessageBloc(
                          value: value,
                          timemeassge: DateTime.now().toString(),
                          email: email,
                        ),
                      );
                      controller.clear();
                      controllerscroll.animateTo(
                        0,
                        duration: Duration(milliseconds: 10),
                        curve: Curves.easeIn,
                      );
                    },
                    style: TextStyle(color: Colors.white, fontSize: 20),

                    decoration: InputDecoration(
                      suffixIcon: IconButton(
                        onPressed: () {},
                        icon: Icon(Icons.send),
                        color: Colors.white,
                      ),
                      hintText: 'Message',
                      hintStyle: TextStyle(color: Colors.white),
                      filled: true,
                      fillColor: kPrimaryColor,
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 10,
                      ),

                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
