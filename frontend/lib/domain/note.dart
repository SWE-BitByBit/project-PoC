class Note {
  final String noteId;
  DateTime? noteCreatedTime;
  final String noteText;
  final String image;

  Note({
    required this.noteId,
    this.noteCreatedTime,
    required this.noteText,
    required this.image
  });
}