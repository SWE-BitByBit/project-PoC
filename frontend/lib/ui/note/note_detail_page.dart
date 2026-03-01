import 'package:flutter/material.dart';

import '../../domain/note.dart';

class NotePage extends StatelessWidget {
  final Note note;

  const NotePage({super.key, required this.note});

  @override
  Widget build(BuildContext context) {
    final formattedDate =
        "${note.noteCreatedTime.day.toString().padLeft(2, '0')}/"
        "${note.noteCreatedTime.month.toString().padLeft(2, '0')}/"
        "${note.noteCreatedTime.year}";
    
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              formattedDate,
              style: const TextStyle(
                color: Colors.grey,
                fontSize: 14,
              ),
            ),
            Text(
              note.noteText,
              style: const TextStyle(fontSize: 16),
            ),
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.file(
                note.image,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
          ],
        )
      ),
    );
  }
}