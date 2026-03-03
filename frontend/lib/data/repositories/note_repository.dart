import 'dart:io';

import '../../domain/note.dart';
import '../../data/services/note_api.dart';

class NoteRepository {
  final NoteApi _api;

  NoteRepository({
    required NoteApi api,
  }) : _api = api;

  Future<List<Note>> fetchNotes() {
    return _api.fetchNotes();
  }

  Future<Note> createNote(String text, File image) {
    return _api.createNote(text, image);
  }
}