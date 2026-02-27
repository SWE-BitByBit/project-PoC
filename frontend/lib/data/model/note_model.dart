import '../../domain/note.dart';

class NoteModel extends Note{

  NoteModel({
    required super.noteId,
    super.noteCreatedTime,
    required super.noteText,
    required super.image
  });

  factory NoteModel.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {
        'note_id': String noteId,
        'created_at': DateTime date,
        'message': String text,
        'presigned_url': String img
      } => NoteModel(
        noteId: noteId,
        noteCreatedTime: date,
        noteText: text,
        image: img
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