import 'package:flutter/material.dart';
import '/widgets/Resume/resume_section_title.dart';
import '/constants/dimensions.dart';

class ViewResumeScreen extends StatelessWidget {
  const ViewResumeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final experience = "3 years as a Software Developer at ABC Tech.";
    final education = "B.Sc. in Computer Science from XYZ University.";
    final skills = "Flutter, Dart, Java, Git, REST APIs.";

    return Scaffold(
      appBar: AppBar(title: const Text("Resume Overview")),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(defaultPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const ResumeSectionTitleWidget(title: "Work Experience"),
            Text(experience, style: const TextStyle(fontSize: 16)),
            const SizedBox(height: defaultPadding),
            const ResumeSectionTitleWidget(title: "Education"),
            Text(education, style: const TextStyle(fontSize: 16)),
            const SizedBox(height: defaultPadding),
            const ResumeSectionTitleWidget(title: "Skills"),
            Text(skills, style: const TextStyle(fontSize: 16)),
          ],
        ),
      ),
    );
  }
}
