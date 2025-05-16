import 'package:flutter/material.dart';
import '../constants/colors.dart';
import '/widgets/view&edit_profile/profile_field_widget.dart';
import '/widgets/Resume/resume_section_title.dart';
import '/constants/dimensions.dart';

class ManageResumeScreen extends StatefulWidget {
  const ManageResumeScreen({super.key});

  @override
  State<ManageResumeScreen> createState() => _ResumeScreenState();
}

class _ResumeScreenState extends State<ManageResumeScreen> {
  final TextEditingController personalDataController = TextEditingController();
  final TextEditingController summaryController = TextEditingController();
  final TextEditingController experienceController = TextEditingController();
  final TextEditingController educationController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadResumeData();
  }

  void _loadResumeData() async {
    // Replace this with your database call
    await Future.delayed(const Duration(milliseconds: 500));
    setState(() {
      personalDataController.text="Lorem.ipsum112@example.com";
      summaryController.text="Detail-oriented software engineer with 4+ years of experience in full-stack development."
          " Skilled in React, Node.js, and database design."
          " Passionate about building scalable web apps and seeking to contribute to innovative tech teams.";
      experienceController.text = '2 years as Flutter Developer at XYZ';
      educationController.text = 'Bachelor in Computer Science';
    });
  }

  @override
  void dispose() {
    personalDataController.dispose();
    summaryController.dispose();
    experienceController.dispose();
    educationController.dispose();
    super.dispose();
  }

  void _saveResume() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Resume saved successfully.")),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text("Manage Resume"),
        centerTitle: true,
        leading: const BackButton(),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(defaultPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ProfileFieldWidget(label: "Personal data", controller: personalDataController),
            ProfileFieldWidget(label: "Summary", controller: summaryController),
            ProfileFieldWidget(label: "Experience", controller: experienceController),
            ProfileFieldWidget(label: "Education", controller: educationController),
            SizedBox(height: defaultPadding),
            Center(
              child:ElevatedButton(
                onPressed: _saveResume,
                style: ElevatedButton.styleFrom(
                    backgroundColor: primaryColor
                ),
                child: const Text(
                  "Save & View Resume",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
