import 'note.dart';
import 'package:flutter/material.dart';

class NotesPage extends StatelessWidget {
  const NotesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Note'),
      ),
      body: ListView.builder(
        itemCount: notes.length,
        itemBuilder: (context, index) {
          final note = notes[index];
          return ListTile(
            leading: const CircleAvatar(
              child: Icon(Icons.note),
            ),
            title: Text(note.name),
            subtitle: Text('${note.name} - ${note.date}'),
          );
        },
      ),
    );
  }
}