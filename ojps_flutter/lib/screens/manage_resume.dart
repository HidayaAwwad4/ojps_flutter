import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:ojps_flutter/models/resume_model.dart';
import 'package:ojps_flutter/widgets/Resume/education_input_widget.dart';
import '../services/resume_service.dart';
import '../constants/colors.dart';
import '../constants/dimensions.dart' as dimensions;
import '../constants/text_styles.dart';
import '/widgets/view&edit_profile/profile_field_widget.dart';
import '/widgets/resume/resume_field_dropdown_widget.dart';

class ManageResumeScreen extends StatefulWidget {
  const ManageResumeScreen({super.key});

  @override
  State<ManageResumeScreen> createState() => _ManageResumeScreenState();
}

class _ManageResumeScreenState extends State<ManageResumeScreen> {
  File? selectedFile;
  String? fileName;

  List<Widget> experienceWidgets = [];
  List<Widget> educationWidgets = [];

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
  List<Map<String, TextEditingController>> workExperienceList = [
    {
      'jobTitle': TextEditingController(),
      'company': TextEditingController(),
      'startDate': TextEditingController(),
      'endDate': TextEditingController(),
      'bulletPoint': TextEditingController(),
    },
  ];

  // Education
  List<Map<String, dynamic>> educationList = [];

  final List<String> degrees = [
    "In progress",
    "Diploma",
    "Bachelor",
    "Master",
    "Doctor of philosophy",
    "Professional Doctorate",
  ];
  String? selectedDegree;
  final TextEditingController institutionController = TextEditingController();
  final TextEditingController eduStartDateController = TextEditingController();
  final TextEditingController eduEndDateController = TextEditingController();
  final TextEditingController gpaController = TextEditingController();
  final TextEditingController honorsController = TextEditingController();


  void _navigateToViewResumePage() {
    final resume = ResumeModel(
        fullName: fullNameController.text,
        email: emailController.text,
        location: locationController.text,
        phone: phoneController.text,
        summary: summaryController.text,
        //imageUrl: imageUrl,
      experiences: workExperienceList.map((exp) {
        return Experience(
          jobTitle: exp['jobTitle']!.text,
          company: exp['company']!.text,
          startDate: exp['startDate']!.text,
          endDate: exp['endDate']!.text,
          bulletPoint: exp['bulletPoint']!.text,
        );
      }).toList(),
      educations: educationList.map((edu) {
        return Education(
          degree: edu['degree'],
          institution: edu['institution'].text,
          startDate: edu['startDate'].text,
          endDate: edu['endDate'].text,
          gpa: edu['gpa'].text,
          honors: edu['honors'].text,
        );
      }).toList(),
    );
    Navigator.pushNamed(context, '/view_resume');
  }

  void _openUploadDialogBox() {
    showDialog(
      context: context,
      builder:
          (_) => AlertDialog(
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
    setState(() {
    });
  }

  void _addEducationEntry() {
    final degree = 'Bachelor'; // default
    final institution = TextEditingController();
    final startDate = TextEditingController();
    final endDate = TextEditingController();
    final gpa = TextEditingController();
    final honors = TextEditingController();

    educationList.add({
      'degree': degree,
      'institution': institution,
      'startDate': startDate,
      'endDate': endDate,
      'gpa': gpa,
      'honors': honors,
    });

    setState(() {
      educationWidgets.add(
        EducationInputWidget(
            key: ValueKey(institution), // use a unique key
            institutionController: institution,
            startDateController: startDate,
            endDateController: endDate,
            gpaController: gpa,
            honorsController: honors,
            selectedDegree: degree,
            onDegreeChanged: (newDegree) {
              final index = educationWidgets.indexWhere((w) => w.key == ValueKey(institution));
              if (index != -1) {
                educationList[index]['degree'] = newDegree;
              }
            },
          onRemove: () {
            final index = educationWidgets.indexWhere((widget) =>
            widget.key == ValueKey(institution));
            if (index != -1) {
              setState(() {
                educationList.removeAt(index);
                educationWidgets.removeAt(index);
              });
            }
          },
        )
      );
    });
  }

  void _loadResumeData() async {
    await Future.delayed(const Duration(milliseconds: 500));
    ResumeModel resume = await ResumeService.fetchResume();
    setState(() {
      fullNameController.text = resume.fullName;
      emailController.text = resume.email;
      phoneController.text = resume.phone;
      locationController.text = resume.location;

      summaryController.text = resume.summary;

      workExperienceList.clear();
      for (var exp in resume.experiences){
        workExperienceList.add({
          'jobTitle': TextEditingController(text: exp.jobTitle),
          'company': TextEditingController(text: exp.company),
          'startDate': TextEditingController(text: exp.startDate),
          'endDate': TextEditingController(text: exp.endDate),
          'bulletPoint': TextEditingController(text: exp.bulletPoint),
        });
      }
      educationList.clear();
      for (var edu in resume.educations) {
        educationList.add({
          'degree': edu.degree,
          'institution': TextEditingController(text: edu.institution),
          'startDate': TextEditingController(text: edu.startDate),
          'endDate': TextEditingController(text: edu.endDate),
          'gpa': TextEditingController(text: edu.gpa),
          'honors': TextEditingController(text: edu.honors),
        });
      }
    });

  }

  Future<void> _selectDate(
    BuildContext context,
    TextEditingController controller,
  ) async {
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
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text("Resume saved successfully.")));
  }


