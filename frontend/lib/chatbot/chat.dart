import 'chat_message.dart';

class Chat {
  String? id;
  DateTime? creationDate;
  String title;
  List<ChatMessage> messages;

  Chat({
    this.id,
    this.creationDate,
    required this.title,
    required this.messages,
  });

  factory Chat.fromJson(Map<String, dynamic> json) {
    final List<dynamic> messageList = json['messages'] ?? [];

    return Chat(
      id: json['chat_id'],
      title: json['title'],
      creationDate: DateTime.parse(json['created_at']),
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

    factory Chat.empty() {
    return Chat(
      id: null,
      creationDate: DateTime.now(),
      title: "Nuova chat",
      messages: [],
    );
  }

  bool isEmpty() {
    return messages.isEmpty;
  }

  void addUserMessage(String message) {
    messages.add(ChatMessage(text: message, isUser: true));
  }

  void addChatbotMessage(String message) {
    messages.add(ChatMessage(text: message, isUser: false));
  }

  void setTitle(String newTitle) {
    title = newTitle;
  }

  ChatMessage? getFirstMessage() {
    return messages.isNotEmpty ? messages[0] : null;
  }

  ChatMessage? getLastMessage() {
    return messages.isNotEmpty ? messages[messages.length - 1] : null;
  }
}