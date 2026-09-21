import 'package:chatapp/models/chatmodel.dart';
import 'package:chatapp/widget/chat_Buble.dart';
import 'package:chatapp/widget/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class ChatPage extends StatelessWidget {
  ChatPage({super.key});
  static String id = 'ChatPage';
  CollectionReference messages = FirebaseFirestore.instance.collection(
    'messages',
  );
  TextEditingController controller = TextEditingController();
  final ScrollController controllerscroll = ScrollController();

  @override
  Widget build(BuildContext context) {
    var email = ModalRoute.of(context)!.settings.arguments;
    return StreamBuilder(
      stream: messages.orderBy('Time', descending: true).snapshots(),
      builder: ((context, snapshot) {
        if (snapshot.hasData) {
          List<ChatModel> messageslist = [];
          for (int i = 0; i < snapshot.data!.docs.length; i++) {
            messageslist.add(ChatModel.fromjson(snapshot.data!.docs[i]));
          }
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
                  child: ListView.builder(
                    controller: controllerscroll,
                    reverse: true,
                    itemCount: messageslist.length,
                    itemBuilder: (context, index) {
                      return messageslist[index].emailaccount == email
                          ? ChatBuble(mesaage: messageslist[index])
                          : ChatBubleFriend(mesaage: messageslist[index]);
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
                            messages.add({
                              'message': value,
                              'Time': DateTime.now(),
                              'emailaccount': email,
                            });
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
        } else {
          return Text('loading.....');
        }
      }),
    );
  }
}
