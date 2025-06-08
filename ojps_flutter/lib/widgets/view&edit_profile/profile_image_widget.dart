import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ojps_flutter/models/user_data.dart';
import '/constants/colors.dart';

class ProfileImageWidget extends StatefulWidget {
 final Object? imagePath;
  final bool isEditable;

  const ProfileImageWidget({
    super.key,
    this.imagePath ,
    this.isEditable = false,});

  @override
  State<ProfileImageWidget> createState() => _ProfileImageWidgetState();
}

class _ProfileImageWidgetState extends State<ProfileImageWidget> {
  Object? image;

  @override
  void initState() {
    super.initState();
   image = widget.imagePath;
  }

  Future<void> _uploadImage() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);

    if (pickedFile != null){
      final file = File(pickedFile.path);
      setState(() {
        image = file;
        UserData().imageFile = file;
        UserData().imageUrl = null;
      });
    }
  }

  void _removeImage() {
    setState(() {
      image = null;
      UserData().imageFile = null;
      UserData().imageUrl = null;
    });
  }



  @override
  Widget build(BuildContext context) {
    ImageProvider? provider;

    if (image is File) {
      provider = FileImage(image as File);
    } else if (image is String && (image as String).isNotEmpty){
      provider = NetworkImage(image as String);
    }

    return Stack(
      children: [
        CircleAvatar(
          radius: 50,
          backgroundColor: Colorss.profileColor,
          backgroundImage:
          provider,
          child: provider == null
              ? Icon(Icons.person, size: 50, color: Colorss.primaryColor)
              : null,
        ),
        if (widget.isEditable)
        Positioned(
          bottom: 0,
          right: 0,
          child: PopupMenuButton<String>(
            onSelected: (value) {
              if (value == 'upload') _uploadImage();
              if (value == 'remove') _removeImage();
            },
            itemBuilder: (_) => [
              const PopupMenuItem(value: 'upload', child: Text('Upload')),
              const PopupMenuItem(value: 'remove', child: Text('Remove')),
            ],
            child: const CircleAvatar(
              radius: 15,
              backgroundColor: Colorss.primaryColor,
              child: Icon(Icons.edit, size: 15, color: Colors.white),
            ),
          ),
        )
      ],
    );
  }
}
