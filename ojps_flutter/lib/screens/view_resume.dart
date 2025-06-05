import 'package:flutter/material.dart';
import 'package:ojps_flutter/constants/colors.dart';
import '../widgets/view&edit_profile/profile_image_widget.dart';
import '../widgets/Resume/profile_display_field_widget.dart';
import '../models/resume_model.dart';
import '../Services/resume_service.dart';
import 'package:ojps_flutter/constants/colors.dart';

class ViewResumeScreen extends StatefulWidget {
  @override
  _ViewResumeScreenState createState() => _ViewResumeScreenState();
}

class _ViewResumeScreenState extends State<ViewResumeScreen> {
  ResumeModel? resumeData;
  bool isLoading = true;
  bool hasUploadedFile = false;

  @override
  void initState() {
    super.initState();
    loadResumeData();
  }

  Future<void> loadResumeData() async {
    final data = await ResumeService.fetchResumeData();
    final hasFile = await ResumeService.checkUploadedResumeFile();

    setState(() {
      resumeData = data;
      hasUploadedFile = hasFile;
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      appBar: AppBar(
          title: Text('View Resume'),
        centerTitle: true,
        leading: const BackButton(),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            ProfileImageWidget(imagePath: resumeData!.imageUrl, isEditable: false),
            SizedBox(height: 10),
            Text(
              resumeData!.fullName,
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            ProfileDisplayFieldWidget(icon: Icons.email, value: resumeData!.email),
            ProfileDisplayFieldWidget(icon: Icons.location_on, value: resumeData!.location),
            ProfileDisplayFieldWidget(icon: Icons.phone, value: resumeData!.phone),

            sectionTitle("Summary"),
            Text(resumeData!.summary),

            sectionTitle("Work Experience"),
            ...resumeData!.workExperiences.map((exp) => ListTile(
              title: Text(exp.position),
              subtitle: Text("${exp.company}\n${exp.description}"),
              trailing: Text(exp.duration , style: TextStyle(color: Colorss.lightGrey )),
              isThreeLine: true,
            )),

            sectionTitle("Education"),
            ...resumeData!.educations.map((edu) => ListTile(
              title: Text(edu.degree),
              subtitle: Text("${edu.university}\n${edu.details}"),
              trailing: Text(edu.duration , style: TextStyle(color: Colorss.lightGrey),),
              isThreeLine: true,
            )),

            if (hasUploadedFile) ...[
              SizedBox(height: 20),
              ElevatedButton.icon(
                onPressed: () {
                  ResumeService.downloadResumeFile();
                },
                icon: Icon(Icons.download , color: Colorss.primaryColor,),
                label: Text("Download Resume (PDF,DOC)" , style: TextStyle(color: Colorss.primaryColor),),

              ),
              Text("Download existing file", style: TextStyle(color: Colors.grey)),
            ]
          ],
        ),
      ),
    );
  }

  Widget sectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(top: 24, bottom: 8),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(title, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
      ),
    );
  }
}
