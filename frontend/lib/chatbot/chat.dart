import 'chat_message.dart';

class Chat {
  int? id;
  String title;
  List<ChatMessage> messages;

  Chat({
    this.id,
    required this.title,
    required this.messages,
  });

  factory Chat.fromJson(Map<String, dynamic> json) {
    final List<dynamic> messageList = json['message'] ?? [];

    return Chat(
      id: json['id'],
      title: json['title'],
      messages: messageList
          .map((m) => ChatMessage.fromJson(m))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'message': messages.map((m) => m.toJson()).toList(),
    };
  }

  void addUserMessage(String message) {
    messages.add(ChatMessage(text: message, isUser: true));
  }

  void addChatbotMessage(String message) {
    messages.add(ChatMessage(text: message, isUser: false));
  }
}