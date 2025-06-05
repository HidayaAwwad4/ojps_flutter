import 'dart:io';

import 'package:flutter/material.dart';
import '../../services/job_service.dart';
import '../constants/colors.dart';
import '../constants/dimensions.dart';
import '../constants/spaces.dart';
import '../widgets/custom_text_field.dart';
import '../widgets/document_upload_button.dart';
import '../widgets/dropdown_selector.dart';
import '../widgets/image_upload_button.dart';

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

  File? selectedCompanyLogo;

  final List<String> experienceList = [
    '0-1 years',
    '1-3 years',
    '3+ years',
    'Not required',
  ];
  final List<String> employmentList = [
    'Full-Time',
    'Part-Time',
    'Remote',
    'Contract',
    'Internship',
    'Temporary',
    'Volunteer',
  ];
  final List<String> categoryList = [
    'Marketing',
    'Technology',
    'Design',
    'Sales',
    'Cooking',
    'Other',
  ];

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
        'isOpened': 1,
        'employer_id': 38,
        'company_logo': selectedCompanyLogo,
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
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.pop(context);
                },
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
      backgroundColor: Colorss.cardBackgroundColor,
      appBar: AppBar(
        backgroundColor: Colorss.whiteColor,
        elevation: 1,
        leading: IconButton(
          icon: const Icon(Icons.close, color: Colorss.blackColor),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          TextButton(
            onPressed: isFormValid ? _submitForm : null,
            style: TextButton.styleFrom(
              backgroundColor: isFormValid ? Colorss.primaryColor : Colorss.buttonInactiveBackgroundColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(AppDimensions.borderRadiusSmall),
              ),
            ),
            child: Text(
              'Post',
              style: TextStyle(
                color: isFormValid ? Colorss.whiteColor : Colorss.buttonInactiveTextColor,
              ),
            ),
          ),
          Spaces.horizontal(AppDimensions.horizontalSpacerLarge),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: AppDimensions.horizontalSpacerLarge, vertical: AppDimensions.verticalSpacerLarge),
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ImageUploadButton(
                onImageSelected: (File? image) {
                  setState(() {
                    selectedCompanyLogo = image;
                  });
                },
              ),
              Spaces.horizontal(AppDimensions.spacingSmall),
              const Expanded(
                child: Text(
                  'Upload your company logo',
                  style: TextStyle(
                    color: Colorss.greyColor,
                    fontSize:AppDimensions.fontSizeNormal,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
          Spaces.vertical(AppDimensions.verticalSpacerLarge),
          Container(
            padding: const EdgeInsets.all(AppDimensions.defaultPadding),
            decoration: BoxDecoration(
              color: Colorss.whiteColor,
              borderRadius: BorderRadius.circular(AppDimensions.borderRadius),
              boxShadow: [
                BoxShadow(
                  color: Colors.black12.withOpacity(0.05),
                  blurRadius: 8,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Column(
              children: [
                CustomTextField(
                  label: 'Job Title',
                  hint: 'Enter job title',
                  onChanged: (value) => setState(() => jobTitle = value),
                ),
                Spaces.vertical(AppDimensions.verticalSpacerMedium),
                CustomTextField(
                  label: 'Job Description',
                  hint: 'Describe the job',
                  maxLines: AppDimensions.maxLinesJobDescription,
                  onChanged: (value) => setState(() => description = value),
                ),
                Spaces.vertical(AppDimensions.verticalSpacerMedium),
                CustomTextField(
                  label: 'Location',
                  hint: 'Enter job location',
                  onChanged: (value) => setState(() => location = value),
                ),
                Spaces.vertical(AppDimensions.verticalSpacerMedium),
                CustomTextField(
                  label: 'Languages',
                  hint: 'e.g. English - Advanced',
                  onChanged: (value) => setState(() => languages = value),
                ),
                Spaces.vertical(AppDimensions.verticalSpacerMedium),
                CustomTextField(
                  label: 'Schedule',
                  hint: 'e.g. Sunday to Thursday',
                  onChanged: (value) => setState(() => schedule = value),
                ),
                Spaces.vertical(AppDimensions.verticalSpacerMedium),
                CustomTextField(
                  label: 'Salary',
                  hint: 'Hourly/ daily/ monthly',
                  onChanged: (value) => setState(() => salary = value),
                ),
                Spaces.vertical(AppDimensions.verticalSpacerMedium),
                DropdownSelector(
                  label: 'Experience',
                  options: experienceList,
                  selectedValue: selectedExperience,
                  onChanged: (value) => setState(() => selectedExperience = value),
                ),
                Spaces.vertical(AppDimensions.verticalSpacerMedium),
                DropdownSelector(
                  label: 'Employment',
                  options: employmentList,
                  selectedValue: selectedEmployment,
                  onChanged: (value) => setState(() => selectedEmployment = value),
                ),
                Spaces.vertical(AppDimensions.verticalSpacerMedium),
                DropdownSelector(
                  label: 'Category',
                  options: categoryList,
                  selectedValue: selectedCategory,
                  onChanged: (value) => setState(() => selectedCategory = value),
                ),
                Spaces.vertical(AppDimensions.verticalSpacerMedium),
                const DocumentUploadButton(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
