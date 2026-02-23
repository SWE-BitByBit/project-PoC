import 'package:flutter/material.dart';

class ChatListItem extends StatelessWidget {
  final String title;

  const ChatListItem({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(title),
    );
  }
}

class ChatbotDrawer extends StatefulWidget {
  const ChatbotDrawer({Key? key}) : super(key: key);

  @override
  State<ChatbotDrawer> createState() => _ChatbotDrawerState();
}

List<String> chats = ["Chat 1" , "Chat 2"];

class _ChatbotDrawerState extends State<ChatbotDrawer> {
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView.builder(
        itemCount: chats.length,
        itemBuilder:(context, index) {
          return ChatListItem(title: chats[index]);
        },
      ),
    );
  }
}