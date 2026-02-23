import 'package:flutter/material.dart';
import 'chatbot_text_input.dart';
import 'chat_message.dart';
import 'chatbot_drawer.dart';
import 'chat.dart';
import 'message_bubble.dart';
import 'chat_service.dart';

class ChatbotPage extends StatefulWidget {
  const ChatbotPage({Key? key}) : super(key: key);

  @override
  State<ChatbotPage> createState() => _ChatbotPageState();
}

class _ChatbotPageState extends State<ChatbotPage> {
  final TextEditingController inputController = TextEditingController();
  final ChatService chatService = ChatService();
  Chat? currentChat;
  List<ChatMessage> messages = [];

  @override
  void initState() {
    super.initState();
    _initializeChat();
  }

  Future<void> _initializeChat() async {
    currentChat = await chatService.startNewChat();
    setState(() {
      messages = List.from(currentChat!.messages);
    });
  }

  Future<void> sendMessage(String userInputText) async {
    if (userInputText.isEmpty || currentChat == null) return;
    setState(() {
      messages.add(ChatMessage(text: userInputText, isUser: true));
    });
    inputController.clear();
    String response = await chatService.sendMessageToChatbot(currentChat!, userInputText);
    setState(() {
      messages.add(ChatMessage(text: response, isUser: false));
    });
  }

  @override
  void dispose() {
    inputController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Chatbot')),
      drawer: ChatbotDrawer(),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(8),
              itemCount: messages.length,
              itemBuilder: (context, index) {
                return MessageBubble(message: messages[index]);
              },
            ),
          ),
          ChatbotTextInput(
            controller: inputController,
            onSendPressed: () {
              sendMessage(inputController.text);
            },
            hintText: "Scrivi un messaggio...",
          ),
        ],
      ),
    );
  }
}