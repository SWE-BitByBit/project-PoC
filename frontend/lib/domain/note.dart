import 'dart:io';

class Note {
  final String noteId;
  final DateTime noteCreatedTime;
  final String noteText;
  final File image;

  Note({
    required this.noteId,
    required this.noteCreatedTime,
    required this.noteText,
    required this.image
  });

  factory Note.fromJson(Map<String, dynamic> json, File imageFile) {
    return switch (json) {
      {
        'note_id': String noteId,
        'created_at': DateTime date,
        'message': String text,
      } => Note(
        noteId: noteId,
        noteCreatedTime: date,
        noteText: text,
        image: imageFile
      ),
      _ => throw const FormatException('Failed to load note from json.'), 
    };
  }

  Map<String, dynamic> toJson() {
    return {
      'note_id': noteId,
      'message': noteText,
      'fileName': image,
    };
  }
}