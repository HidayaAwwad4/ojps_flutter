

import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../constants/colors.dart';
import '../constants/dimensions.dart';
import '/widgets/view&edit_profile/profile_field_widget.dart';
import '/widgets/Resume/resume_field_dropdown_widget.dart';

class ManageResumeScreen extends StatefulWidget {
  const ManageResumeScreen({super.key});

  @override
  State<ManageResumeScreen> createState() => _ManageResumeScreenState();
}

class _ManageResumeScreenState extends State<ManageResumeScreen> {
  File? selectedFile;
  String? fileName;

  void _showUploadDialog() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf', 'doc', 'docx'],
    );

    if (result != null && result.files.single.path != null) {
      File file = File(result.files.single.path!);
      int fileSize = await file.length(); // in bytes

      // 5MB = 5 * 1024 * 1024 bytes = 5242880
      if (fileSize <= 5242880) {
        setState(() {
          selectedFile = file;
          fileName = result.files.single.name;
        });
        Navigator.of(context).pop();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("File '${fileName!}' uploaded successfully")),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("File size must be under 5MB")),
        );
      }
    }
  }

  // Personal Data Controllers
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController locationController = TextEditingController();

  // Summary
  final TextEditingController summaryController = TextEditingController();

  // Work Experience (Initial Single Entry)
  List<Map<String, TextEditingController>> workExperienceList = [];

  // Education
  List<Map<String, dynamic>> educationList = [];

  final List<String> degrees = [
    "In progress",
    "Diploma",
    "Bachelor",
    "Master",
    "Doctor of philosophy",
    "Professional Doctorate"
  ];
  String? selectedDegree;
  final TextEditingController institutionController = TextEditingController();
  final TextEditingController eduStartDateController = TextEditingController();
  final TextEditingController eduEndDateController = TextEditingController();
  final TextEditingController gpaController = TextEditingController();
  final TextEditingController honorsController = TextEditingController();


  void _openUploadDialogBox() {
    showDialog(
      context: context,
      builder: (_) =>
          AlertDialog(
            title: const Text("Upload Resume"),
            content: const Text("Choose a PDF or Word document (Max 5MB)"),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text("Cancel"),
              ),
              ElevatedButton(
                onPressed: _showUploadDialog,
                child: const Text("Choose File"),
              ),
            ],
          ),
    );
  }

  void _addWorkExperienceEntry() {
    workExperienceList.add({
      'jobTitle': TextEditingController(),
      'company': TextEditingController(),
      'startDate': TextEditingController(),
      'endDate': TextEditingController(),
      'bulletPoint': TextEditingController(),
    });
    setState(() {});
  }


  void _addEducationEntry() {
    setState(() {
      educationList.add({
        'degree': null,
        'institution': TextEditingController(),
        'startDate': TextEditingController(),
        'endDate': TextEditingController(),
        'gpa': TextEditingController(),
        'honors': TextEditingController(),
      });
    });
  }

  void _loadResumeData() async {
    await Future.delayed(const Duration(milliseconds: 500));
    setState(() {
      fullNameController.text = "John Doe";
      emailController.text = "john.doe@example.com";
      phoneController.text = "+1234567890";
      locationController.text = "New York";

      summaryController.text = "Passionate software developer...";

      selectedDegree = "Bachelor";
      institutionController.text = "ABC University";
      gpaController.text = "3.9";
      honorsController.text = "With Distinction";
    });
  }

  Future<void> _selectDate(
      BuildContext context, TextEditingController controller) async {
    DateTime? picked = await showDatePicker(
      context: context,
      firstDate: DateTime(1980),
      lastDate: DateTime(2100),
      initialDate: DateTime.now(),
    );
    if (picked != null) {
      controller.text = DateFormat('yyyy-MM-dd').format(picked);
    }
  }

  void _saveResume() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Resume saved successfully.")),
    );
  }


  @override
  void initState() {
    super.initState();
    _loadResumeData();
    _addWorkExperienceEntry();
    _addEducationEntry(); // Initialize with one education entry

  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Manage Resume"),
        centerTitle: true,
        leading: const BackButton(),
        actions: [
          IconButton(
            onPressed: _openUploadDialogBox,
            icon: const Icon(Icons.upload_file),
            tooltip: 'Upload Resume',
          ),
        ],
      ),

      body: SingleChildScrollView(
        padding: EdgeInsets.all(defaultPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ResumeFieldDropdownWidget(
              title: "Personal Data",
              children: [
                if (fileName != null)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: Text("Uploaded File: $fileName",
                        style: const TextStyle(fontWeight: FontWeight.bold)),
                  ),
                ProfileFieldWidget(label: "Full Name", controller: fullNameController),
                ProfileFieldWidget(label: "Email", controller: emailController),
                ProfileFieldWidget(label: "Phone Number", controller: phoneController),
                ProfileFieldWidget(
                  label: "Location",
                  controller: locationController,
                  icon: Icons.location_on,
                ),
              ],
            ),
            ResumeFieldDropdownWidget(
              title: "Summary",
              children: [
                ProfileFieldWidget(
                  label: "Description",
                  controller: summaryController,
                  maxLines: 5,
                ),
              ],
            ),
            ResumeFieldDropdownWidget(
              title: "Work Experience",
              children: [
                for (int i = 0; i < workExperienceList.length; i++) ...[
                  ProfileFieldWidget(label: "Job Title", controller: workExperienceList[i]['jobTitle']!),
                  ProfileFieldWidget(label: "Company", controller: workExperienceList[i]['company']!),
                  GestureDetector(
                    onTap: () => _selectDate(context, workExperienceList[i]['startDate']!),
                    child: AbsorbPointer(
                      child: ProfileFieldWidget(label: "Start Date", controller: workExperienceList[i]['startDate']!),
                    ),
                  ),
                  GestureDetector(
                    onTap: () => _selectDate(context, workExperienceList[i]['endDate']!),
                    child: AbsorbPointer(
                      child: ProfileFieldWidget(label: "End Date", controller: workExperienceList[i]['endDate']!),
                    ),
                  ),
                  ProfileFieldWidget(
                    label: "Responsibilities / Achievements",
                    controller: workExperienceList[i]['bulletPoint']!,
                    maxLines: 3,
                  ),
                  const Divider(),
                ],
                Align(
                  alignment: Alignment.centerLeft,
                  child: TextButton.icon(
                    onPressed: _addWorkExperienceEntry,
                    icon: const Icon(Icons.add),
                    label: const Text("Add Work Experience"),
                  ),
                )
              ],
            ),
            ResumeFieldDropdownWidget(
              title: "Education",
              children: [
                for (int i = 0; i < educationList.length; i++) ...[
                  DropdownButtonFormField<String>(
                    value: educationList[i]['degree'],
                    items: degrees
                        .map((degree) => DropdownMenuItem(
                      value: degree,
                      child: Text(degree),
                    ))
                        .toList(),
                    onChanged: (value) {
                      setState(() {
                        educationList[i]['degree'] = value;
                      });
                    },
                    decoration: const InputDecoration(labelText: "Degree"),
                  ),
                  ProfileFieldWidget(
                    label: "Institution",
                    controller: educationList[i]['institution'],
                  ),
                  GestureDetector(
                    onTap: () => _selectDate(context, educationList[i]['startDate']),
                    child: AbsorbPointer(
                      child: ProfileFieldWidget(
                        label: "Start Date",
                        controller: educationList[i]['startDate'],
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () => _selectDate(context, educationList[i]['endDate']),
                    child: AbsorbPointer(
                      child: ProfileFieldWidget(
                        label: "End Date",
                        controller: educationList[i]['endDate'],
                      ),
                    ),
                  ),
                  ProfileFieldWidget(
                    label: "GPA",
                    controller: educationList[i]['gpa'],
                  ),
                  ProfileFieldWidget(
                    label: "Honors",
                    controller: educationList[i]['honors'],
                  ),
                  const Divider(),
                ],
                Align(
                  alignment: Alignment.centerLeft,
                  child: TextButton.icon(
                    onPressed: _addEducationEntry,
                    icon: const Icon(Icons.add),
                    label: const Text("Add Education"),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: _saveResume,
                style: ElevatedButton.styleFrom(backgroundColor: primaryColor),
                child: const Text(
                  "Save & View Resume",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