  @override
  void initState() {
    super.initState();
    _loadResumeData();
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
        padding: EdgeInsets.all(AppValues.defaultPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ResumeFieldDropdownWidget(
              title: "Personal Data",
              children: [
                if (fileName != null)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: Text(
                      "Uploaded File: $fileName",
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ProfileFieldWidget(
                  label: "Full Name",
                  controller: fullNameController,
                ),
                ProfileFieldWidget(label: "Email", controller: emailController),
                ProfileFieldWidget(
                  label: "Phone Number",
                  controller: phoneController,
                ),
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("Work Experience Entry"),
                      IconButton(
                        onPressed: () {
                          setState(() {
                            workExperienceList.removeAt(i);
                          });
                        },
                        icon: Icon(Icons.delete_outline, color: Colorss.remove),
                      ),
                    ],
                  ),
                  ProfileFieldWidget(
                    label: "Job Title",
                    controller: workExperienceList[i]['jobTitle']!,
                  ),
                  ProfileFieldWidget(
                    label: "Company",
                    controller: workExperienceList[i]['company']!,
                  ),
                  GestureDetector(
                    onTap: () => _selectDate(context, workExperienceList[i]['startDate']!),
                    child: AbsorbPointer(
                      child: ProfileFieldWidget(
                        label: "Start Date",
                        controller: workExperienceList[i]['startDate']!,
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () => _selectDate(context, workExperienceList[i]['endDate']!),
                    child: AbsorbPointer(
                      child: ProfileFieldWidget(
                        label: "End Date",
                        controller: workExperienceList[i]['endDate']!,
                      ),
                    ),
                  ),
                  ProfileFieldWidget(
                    label: "Responsibilities / Achievements",
                    controller: workExperienceList[i]['bulletPoint']!,
                    maxLines: 3,
                  ),
                  const Divider(),
                ],
                TextButton.icon(
                  onPressed: _addWorkExperienceEntry,
                  icon: const Icon(Icons.add, color: Colorss.primaryColor),
                  label: const Text("Add Work Experience", style: TextStyle(color: Colorss.primaryColor)),
                ),
              ],
            ),

            ResumeFieldDropdownWidget(
              title: "Education",
              children: [
                for (int i = 0; i < educationList.length; i++) ...[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("Education Entry"),
                      IconButton(
                        onPressed: () {
                          setState(() {
                            educationList.removeAt(i);
                          });
                        },
                        icon: Icon(Icons.delete_outline, color: Colorss.remove),
                      ),
                    ],
                  ),
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
                    decoration: InputDecoration(labelText: "Degree",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(dimensions.AppDimensions.defaultRadius),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(color: Colorss.greyColor),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(color: Colorss.primaryColor, width: 2),
                      ),
                    ),
                      iconEnabledColor: Colorss.greyColor,
                      dropdownColor: Colorss.whiteColor,
                      style: const TextStyle(color: Colorss.blackColor),
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
                TextButton.icon(
                  onPressed: _addEducationEntry,
                  icon: const Icon(Icons.add, color: Colorss.primaryColor),
                  label: const Text("Add Education", style: TextStyle(color: Colorss.primaryColor)),
                ),
              ],
            ),


            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children : [
                ElevatedButton(
                onPressed: _saveResume,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colorss.primaryColor,
                ),
                child: const Text(
                  "Save Resume",
                  style: TextStyle(color: Colors.white),
                ),
              ),
                ElevatedButton(
                  onPressed: _navigateToViewResumePage,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colorss.primaryColor,
                  ),
                  child: const Text(
                    "View Resume",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
          ],
        ),
    ],
                ),
    ),
    );
  }
}
