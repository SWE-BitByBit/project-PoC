class ChatMessage {
  final String text;
  final bool isUser;

  ChatMessage({required this.text, required this.isUser});

  Map<String, String> toJson() {
    return {'text': text, 'sender': isUser ? 'user' : 'chatbot'};
  }

  factory ChatMessage.fromJson(Map<String, dynamic> json) {
    return ChatMessage(text: json['text'], isUser: json['sender'] == 'user');
  }
}
