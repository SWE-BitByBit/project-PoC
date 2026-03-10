import 'chat_api.dart';
import 'chat.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
class ChatStorage {
  static final String ENDPOINT_API =
      dotenv.env['API_BASE_URL'] ?? '';
  final ChatApi api = ChatApi(ENDPOINT_API);

  Future<Chat> createNewChat() async {
    final chatId = await api.createChat("Nuova chat");
    return await api.fetchChatContent(chatId);
  }

  Future<Chat> loadChatFromId(String chatId) {
    return api.fetchChatContent(chatId);
  }

  Future<List<Chat>> loadAllChats() {
    return api.fetchChats();
  }

  Future<void> saveChat(Chat chat) async {
    await api.updateChatContent(chat);
  }
}