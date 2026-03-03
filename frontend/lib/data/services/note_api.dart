import 'dart:io';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:math' as math;
import 'package:path_provider/path_provider.dart';

import '../../domain/note.dart';
import '../../auth/authentication_service.dart';


class NoteApi {

  NoteApi(this.baseUrl);

  final String baseUrl;

  Future<File> _urlToFile(String imageUrl) async {

    var rng = math.Random();
    Directory tempDir = await getTemporaryDirectory();
    String tempPath = tempDir.path;
    File file = File('$tempPath/${rng.nextInt(100)}.jpg');
    http.Response response = await http.get(Uri.parse(imageUrl));

    await file.writeAsBytes(response.bodyBytes);
    
    return file;
  }

  Future<List<Note>> fetchNotes() async {
    final user = AuthenticationService.instance.getCurrentUser();

    if (user == null) throw Exception("Utente non autenticato");

    final response = await http.get(
      Uri.parse('$baseUrl/notes'),
      headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${user.accessToken}',
        },
    );

    print(response.body);

    if (response.statusCode == 200) {
      final List<dynamic> decoded = jsonDecode(response.body);

      final List<Note> notes = [];

      for (var item in decoded) {
        final file = await _urlToFile(item['presigned_url']);
        final note = Note.fromJson(item, file);
        notes.add(note);
      }

      return notes;
    }
    else {
      throw Exception('Failed to load notes');
    }
  }

  Future<Note> createNote(String text, File image) async {
    final user = AuthenticationService.instance.getCurrentUser();
    if (user == null) throw Exception("Utente non autenticato");

    final response = await http.post(
      Uri.parse('$baseUrl/notes'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${user.accessToken}',
      },
      body: jsonEncode(<String,String>{
        'message': text,
        'fileName': image.path.split('/').last,
      })
    );

    if (response.statusCode != 201) {
      throw Exception('Failed to create note');
    }

    print(response);

    final presignedUrl = jsonDecode(response.body)['presigned_url'];

    await http.put(
      Uri.parse(presignedUrl),
      headers: {'Content-Type': 'image/jpg'},
      body: await image.readAsBytes(),
    );

    return Note.fromJson(jsonDecode(response.body), image);
  }

}