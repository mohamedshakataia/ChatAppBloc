class ChatModel {
  final String message;
  final String emailaccount;

  ChatModel({required this.message, required this.emailaccount});

  factory ChatModel.fromjson(Datajson) {
    return ChatModel(
      message: Datajson['message'],
      emailaccount: Datajson['emailaccount'],
    );
  }
}
