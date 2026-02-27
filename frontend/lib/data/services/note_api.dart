import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

import '../../data/model/note_model.dart';
import '../../auth/authentication_service.dart';

class NoteApi {

  NoteApi(this.baseUrl);

  final String baseUrl;

  Future<List<NoteModel>> fetchNotes() async {
    final user = AuthenticationService.instance.getCurrentUser();

    if (user == null) throw Exception("Utente non autenticato");

    final response = await http.get(
      Uri.parse('$baseUrl/notes'),
      headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${user.accessToken}',
        },
    );

    if (response.statusCode == 200) {
      final List<dynamic> decoded = jsonDecode(response.body);

      final List<NoteModel> notes = [];

      for (var item in decoded) {
        final contact = NoteModel.fromJson(item);
        notes.add(contact);
      }

      return notes;
    }
    else {
      throw Exception('Failed to load notes');
    }
  }

  Future<NoteModel> createNote(String text, String image) async {

  }

}