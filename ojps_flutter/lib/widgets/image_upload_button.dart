import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../constants/colors.dart';
import '../constants/dimensions.dart';

class ImageUploadButton extends StatefulWidget {
  final void Function(File?) onImageSelected;

  const ImageUploadButton({super.key, required this.onImageSelected});

  @override
  State<ImageUploadButton> createState() => _ImageUploadButtonState();
}

class _ImageUploadButtonState extends State<ImageUploadButton> {
  File? _selectedImage;

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      final file = File(pickedFile.path);
      setState(() {
        _selectedImage = file;
      });
      widget.onImageSelected(file);
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _pickImage,
      child: CircleAvatar(
        radius: AppDimensions.jobCardImageSize,
        backgroundColor: Colorss.greyColor,
        backgroundImage: _selectedImage != null ? FileImage(_selectedImage!) : null,
        child: _selectedImage == null
            ? const Icon(Icons.camera_alt, color: Colorss.buttonInactiveBackgroundColor, size: AppDimensions.iconSizeLarge)
            : null,
      ),
    );
  }
}
