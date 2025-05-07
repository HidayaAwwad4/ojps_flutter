import 'package:flutter/material.dart';
import '../EditableField.dart';
import 'EmployerProfile.dart';

class EmployerProfilePage extends StatefulWidget {
  final Employer employer;

  const EmployerProfilePage({super.key, required this.employer});

  @override
  State<EmployerProfilePage> createState() => _EmployerProfilePageState();
}

class _EmployerProfilePageState extends State<EmployerProfilePage> {
  late TextEditingController nameCtrl;
  late TextEditingController companyCtrl;
  late TextEditingController emailCtrl;
  late TextEditingController phoneCtrl;
  late TextEditingController locationCtrl;
  late TextEditingController bioCtrl;

  @override
  void initState() {
    super.initState();
    nameCtrl = TextEditingController(text: widget.employer.fullName);
    companyCtrl = TextEditingController(text: widget.employer.company);
    emailCtrl = TextEditingController(text: widget.employer.email);
    phoneCtrl = TextEditingController(text: widget.employer.phone);
    locationCtrl = TextEditingController(text: widget.employer.location);
    bioCtrl = TextEditingController(text: widget.employer.bio);
  }

  @override
  void dispose() {
    nameCtrl.dispose();
    companyCtrl.dispose();
    emailCtrl.dispose();
    phoneCtrl.dispose();
    locationCtrl.dispose();
    bioCtrl.dispose();
    super.dispose();
  }

  void _saveChanges() {
    String name = nameCtrl.text.trim();
    String company = companyCtrl.text.trim();
    String email = emailCtrl.text.trim();
    String phone = phoneCtrl.text.trim();
    String location = locationCtrl.text.trim();
    String bio = bioCtrl.text.trim();

    // Simulated save action
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Profile Saved"),
        content: Text(
          "Name: $name\nCompany: $company\nEmail: $email\nPhone: $phone\nLocation: $location\nBio: $bio",
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text("OK")),
        ],
      ),
    );
  }

  void _cancelChanges() {
    nameCtrl.text = widget.employer.fullName;
    companyCtrl.text = widget.employer.company;
    emailCtrl.text = widget.employer.email;
    phoneCtrl.text = widget.employer.phone;
    locationCtrl.text = widget.employer.location;
    bioCtrl.text = widget.employer.bio;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const CircleAvatar(
              radius: 40,
              child: Icon(Icons.business, size: 40),
            ),
            const SizedBox(height: 10),
            Text(
              widget.employer.fullName,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            Text(
              widget.employer.email,
              style: const TextStyle(color: Colors.grey),
            ),
            const SizedBox(height: 24),

            EditableField(
              label: 'Full Name',
              hint: 'Enter your full name',
              controller: nameCtrl,
            ),
            EditableField(
              label: 'Company',
              hint: 'Enter your company name',
              controller: companyCtrl,
            ),
            EditableField(
              label: 'Email',
              hint: 'Enter your email address',
              controller: emailCtrl,
            ),
            EditableField(
              label: 'Phone',
              hint: 'Enter your phone number',
              controller: phoneCtrl,
            ),
            EditableField(
              label: 'Location',
              hint: 'Enter your location',
              controller: locationCtrl,
            ),
            EditableField(
              label: 'Bio',
              hint: 'Write a short description about your company',
              controller: bioCtrl,
              maxLines: 3,
            ),
            const SizedBox(height: 24),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                OutlinedButton(onPressed: _cancelChanges, child: const Text('Cancel')),
                ElevatedButton(onPressed: _saveChanges, child: const Text('Save Changes')),
              ],
            )
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 3,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.bookmark), label: 'Save'),
          BottomNavigationBarItem(icon: Icon(Icons.notifications), label: 'Notification'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
    );
  }
}
