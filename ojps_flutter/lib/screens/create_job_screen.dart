import 'package:flutter/material.dart';
import '../../services/job_service.dart';
import '../constants/colors.dart';
import '../widgets/custom_text_field.dart';
import '../widgets/document_upload_button.dart';
import '../widgets/dropdown_selector.dart';

class CreateJobScreen extends StatefulWidget {
  const CreateJobScreen({super.key});

  @override
  State<CreateJobScreen> createState() => _CreateJobScreenState();
}

class _CreateJobScreenState extends State<CreateJobScreen> {
  String jobTitle = '';
  String description = '';
  String location = '';
  String languages = '';
  String schedule = '';
  String salary = '';
  String? selectedExperience;
  String? selectedEmployment;
  String? selectedCategory;

  final List<String> experienceList = ['0-1 years', '1-3 years', '3+ years', 'Not required',];
  final List<String> employmentList = ['Full-Time', 'Part-Time', 'Remote', 'Contract', 'Internship', 'Temporary', 'Volunteer',];
  final List<String> categoryList = ['Marketing', 'Technology', 'Design', 'Sales', 'Cooking', 'Other',];

  bool get isFormValid {
    return jobTitle.isNotEmpty &&
        description.isNotEmpty &&
        location.isNotEmpty &&
        languages.isNotEmpty &&
        schedule.isNotEmpty &&
        salary.isNotEmpty &&
        selectedExperience != null &&
        selectedEmployment != null &&
        selectedCategory != null;
  }

  Future<void> _submitForm() async {
    try {
      final data = {
        'title': jobTitle,
        'description': description,
        'location': location,
        'languages': languages,
        'schedule': schedule,
        'salary': double.tryParse(salary) ?? 0.0,
        'experience': selectedExperience!,
        'employment': selectedEmployment!,
        'category': selectedCategory!,
        'isOpened': true,
        'company_logo': null,
        'documents': null,
      };


      await JobService().createJob(data);

      if (context.mounted) {
        showDialog(
          context: context,
          builder: (_) => AlertDialog(
            title: const Text('Success'),
            content: const Text('Job posted successfully.'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('OK'),
              ),
            ],
          ),
        );
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: ${e.toString()}')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF0F0F0),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: const Icon(Icons.close, color: Colors.black),
        actions: [
          TextButton(
            onPressed: isFormValid ? _submitForm : null,
            style: TextButton.styleFrom(
              backgroundColor: isFormValid ? primaryColor : cardBackgroundColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: Text(
              'Post',
              style: TextStyle(
                color: isFormValid ? whiteColor : lightGrey,
              ),
            ),
          ),
          const SizedBox(width: 16),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Row(
            children: [
              CircleAvatar(backgroundColor: Colors.grey, radius: 20),
              SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('TechGate', style: TextStyle(fontWeight: FontWeight.bold)),
                  Text('Nablus', style: TextStyle(color: Colors.grey)),
                ],
              )
            ],
          ),
          const SizedBox(height: 20),
          CustomTextField(
            label: 'Job Title',
            hint: 'Enter job title',
            onChanged: (value) => setState(() => jobTitle = value),
          ),
          CustomTextField(
            label: 'Job Description',
            hint: 'Describe the job',
            maxLines: 5,
            onChanged: (value) => setState(() => description = value),
          ),
          CustomTextField(
            label: 'Location',
            hint: 'Enter job location',
            onChanged: (value) => setState(() => location = value),
          ),
          const SizedBox(height: 12),
          CustomTextField(
            label: 'Languages',
            hint: 'e.g. English - Advanced',
            onChanged: (value) => setState(() => languages = value),
          ),
          const SizedBox(height: 12),
          CustomTextField(
            label: 'Schedule',
            hint: 'e.g. Sunday to Thursday',
            onChanged: (value) => setState(() => schedule = value),
          ),
          const SizedBox(height: 12),
          CustomTextField(
            label: 'Salary',
            hint: 'Hourly/ daily/ monthly',
            onChanged: (value) => setState(() => salary = value),
          ),
          const SizedBox(height: 12),
          DropdownSelector(
            label: 'Experience',
            options: [
              '0-1 years',
              '1-3 years',
              '3+ years',
              'Not required',
            ],
            selectedValue: selectedExperience,
            onChanged: (value) => setState(() => selectedExperience = value),
          ),
          const SizedBox(height: 12),
          DropdownSelector(
            label: 'Employment',
            options: [
              'Full-Time',
              'Part-Time',
              'Remote',
              'Contract',
              'Internship',
              'Temporary',
              'Volunteer',
            ],
            selectedValue: selectedEmployment,
            onChanged: (value) => setState(() => selectedEmployment = value),
          ),
          const SizedBox(height: 12),
          DropdownSelector(
            label: 'Category',
            options: [
              'Marketing',
              'Technology',
              'Design',
              'Sales',
              'Cooking',
              'Other',
            ],
            selectedValue: selectedCategory,
            onChanged: (value) => setState(() => selectedCategory = value),
          ),
          const SizedBox(height: 12),
          const DocumentUploadButton(),
        ],
      ),
    );
  }
}
