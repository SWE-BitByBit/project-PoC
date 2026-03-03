import 'package:flutter/material.dart';
import 'chat.dart';

class ChatListItem extends StatelessWidget {
  final String title;
  final VoidCallback onTap;

  const ChatListItem({
    super.key,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile (
      title: Text(title),
      hoverColor: const Color.fromARGB(255, 161, 221, 255),
      onTap: onTap,
    );
  }
}

class ChatbotDrawer extends StatelessWidget {
  final List<Chat> chatHistory;
  final Function(Chat) onChatSelected;
  final Future<void> Function() onNewChatRequested;

  const ChatbotDrawer({
    super.key,
    required this.chatHistory,
    required this.onChatSelected,
    required this.onNewChatRequested,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          ListTile(
            leading: const Icon(Icons.add),
            title: const Text('Nuova chat'),
            tileColor: Color.fromARGB(255, 0, 0, 0),
            textColor: Color.fromARGB(255, 255, 255, 255),
            iconColor: Color.fromARGB(255, 255, 255, 255),
            hoverColor: Color.fromARGB(255, 39, 39, 39),
            onTap: () async {
              await onNewChatRequested();
            },
          ),
          ...chatHistory.map(
            (chat) => ChatListItem(
              title: chat.title,
              onTap: () => onChatSelected(chat),
            ),
          ),
        ],
      ),
    );
  }
}