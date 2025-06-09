import 'package:flutter/material.dart';
import 'package:ojps_flutter/models/user_data.dart';
import '../constants/spaces.dart';
import '../constants/text_styles.dart';
import '/widgets/view&edit_profile/profile_image_widget.dart';
import '/widgets/view&edit_profile/profile_field_widget.dart';
import '/constants/colors.dart';
import '/constants/dimensions.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../services/profile_service.dart';
import '../services/job_seeker_service.dart';

class ViewEditSeekerProfile extends StatefulWidget {
  const ViewEditSeekerProfile({super.key});

  @override
  State<ViewEditSeekerProfile> createState() => _ViewEditSeekerProfileState();
}

class _ViewEditSeekerProfileState extends State<ViewEditSeekerProfile> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController summaryController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  final ProfileService _profileService = ProfileService();
  final JobSeekerService _jobSeekerService = JobSeekerService();

  @override
  void initState() {
    super.initState();
    _loadProfile();

    nameController.addListener(() => setState(() {}));
    emailController.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    summaryController.dispose();
    super.dispose();
  }

  Future<void> _loadProfile() async {
    final jobSeeker = await _jobSeekerService.getJobSeekerProfile();

    if (jobSeeker != null) {
      setState(() {
        nameController.text = jobSeeker.name ?? '';
        emailController.text = jobSeeker.email ?? '';
        summaryController.text = jobSeeker.summary ?? '';
      });
    }
  }

  void _handleLogout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();

    if (!mounted) return;
    Navigator.pushNamedAndRemoveUntil(context, '/Login', (route) => false);
  }

  void _navigateToResumePage() {
    Navigator.pushNamed(context, '/manage_resume');
  }

  Future<void> _saveChanges() async {
    if (!_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please complete all required fields correctly'),
        ),
      );
      return;
    }

    final success = await _profileService.updateBasicInfo(
      name: nameController.text.trim(),
      email: emailController.text.trim(),
      summary: summaryController.text.trim(),
    );

    if (success) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Changes saved successfully'),
          backgroundColor: Colorss.successValidation,
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Failed to save changes. Please try again.'),
          backgroundColor: Colorss.errorColor,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: const Text("Profile"),
        centerTitle: true,
        leading: BackButton(
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            tooltip: 'Logout',
            onPressed: _handleLogout,
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppDimensions.defaultPadding),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ProfileImageWidget(imagePath: UserData().profileImage, isEditable: true),
              Spaces.vertical(10),
              Text(
                nameController.text.isEmpty ? "Your Name" : nameController.text,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              Spaces.vertical(4),
              Text(
                emailController.text.isEmpty ? "your.email@example.com" : emailController.text,
                style: const TextStyle(color: Colorss.secondaryTextColor),
              ),
              Spaces.vertical(20),
              ProfileFieldWidget(
                label: "Full Name",
                controller: nameController,
                keyboardType: TextInputType.text,
                enabled: true,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Name is required';
                  } else if (value.trim().length < 4) {
                    return 'Name must be at least 4 characters';
                  }
                  return null;
                },
              ),
              ProfileFieldWidget(
                label: "Email",
                controller: emailController,
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Email is required';
                  } else if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                    return 'Enter a valid email address';
                  }
                  return null;
                },
              ),
              ProfileFieldWidget(
                label: "Summary",
                controller: summaryController,
                keyboardType: TextInputType.multiline,
              ),
              TextButton(
                onPressed: _navigateToResumePage,
                child: const Text(
                  "Manage Resume",
                  style: TextStyle(color: Colorss.primaryColor),
                ),
              ),
              Spaces.vertical(20),
              ElevatedButton(
                onPressed: _saveChanges,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colorss.primaryColor,
                ),
                child: const Text(
                  "Save Changes",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
