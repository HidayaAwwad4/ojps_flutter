/*import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';

class DocumentUploadButton extends StatefulWidget {
  const DocumentUploadButton({super.key});

  @override
  State<DocumentUploadButton> createState() => _DocumentUploadButtonState();
}

class _DocumentUploadButtonState extends State<DocumentUploadButton> {
  void _pickDocument() async {
    final result = await FilePicker.platform.pickFiles();

    if (result != null) {
      final file = result.files.first;
      print('Selected file: ${file.name}');
    } else {
      print('No file selected.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return OutlinedButton.icon(
      onPressed: _pickDocument,
      icon: const Icon(Icons.upload_file),
      label: const Text(
        'Upload Document',
        style: TextStyle(color: Color(0xFF0273B1)),
      ),
    );
  }
}*/

