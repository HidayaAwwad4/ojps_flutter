import 'package:flutter/material.dart';
import '/constants/colors.dart';
import '/constants/dimensions.dart';

class ProfileImageWidget extends StatefulWidget {
  final String? imagePath;

  const ProfileImageWidget({super.key, this.imagePath});

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
    // Simulate image picker here
    setState(() {
      imagePath = 'assets/sample_profile.png'; // Example path
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        CircleAvatar(
          radius: 50,
          backgroundColor: backgroundColor,
          backgroundImage:
          imagePath != null ? AssetImage(imagePath!) : null,
          child: imagePath == null
              ? Icon(Icons.person, size: 50, color: primaryTextColor)
              : null,
        ),
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
