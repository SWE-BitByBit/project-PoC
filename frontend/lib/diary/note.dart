sealed class NoteBlock {}

class TextBlock extends NoteBlock {
  final String text;
  TextBlock(this.text);
}

class ImageBlock extends NoteBlock {
  final String imageUrl;
  ImageBlock(this.imageUrl);
}

class Note {
  final String title;
  final String date;
  final List<NoteBlock> blocks;

  Note({
    required this.title,
    required this.date,
    required this.blocks,
  });
}

final List<Note> notes = [
  Note(
    title: 'Gita a Roma',
    date: '2024-06-01',
    blocks: [
      ImageBlock('https://picsum.photos/seed/roma/400/200'),
      TextBlock('Il Colosseo è stato fantastico.'),
      TextBlock('Ecco un\'altra foto del viaggio:'),
      ImageBlock('https://picsum.photos/seed/roma2/400/200'),
    ],
  ),
  Note(
    title: 'Appunti Flutter',
    date: '2024-06-02',
    blocks: [
      TextBlock('Pattern Matching con Dart 3.'),
      TextBlock('Le sealed classes sono ottime per il domain layer.'),
      ImageBlock('https://upload.wikimedia.org/wikipedia/commons/3/35/YuanEmperorAlbumGenghisPortrait.jpg'),
    ],
  ),
];