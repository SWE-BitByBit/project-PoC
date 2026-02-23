import 'chat_api.dart';
import 'chat.dart';
class ChatStorage {
  static const String ENDPOINT_API =
      'https://ihnq91q2lk.execute-api.eu-north-1.amazonaws.com/';
  final ChatApi api = ChatApi(ENDPOINT_API);

  Future<Chat> createNewChat() async {
    final chatId = await api.createChat("Nuova chat");
    return await api.fetchChatContent(chatId);
  }

  Future<Chat> loadChatFromId(String chatId) {
    return api.fetchChatContent(chatId);
  }

  Future<void> saveChat(Chat chat) async {
    await api.updateChatContent(chat);
  }
}