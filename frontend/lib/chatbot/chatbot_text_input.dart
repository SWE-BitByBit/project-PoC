import 'package:flutter/material.dart';

class ChatbotTextInput extends StatelessWidget {
  final TextEditingController controller;
  final VoidCallback? onSendPressed;
  final String hintText;
  
  const ChatbotTextInput({
    super.key,
    required this.controller,
    required this.onSendPressed,
    this.hintText = "Scrivi un messaggio...",
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 48.0),
      child: TextField(
        controller: controller,
        keyboardType: TextInputType.multiline,
        minLines: 1,
        maxLines: 8,
        decoration: InputDecoration(
          hintText: hintText,
          border: const OutlineInputBorder(),
          suffixIcon: Column(
            children: [
              IconButton(
                icon: const Icon(Icons.send),
                onPressed: onSendPressed,
              ),
            ],
          ),
        ),
      ),
    );
  }

}