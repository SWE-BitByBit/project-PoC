import 'package:flutter/material.dart';
import 'note.dart';
import 'app_network_image.dart';

class NotePage extends StatelessWidget {
  final Note note;

  const NotePage({super.key, required this.note});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(note.title),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemCount: note.blocks.length,
        itemBuilder: (context, index) {
          final block = note.blocks[index];
          
          return switch (block) {
            TextBlock(:final text) => Padding(
                padding: const EdgeInsets.only(bottom: 16.0),
                child: Text(
                  text,
                  style: const TextStyle(fontSize: 16),
                ),
              ),
            ImageBlock(:final imageUrl) => Padding(
                padding: const EdgeInsets.only(bottom: 16.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: AppNetworkImage(
                    imageUrl: imageUrl,
                    width: double.infinity,
                  ),
                ),
              ),
          };
        },
      ),
    );
  }
}