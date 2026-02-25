import 'chat_message.dart';
import 'dart:convert';

class Chat {
  int id;
  String title = '';
  List<ChatMessage> messages = [];

  Chat(String json) :
    id = jsonDecode(json)['id'],
    title = jsonDecode(json)['title'] {
      var data = jsonDecode(json);
      for (var message in data['message']) {
        messages.add(
          ChatMessage(text: message['text'], isUser: message['isUser']),
        );
      }
  }
}
