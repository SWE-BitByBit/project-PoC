import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

import 'chat.dart';
import '../../auth/authentication_service.dart';

class ChatApi {
  final String baseUrl;

  ChatApi(this.baseUrl);

  Map<String, String> _buildHeaders(String token) {
    return {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };
  }

  // GET /chats
  Future<List<Chat>> fetchChats() async {
    final user = AuthenticationService.instance.getCurrentUser();
    if (user == null) throw Exception("Utente non autenticato");

    final response = await http.get(
      Uri.parse('$baseUrl/chats'),
      headers: _buildHeaders(user.accessToken),
    );

    if (response.statusCode == 200) {
      final List<dynamic> decoded = jsonDecode(response.body);
      return decoded.map((item) => Chat.fromJson(item)).toList();
    } else {
      throw Exception('Failed to fetch chats');
    }
  }

  // POST /chats
  Future<String> createChat(String title) async {
    final user = AuthenticationService.instance.getCurrentUser();
    if (user == null) throw Exception("Utente non autenticato");

    final response = await http.post(
      Uri.parse('$baseUrl/chats'),
      headers: _buildHeaders(user.accessToken),
      body: jsonEncode({
        'title': title,
        'messages': [],
      }),
    );

    if (response.statusCode == 201) {
      final decoded = jsonDecode(response.body);
      return decoded['chat_id'];
    } else {
      throw Exception('Failed to create chat');
    }
  }

  // GET /chats/{chat_id}
  Future<Chat> fetchChatContent(String chatId) async {
    final user = AuthenticationService.instance.getCurrentUser();
    if (user == null) throw Exception("Utente non autenticato");

    final response = await http.get(
      Uri.parse('$baseUrl/chats/$chatId'),
      headers: _buildHeaders(user.accessToken),
    );

    if (response.statusCode == 200) {
      return Chat.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to fetch chat content');
    }
  }

  // POST /chats/{chat_id}
  Future<void> updateChatContent(Chat chat) async {
    final user = AuthenticationService.instance.getCurrentUser();
    if (user == null) throw Exception("Utente non autenticato");

    final response = await http.post(
      Uri.parse('$baseUrl/chats/${chat.id}'),
      headers: _buildHeaders(user.accessToken),
      body: jsonEncode({
        'title': chat.title,
        'messages': chat.messages.map((m) => m.toJson()).toList(),
      }),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to update chat');
    }
  }

  // DELETE /chats/{chat_id}
  Future<void> deleteChat(String chatId) async {
    final user = AuthenticationService.instance.getCurrentUser();
    if (user == null) throw Exception("Utente non autenticato");

    final response = await http.delete(
      Uri.parse('$baseUrl/chats/$chatId'),
      headers: _buildHeaders(user.accessToken),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to delete chat');
    }
  }
}