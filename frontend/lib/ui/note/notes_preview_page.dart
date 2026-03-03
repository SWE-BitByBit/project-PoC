import 'package:flutter/material.dart';

import 'note_detail_page.dart';
import 'view_model/view_model_notes.dart';
import 'add_note_page.dart';

class NotesPage extends StatelessWidget {
  const NotesPage({super.key, required this.viewModel});

  final ViewModelNotes viewModel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListenableBuilder(
        listenable: viewModel, 
        builder: (context, _) {
          return GridView.builder(
            padding: const EdgeInsets.all(8.0),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 8.0,
              mainAxisSpacing: 8.0,
            ),
            itemCount: viewModel.notes.length,
            itemBuilder: (context, index) {
              final note = viewModel.notes[index];

              return Card(
                clipBehavior: Clip.antiAlias,
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => NotePage(note: note ))
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "Nota del ${note.noteCreatedTime.year}-${note.noteCreatedTime.month.toString().padLeft(2, '0')}-${note.noteCreatedTime.day.toString().padLeft(2, '0')}",
                      textAlign: TextAlign.center,
                    )
                  ),
                ),
              );
            },
          );
        }
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => AddNotePage(viewModel: viewModel),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}