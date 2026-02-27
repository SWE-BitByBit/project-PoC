import 'package:flutter/material.dart';
import '../../diary/note.dart'; 
import 'note_detail_page.dart';
import '../../diary/app_network_image.dart';

import 'package:flutter/widget_previews.dart';

class NotesPage extends StatelessWidget {
  @Preview(name: 'Constructor preview')
  const NotesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Note'),
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(8.0),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 8.0,
          mainAxisSpacing: 8.0,
        ),
        itemCount: notes.length,
        itemBuilder: (context, index) {
          final note = notes[index];
          final coverImage = note.blocks.whereType<ImageBlock>().firstOrNull;

          return Card(
            clipBehavior: Clip.antiAlias,
            child: InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => NotePage(note: note)),
                );
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: coverImage != null
                        ? AppNetworkImage(
                            imageUrl: coverImage.imageUrl,
                            width: double.infinity,
                          )
                        : Container(color: Colors.grey.shade200),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 4),
                        Center(
                          child: Text(
                            "${note.date.year}-${note.date.month.toString().padLeft(2, '0')}-${note.date.day.toString().padLeft(2, '0')}", 
                            style: const TextStyle(color: Colors.grey, fontSize: 12),
                          )
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
      bottomNavigationBar: BottomNotesBar(),
    );
  }
}

class BottomNotesBar extends StatelessWidget {

  const BottomNotesBar({super.key});

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      child: Center(
        child: ElevatedButton.icon(
          icon: const Icon(Icons.add),
          label: const Text('Aggiungi nota'),
          iconAlignment: IconAlignment.start,
          onPressed: () {},
        )
      )
    );
  }
}