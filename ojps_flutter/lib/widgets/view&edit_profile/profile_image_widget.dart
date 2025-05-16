import 'package:flutter/material.dart';
import '/constants/colors.dart';

class ProfileImageWidget extends StatefulWidget {
  final String? imagePath;
  final bool isEditable;

  const ProfileImageWidget({super.key, this.imagePath , this.isEditable = true,});

  @override
  State<ProfileImageWidget> createState() => _ProfileImageWidgetState();
}

class _ProfileImageWidgetState extends State<ProfileImageWidget> {
  String? imagePath;

  @override
  void initState() {
    super.initState();
    imagePath = widget.imagePath;
  }

  void _removeImage() {
    setState(() {
      imagePath = null;
    });
  }

  void _uploadImage() async {
    setState(() {
      imagePath = 'assets/sample_profile.png';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        CircleAvatar(
          radius: 50,
          backgroundColor: profileColor,
          backgroundImage:
          imagePath != null ? AssetImage(imagePath!) : null,
          child: imagePath == null
              ? Icon(Icons.person, size: 50, color: primaryColor)
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
              backgroundColor: primaryColor,
              child: Icon(Icons.edit, size: 15, color: Colors.white),
            ),
          ),
        )
      ],
    );
  }
}
