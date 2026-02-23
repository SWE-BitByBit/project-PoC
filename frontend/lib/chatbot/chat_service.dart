import 'chatbot.dart';
import 'chat.dart';
import 'chat_storage.dart';

class ChatService {
  final ChatStorage _storage = ChatStorage();
  final Chatbot _chatbot = Chatbot();
  ChatService() {}

  Future<Chat> startNewChat() async {
    return _storage.createNewChat();
  }

  Future<Chat> getChatById(String chatId) async {
    return _storage.loadChatFromId(chatId);
  }

  Future<void> saveChat(Chat chat) async {
    return _storage.saveChat(chat);
  }

  Future<String> sendMessageToChatbot(Chat chat, String message) async {
    chat.addUserMessage(message);
    String response;
    try {
      response = await _chatbot.sendUserMessage(message);
    } catch (e) {
      response = "Errore nella generazione della risposta";
    }
    chat.addChatbotMessage(response);
    saveChat(chat);
    return response;
  }
}