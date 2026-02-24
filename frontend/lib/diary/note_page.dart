import 'package:flutter/material.dart';
import 'note.dart';

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
            TextBlock() => Padding(
                padding: const EdgeInsets.only(bottom: 16.0),
                child: Text(
                  block.text,
                  style: const TextStyle(fontSize: 16),
                ),
              ),
            ImageBlock() => Padding(
                padding: const EdgeInsets.only(bottom: 16.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: Image.network(
                    block.imageUrl,
                    width: double.infinity,
                    fit: BoxFit.cover,
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress == null) return child;
                      return Center(
                        child: CircularProgressIndicator(
                          value: loadingProgress.expectedTotalBytes != null
                              ? loadingProgress.cumulativeBytesLoaded /
                                  loadingProgress.expectedTotalBytes!
                              : null,
                        ),
                      );
                    },
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        color: Colors.grey.shade200,
                        child: const Center(
                          child: Icon(Icons.broken_image, color: Colors.grey),
                        ),
                      );
                    },
                  )
                ),
              ),
          };
        },
      ),
    );
  }
}