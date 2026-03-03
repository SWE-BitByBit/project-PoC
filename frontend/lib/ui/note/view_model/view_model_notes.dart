import 'package:flutter/foundation.dart';
import 'dart:io';

import '../../../data/repositories/note_repository.dart';
import '../../../domain/note.dart';

class ViewModelNotes extends ChangeNotifier {

  ViewModelNotes({
    required NoteRepository noteRepository,
  }) : _repository = noteRepository {
    _load();
  }

  final NoteRepository _repository;

  final List<Note> _notes = [];
  List<Note> get notes => _notes;

  Future<void> _load() async {
    final fetched = await _repository.fetchNotes();
    _notes.clear();
    _notes.addAll(fetched);
    notifyListeners();
  }

  Future<void> addNote(String text, File image) async {
    final created = await _repository.createNote(text, image);
    _notes.insert(0, created);
    notifyListeners();

  }
}