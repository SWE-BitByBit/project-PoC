import 'package:flutter/material.dart';
import 'chatbot.dart';
import 'chatbot_text_input.dart';
import 'chat_message.dart';
import 'message_bubble.dart';


class ChatbotPage extends StatefulWidget {
  const ChatbotPage({Key? key}) : super(key: key);

  @override
  State<ChatbotPage> createState() => _ChatbotPageState();
}

class _ChatbotPageState extends State<ChatbotPage> {
  final TextEditingController inputController = TextEditingController();
  final List<ChatMessage> messages = [];
  final Chatbot chatbot = Chatbot();

  void sendMessage(String userInputText) {
    if(userInputText.isEmpty) return;

    setState(() => messages.add(ChatMessage(text: userInputText, isUser: true)));
    inputController.clear();

    chatbot.sendUserMessage(userInputText, (String response) {
      setState(() => messages.add(ChatMessage(text: response, isUser: false)));
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
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(8),
              itemCount: messages.length,
              itemBuilder: (context, index) {
                return MessageBubble(message: messages[index]);
              },
            )
          ),

          ChatbotTextInput(
            controller: inputController,
            onSendPressed: () {
              sendMessage(inputController.text);
            },
            hintText: "Scrivi un messaggio...",
          )
        ],
      ),
    );
  }
}
