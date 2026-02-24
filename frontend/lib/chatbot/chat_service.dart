import 'chatbot.dart';
import 'chat.dart';
import 'chat_storage.dart';
import 'chat_message.dart';

class ChatService {
  final ChatStorage _storage = ChatStorage();
  final Chatbot _chatbot = Chatbot();
  ChatService() {}

  Future<Chat> startNewChat() async {
    return _storage.createNewChat();
  }

  Future<List<Chat>> getUserChatHistory() {
    return _storage.loadAllChats();
  }

  Future<Chat> getChatById(String chatId) async {
    return _storage.loadChatFromId(chatId);
  }

  Future<void> saveChat(Chat chat) async {
    return _storage.saveChat(chat);
  }

  Future<String> generateChatTitle(Chat chat) async {
    const CHAT_TITLE_PROMPT = 'Generate a super short, descriptive and concise title for the following user message; important: use maximum of 5 words. Do not make mistakes. Here is the user prompt to generate a title from; generate the title and nothing else before it:';
    ChatMessage? firstMessage = chat.getFirstMessage();
    if(firstMessage == null) {
      if(chat.creationDate == null) return Future.value("Nuova chat");

      String hour = chat.creationDate!.hour.toString().padLeft(2, '0');
      String minute = chat.creationDate!.minute.toString().padLeft(2, '0');
      String day = chat.creationDate!.day.toString().padLeft(2, '0');
      String month = chat.creationDate!.month.toString().padLeft(2, '0');
      String year = chat.creationDate!.year.toString();

      String formattedDate = "$day/$month/$year $hour:$minute";
      return Future.value("Chat del $formattedDate");
    }

    String FirstMessageString = firstMessage.text;
    String newTitle = await sendPromptToChatbot("$CHAT_TITLE_PROMPT $FirstMessageString");

    chat.setTitle(newTitle);
    await saveChat(chat);
    
    return newTitle;
  }

  Future<String> sendPromptToChatbot(String message) async {
    String response;
    try {
      response = await _chatbot.sendMessage(message);
    } catch (e) {
      response = "Errore nella generazione della risposta";
    }
    return response;
  }

  Future<String> requestChatbotResponse(Chat chat, String message) async {
    String response;
    try {
      response = await _chatbot.sendMessage(message);
    } catch (e) {
      response = "Errore nella generazione della risposta";
    }
    chat.addChatbotMessage(response);
    saveChat(chat);
    return response;
  }
}