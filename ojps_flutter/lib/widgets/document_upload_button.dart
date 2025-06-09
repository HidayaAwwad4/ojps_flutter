import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';

import '../constants/colors.dart';
import '../constants/dimensions.dart';
import '../constants/spaces.dart';

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
      borderRadius: BorderRadius.circular(AppDimensions.borderRadiusSmall),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: AppDimensions.horizontalSpacerLarge, vertical: 18),
        decoration: BoxDecoration(
          color: const Color(0xFFF9FAFB),
          border: Border.all(color: const Color(0xFFD9D9D9)),
          borderRadius: BorderRadius.circular(AppDimensions.borderRadiusSmall),
        ),
        child: Row(
          children: [
            const Icon(Icons.upload_file, color: Colorss.primaryColor),
            Spaces.horizontal(AppDimensions.horizontalSpacerNormal),
            Expanded(
              child: Text(
                selectedFile != null ? selectedFile!.name : tr('btn_upload_document'),
                style: TextStyle(
                  color: selectedFile != null ? Colorss.primaryTextColor : Colorss.primaryColor,
                  fontSize: AppDimensions.fontSizeNormal,
                  fontWeight: selectedFile != null ? FontWeight.normal : FontWeight.w500,
                ),
              ),
            ),
            const Icon(Icons.arrow_upward, size: AppDimensions.iconSizeXSmall, color: Colorss.primaryColor),
          ],
        ),
      ),
    );
  }
}
