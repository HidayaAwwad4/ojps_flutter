import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';

class DocumentUploadButton extends StatefulWidget {
  final void Function(PlatformFile)? onFileSelected;

  const DocumentUploadButton({super.key, this.onFileSelected});

  @override
  State<DocumentUploadButton> createState() => _DocumentUploadButtonState();
}

class _DocumentUploadButtonState extends State<DocumentUploadButton> {
  PlatformFile? selectedFile;

  void _pickDocument() async {
    final result = await FilePicker.platform.pickFiles();

    if (result != null) {
      final file = result.files.first;
      setState(() => selectedFile = file);
      widget.onFileSelected?.call(file);
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: _pickDocument,
      borderRadius: BorderRadius.circular(8),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
        decoration: BoxDecoration(
          color: const Color(0xFFF9FAFB),
          border: Border.all(color: const Color(0xFFD9D9D9)),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            const Icon(Icons.upload_file, color: Color(0xFF0273B1)),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                selectedFile != null ? selectedFile!.name : 'Click to upload a document',
                style: TextStyle(
                  color: selectedFile != null ? Colors.black : const Color(0xFF0273B1),
                  fontSize: 16,
                  fontWeight: selectedFile != null ? FontWeight.normal : FontWeight.w500,
                ),
              ),
            ),
            const Icon(Icons.arrow_upward, size: 18, color: Color(0xFF0273B1)),
          ],
        ),
      ),
    );
  }
}
