
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widget_previews.dart';
import 'dart:io';

class AddNotePage extends StatefulWidget{
  
  @Preview(name: 'Preview add note page')
  const AddNotePage({super.key});

  @override
  State<AddNotePage> createState() => _AddNotePageState();
}

class _AddNotePageState extends State<AddNotePage> {

  final ImagePicker _imagePicker = ImagePicker();
  XFile? _selectedImage;

  Future _getFromGallery() async {
    final XFile? img = await _imagePicker.pickImage(source: ImageSource.gallery);

    if (img != null) {
      setState(() {
        _selectedImage = img;
      });
    }
  }

  Future<void> _saveNote() async {
    final note = Note(
      text: _controller.text,
      imagePath: _selectedImage?.path,
      createdAt: DateTime.now(),
    );

    final box = await Hive.openBox('notes');
    await box.add(note);

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
            onPressed: () {
              Navigator.pop(context);
              _getFromGallery();
            },
            icon: Icon(Icons.add_a_photo),
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
                expands: true,
                maxLines: null,
                textAlignVertical: TextAlignVertical.top,
                decoration: const InputDecoration(
                  hintText: 'Scrivi qui la tua nota...',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            const SizedBox(height: 16),
            _selectedImage == null
                ? const Text(
                    'No Media',
                    style: TextStyle(fontSize: 18, color: Colors.grey),
                  )
                : ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.file(
                      File(_selectedImage!.path),
                      height: 150,
                      fit: BoxFit.cover,
                    ),
                  ),
          ],
        ),
      ),
    );
  }

}