
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widget_previews.dart';

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

    //viewModel.addNote(text, File(_selectedImage.path));
    // Chiamata per salvare la nota alla funzione del MV

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
                  )
                : ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Text(
                      _selectedImage!.path
                    ),
                  ),
          ],
        ),
      ),
    );
  }

}