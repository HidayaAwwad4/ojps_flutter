import 'package:flutter/material.dart';
import '../constants/colors.dart';
import '../models/job_model.dart';
import '../services/job_service.dart';
import '../widgets/custom_text_field.dart';
import '../widgets/dropdown_selector.dart';

class EditJobScreen extends StatefulWidget {
  final Job job;

  const EditJobScreen({super.key, required this.job});

  @override
  State<EditJobScreen> createState() => _EditJobScreenState();
}

class _EditJobScreenState extends State<EditJobScreen> {
  late TextEditingController titleController;
  late TextEditingController descriptionController;
  late TextEditingController languageController;
  late TextEditingController scheduleController;
  late TextEditingController salaryController;

  String? selectedExperience;
  String? selectedEmployment;
  String? selectedCategory;

  bool isFormValid = false;

  @override
  void initState() {
    super.initState();
    titleController = TextEditingController(text: widget.job.title);
    descriptionController = TextEditingController(text: widget.job.description);
    languageController = TextEditingController(text: widget.job.languages);
    scheduleController = TextEditingController(text: widget.job.schedule);
    salaryController = TextEditingController(text: widget.job.salary);

    selectedExperience = widget.job.experience;
    selectedEmployment = widget.job.employment;
    selectedCategory = widget.job.category;

    updateFormValidity();
  }

  void updateFormValidity() {
    setState(() {
      isFormValid = titleController.text.isNotEmpty &&
          descriptionController.text.isNotEmpty &&
          languageController.text.isNotEmpty &&
          scheduleController.text.isNotEmpty &&
          salaryController.text.isNotEmpty &&
          selectedExperience != null &&
          selectedEmployment != null &&
          selectedCategory != null;
    });
  }

  @override
  void dispose() {
    titleController.dispose();
    descriptionController.dispose();
    languageController.dispose();
    scheduleController.dispose();
    salaryController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: cardBackgroundColor,
      appBar: AppBar(
        backgroundColor: whiteColor,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.close, color: primaryTextColor),
          onPressed: () => Navigator.pop(context),
        ),
        title: Row(
          children: [
            CircleAvatar(
              radius: 16,
              backgroundImage: widget.job.companyLogo != null
                  ? NetworkImage(widget.job.companyLogo!)
                  : const AssetImage('assets/default_logo.jpeg') as ImageProvider,
            ),
            const SizedBox(width: 8),
          ],
        ),
        actions: [
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 12),
            child: ElevatedButton(
              onPressed: isFormValid
                  ? () async {
                final data = {
                  'title': titleController.text,
                  'description': descriptionController.text,
                  'language': languageController.text,
                  'schedule': scheduleController.text,
                  'salary': salaryController.text,
                  'experience': selectedExperience,
                  'employment': selectedEmployment,
                  'category': selectedCategory,
                };

                try {
                  await JobService().updateJob(widget.job.id, data);
                  if (context.mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Job updated successfully')),
                    );
                    Navigator.pop(context, true);
                  }
                } catch (e) {
                  if (context.mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Failed to update job: $e')),
                    );
                  }
                }
              }
                  : null,
              style: ElevatedButton.styleFrom(
                backgroundColor: isFormValid ? primaryColor : const Color(0xFFE8E8E8),
                foregroundColor: isFormValid ? whiteColor : const Color(0xFFADADAD),
                elevation: 0,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              ),
              child: const Text('Save'),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            CustomTextField(
              label: 'Job Title',
              controller: titleController,
              onChanged: (_) => updateFormValidity(),
            ),
            CustomTextField(
              label: 'Description',
              maxLines: 4,
              controller: descriptionController,
              onChanged: (_) => updateFormValidity(),
            ),
            CustomTextField(
              label: 'Languages',
              hint: 'e.g. English - Advanced',
              controller: languageController,
              onChanged: (_) => updateFormValidity(),
            ),
            CustomTextField(
              label: 'Schedule',
              hint: 'e.g. Sunday to Thursday',
              controller: scheduleController,
              onChanged: (_) => updateFormValidity(),
            ),
            CustomTextField(
              label: 'Salary',
              hint: 'Hourly/ daily/ monthly',
              controller: salaryController,
              onChanged: (_) => updateFormValidity(),
            ),
            DropdownSelector(
              label: 'Experience',
              options: ['0-1 years', '1-3 years', '3+ years', 'Not required'],
              selectedValue: selectedExperience,
              onChanged: (value) {
                selectedExperience = value;
                updateFormValidity();
              },
            ),
            DropdownSelector(
              label: 'Employment',
              options: ['Full-Time', 'Part-Time', 'Remote', 'Contract', 'Internship', 'Temporary', 'Volunteer'],
              selectedValue: selectedEmployment,
              onChanged: (value) {
                selectedEmployment = value;
                updateFormValidity();
              },
            ),
            DropdownSelector(
              label: 'Category',
              options: ['Marketing', 'Technology', 'Design', 'Sales', 'Cooking', 'Other'],
              selectedValue: selectedCategory,
              onChanged: (value) {
                selectedCategory = value;
                updateFormValidity();
              },
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
