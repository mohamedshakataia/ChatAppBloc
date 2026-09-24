import 'package:bloc/bloc.dart';
import 'package:chatapp/models/chatmodel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';

part 'chat_event.dart';
part 'chat_state.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  ChatBloc() : super(ChatInitial()) {
    List<ChatModel> messageList = [];
    CollectionReference messages = FirebaseFirestore.instance.collection(
      'messages',
    );

    on<SendMessageBloc>((event, emit) {
      try {
        messages.add({
          'message': event.value,
          'timeMessage': event.timemeassge,
          'emailaccount': event.email,
        });
      } on Exception catch (e) {
        // TODO
      }
    });

    on<GetMessageBloc>((event, emit) async {
      await emit.forEach(
        messages.orderBy('timeMessage', descending: true).snapshots(),
        onData: (snapshots) {
          messageList.clear();

          for (var doc in snapshots.docs) {
            messageList.add(ChatModel.fromjson(doc));
          }
          return ChatSuccess(messageList);
        },
      );
    });
  }
}
