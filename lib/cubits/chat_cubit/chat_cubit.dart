import 'package:bloc/bloc.dart';
import 'package:chatapp/models/chatmodel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

part 'chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  ChatCubit() : super(ChatInitial());

  CollectionReference messages = FirebaseFirestore.instance.collection(
    'messages',
  );
  List<ChatModel> messageList = [];

  void sendMessage({
    required String value,
    required String timemeassge,
    required String email,
  }) {
    try {
      messages.add({
        'message': value,
        'timeMessage': timemeassge,
        'emailaccount': email,
      });
    } on Exception catch (e) {
      // TODO
    }
  }

  void getMessage() {
    messages.orderBy('timeMessage', descending: true).snapshots().listen((
      event,
    ) {
      messageList.clear();
      for (var doc in event.docs) {
        print('doc${doc}');
        messageList.add(ChatModel.fromjson(doc));
      }
      emit(ChatSuccess());
    });
  }
}
