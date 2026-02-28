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
    // generate random number.
    var rng = math.Random();
    // get temporary directory of device.
    Directory tempDir = await getTemporaryDirectory();
    // get temporary path from temporary directory.
    String tempPath = tempDir.path;
    // create a new file in temporary path with random file name.
    File file = File('$tempPath/${rng.nextInt(100)}.png');
    // call http.get method and pass imageurl into it to get response.
    http.Response response = await http.get(Uri.parse(imageUrl));
    // write bodybytes received in response to file.
    await file.writeAsBytes(response.bodyBytes);
    // now return the file which is created with random name in
    // temporary directory and image bytes from response is written to // that file.
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

    if (response.statusCode == 200) {
      final List<dynamic> decoded = jsonDecode(response.body);

      final List<Note> notes = [];

      for (var item in decoded) {
        final file = await _urlToFile(item['presigned_url']);
        final contact = Note.fromJson(item, file);
        notes.add(contact);
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
        'fileName': image.path,
      })
    );

    if (response.statusCode != 201) {
      throw Exception('Failed to create note');
    }

    final presignedUrl = jsonDecode(response.body)['presigned_url'];

    await http.put(
      Uri.parse(presignedUrl),
      headers: {'Content-Type': 'application/octet-stream'},
      body: await image.readAsBytes(),
    );

    return Note.fromJson(jsonDecode(response.body), image);
  }

}