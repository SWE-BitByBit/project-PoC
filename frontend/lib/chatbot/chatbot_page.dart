import 'package:flutter/material.dart';
import 'chatbot_text_input.dart';
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
  Chat currentChat = Chat.empty();
  List<Chat> chatHistory = [];

  @override
  void initState() {
    super.initState();
    _initializeChatData();
  }

  Future<void> _initializeChatData() async {
    await _initializeChat();
    await _refreshChatHistory();
  }

  Future<void> _initializeChat() async {
    currentChat = await chatService.startNewChat();
    setState(() {});
  }

  Future<void> _refreshChatHistory() async {
    List<Chat> fetchedHistory = await chatService.getUserChatHistory();
    setState(() {
      chatHistory = fetchedHistory;
    });
  }

  Future<void> _sendMessage(String userInputText) async {
    bool isNewChat = currentChat.isEmpty();
    if (userInputText.isEmpty) return;
    inputController.clear();

    currentChat.addUserMessage(userInputText);
    setState(() {});
    await chatService.requestChatbotResponse(currentChat, userInputText);
    setState(() {});

    if(isNewChat) {
      await chatService.generateChatTitle(currentChat);
      await _refreshChatHistory();
    }
  }

  Future<void> _startNewChat() async {
    Navigator.pop(context);
    currentChat = Chat.empty();
    setState(() {});
    await _initializeChatData();
  }

  Future<void> _loadChat(Chat chat) async {
    if(chat.id == null) return;
    Chat loadedChat = await chatService.getChatById(chat.id!);

    setState(() {
      currentChat = loadedChat;
    });

    Navigator.pop(context);
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
      drawer: ChatbotDrawer(
        chatHistory: chatHistory,
        onChatSelected: _loadChat,
        onNewChatRequested: _startNewChat,
      ),
      body: Column(
        children: [
          Expanded(
            child: ChatbotContent(chat: currentChat)
          ),
          ChatbotTextInput(
            controller: inputController,
            onSendPressed: () {
              _sendMessage(inputController.text);
            },
            hintText: "Scrivi un messaggio...",
          ),
        ],
      ),
    );
  }
}

class ChatbotContent extends StatelessWidget {
  final Chat chat;

  const ChatbotContent({
    super.key,
    required this.chat,
  });

  @override
  Widget build(BuildContext context) {
    if (chat.messages.isEmpty) {
      return const Center(
        child: Text(
          'Benvenuto nel chatbot!',
          style: TextStyle(fontSize: 18, color: Colors.grey),
          textAlign: TextAlign.center,
        ),
      );
    }

    return ListView.builder(
      key: ValueKey(chat.id),
      padding: const EdgeInsets.all(8),
      itemCount: chat.messages.length,
      itemBuilder: (context, index) {
        return MessageBubble(message: chat.messages[index]);
      },
    );
  }
}