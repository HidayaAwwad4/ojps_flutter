import 'package:flutter/material.dart';
import '/widgets/view&edit_profile/profile_field_widget.dart';
import '/widgets/Resume/resume_section_title.dart';
import '/constants/dimensions.dart';

class ResumeScreen extends StatefulWidget {
  const ResumeScreen({super.key});

  @override
  State<ResumeScreen> createState() => _ResumeScreenState();
}

class _ResumeScreenState extends State<ResumeScreen> {
  final TextEditingController experienceController = TextEditingController();
  final TextEditingController educationController = TextEditingController();
  final TextEditingController skillsController = TextEditingController();

  @override
  void dispose() {
    experienceController.dispose();
    educationController.dispose();
    skillsController.dispose();
    super.dispose();
  }

  void _saveResume() {
    // Save logic here (e.g. send to backend)
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Resume saved successfully.")),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Manage Resume")),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(defaultPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const ResumeSectionTitleWidget(title: "Work Experience"),
            ProfileFieldWidget(label: "Describe your experience", controller: experienceController),
            const ResumeSectionTitleWidget(title: "Education"),
            ProfileFieldWidget(label: "List your education", controller: educationController),
            const ResumeSectionTitleWidget(title: "Skills"),
            ProfileFieldWidget(label: "List your skills", controller: skillsController),
            SizedBox(height: defaultPadding),
            Center(
              child: ElevatedButton(
                onPressed: _saveResume,
                child: const Text("Save Resume"),
              ),
            )
          ],
        ),
      ),
    );
  }
}
