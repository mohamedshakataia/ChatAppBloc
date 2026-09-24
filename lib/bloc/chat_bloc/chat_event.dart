part of 'chat_bloc.dart';

@immutable
sealed class ChatEvent {}

class SendMessageBloc extends ChatEvent {
  final String value;
  final String timemeassge;
  final String email;

  SendMessageBloc({
    required this.value,
    required this.timemeassge,
    required this.email,
  });
}

class GetMessageBloc extends ChatEvent {
  List<ChatModel> messageList = [];
}
