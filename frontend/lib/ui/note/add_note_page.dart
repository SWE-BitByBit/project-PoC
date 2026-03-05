import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'dart:io';

import 'view_model/view_model_notes.dart';

class AddNotePage extends StatefulWidget{
  const AddNotePage({super.key, required this.viewModel});

  final ViewModelNotes viewModel;

  @override
  State<AddNotePage> createState() => _AddNotePageState();
}

class _AddNotePageState extends State<AddNotePage> {

  final ImagePicker _imagePicker = ImagePicker();
  final _textController = TextEditingController();

  File? _selectedImage;

  Future _getFromGallery() async {
    final img = await _imagePicker.pickImage(source: ImageSource.gallery);

    if (img != null) {
      setState(() {
        _selectedImage = File(img.path);
      });
    }
  }

  Future<void> _saveNote() async {

    final text = _textController.text.trim();

    if (text.isEmpty || _selectedImage == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Testo o immagine mancanti")),
      );
      return;
    }

    await widget.viewModel.addNote(
      text,
      File(_selectedImage!.path),
    );

    if (!mounted) return;
    Navigator.pop(context);
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: const Text('Nuova nota'),
        centerTitle: true,
        actions: [ 
          IconButton(
            icon: const Icon(Icons.add_a_photo),
            onPressed: _getFromGallery,
          ),
          IconButton(
            icon: const Icon(Icons.save),
            onPressed: _saveNote,
          )
        ]
      ),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            Expanded(
              child: TextField(
                controller: _textController,
                expands: true,
                maxLines: null,
                decoration: const InputDecoration(
                  hintText: 'Scrivi qui la tua nota...',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            const SizedBox(height: 12),
            _selectedImage == null
                ? const Text(
                    'No Media',
                  )
                : Text(
                      _selectedImage!.path
                    ),
          ],
        ),
      ),
    );
  }

}