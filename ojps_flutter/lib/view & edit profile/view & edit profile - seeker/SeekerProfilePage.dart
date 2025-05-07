import 'package:flutter/material.dart';
import '../EditableField.dart';
import 'SeekerProfile.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class SeekerProfilePage extends StatefulWidget {
  final SeekerProfile seeker;
  const SeekerProfilePage({super.key, required this.seeker});

  @override
  State<SeekerProfilePage> createState() => _SeekerProfilePageState();
}

class _SeekerProfilePageState extends State<SeekerProfilePage> {
  late TextEditingController nameCtrl;
  late TextEditingController emailCtrl;
  late TextEditingController phoneCtrl;
  late TextEditingController bioCtrl;

  File? _imageFile;

  @override
  void initState() {
    super.initState();
    nameCtrl = TextEditingController(text: widget.seeker.fullName);
    emailCtrl = TextEditingController(text: widget.seeker.email);
    phoneCtrl = TextEditingController(text: widget.seeker.phone);
    bioCtrl = TextEditingController(text: widget.seeker.bio);
  }

  @override
  void dispose() {
    nameCtrl.dispose();
    emailCtrl.dispose();
    phoneCtrl.dispose();
    bioCtrl.dispose();
    super.dispose();
  }

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Seeker Profile')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Profile Image Picker
            Center(
              child: GestureDetector(
                onTap: _pickImage,
                child: CircleAvatar(
                  radius: 50,
                  backgroundImage: _imageFile != null ? FileImage(_imageFile!) : null,
                  child: _imageFile == null
                      ? const Icon(Icons.person, size: 50)
                      : null,
                ),
              ),
            ),
            const SizedBox(height: 20),
            EditableField(
              label: 'Full Name',
              hint: 'Enter your full name',
              controller: nameCtrl,
              validator: (value) =>
              value == null || value.isEmpty ? 'Name is required' : null,
            ),
            EditableField(
              label: 'Email',
              hint: 'Enter your email address',
              controller: emailCtrl,
              keyboardType: TextInputType.emailAddress,
              validator: (value) {
                if (value == null || value.isEmpty) return 'Email is required';
                if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                  return 'Enter a valid email';
                }
                return null;
              },
            ),
            EditableField(
              label: 'Phone',
              hint: 'e.g., 0591234567',
              controller: phoneCtrl,
              keyboardType: TextInputType.phone,
              validator: (value) {
                if (value == null || value.isEmpty) return 'Phone is required';
                if (!RegExp(r'^05[9|8|7]\d{7}$').hasMatch(value)) {
                  return 'Enter a valid phone number';
                }
                return null;
              },
            ),
            EditableField(
              label: 'Bio',
              hint: 'Write a short bio about yourself',
              controller: bioCtrl,
              maxLines: 3,
            ),
            const SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                OutlinedButton(
                  onPressed: () {
                    // Reset to initial values
                    nameCtrl.text = widget.seeker.fullName;
                    emailCtrl.text = widget.seeker.email;
                    phoneCtrl.text = widget.seeker.phone;
                    bioCtrl.text = widget.seeker.bio;
                  },
                  child: const Text('Cancel'),
                ),
                ElevatedButton(
                  onPressed: () {
                    // Save changes
                    debugPrint("Name: ${nameCtrl.text}");
                    debugPrint("Email: ${emailCtrl.text}");
                    debugPrint("Phone: ${phoneCtrl.text}");
                    debugPrint("Bio: ${bioCtrl.text}");
                    debugPrint("Picked Image Path: ${_imageFile?.path}");
                    // You can send these to your backend or update a model
                  },
                  child: const Text('Save Changes'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
