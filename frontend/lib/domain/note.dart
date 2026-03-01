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
    return Note(
      noteId: json['note_id'],
      noteCreatedTime: DateTime.parse(json['created_at']),
      noteText: json['message'],
      image: imageFile,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'note_id': noteId,
      'message': noteText,
      'fileName': image.path.split('/').last,
    };
  }
}