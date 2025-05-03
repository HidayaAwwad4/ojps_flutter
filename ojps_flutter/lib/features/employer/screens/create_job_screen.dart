import 'package:flutter/material.dart';
import '../widgets/custom_text_field.dart';
import '../widgets/dropdown_selector.dart';
import '../widgets/document_upload_button.dart';

class CreateJobScreen extends StatefulWidget {
  const CreateJobScreen({super.key});

  @override
  State<CreateJobScreen> createState() => _CreateJobScreenState();
}

class _CreateJobScreenState extends State<CreateJobScreen> {
  bool isFormValid = false;
  String? selectedExperience;
  String? selectedEmployment;
  String? selectedCategory;
  String jobTitle = '';
  String description = '';
  String languages = '';
  String schedule = '';
  String salary = '';

  void updateFormValidity() {
    setState(() {
      isFormValid = jobTitle.isNotEmpty &&
          description.isNotEmpty &&
          languages.isNotEmpty &&
          schedule.isNotEmpty &&
          salary.isNotEmpty &&
          selectedExperience != null &&
          selectedEmployment != null &&
          selectedCategory != null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF0F0F0),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.close, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Row(
          children: [
            const CircleAvatar(
              radius: 16,
              backgroundImage: AssetImage('lib/assets/adham.jpg'),
            ),
            const SizedBox(width: 8),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  'adham',
                  style: TextStyle(color: Colors.black, fontSize: 14, fontWeight: FontWeight.w500),
                ),
                Text(
                  'Rafidia, Nablus',
                  style: TextStyle(color: Colors.grey, fontSize: 12),
                ),
              ],
            ),
          ],
        ),
        actions: [
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 12),
            child: ElevatedButton(
              onPressed: isFormValid ? () {} : null,
              style: ElevatedButton.styleFrom(
                backgroundColor: isFormValid ? const Color(0xFF0273B1) : const Color(0xFFE8E8E8),
                foregroundColor: isFormValid ? Colors.white : const Color(0xFFADADAD),
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              ),
              child: const Text('Post'),
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
              onChanged: (value) {
                jobTitle = value;
                updateFormValidity();
              },
            ),
            CustomTextField(
              label: 'Description',
              maxLines: 4,
              onChanged: (value) {
                description = value;
                updateFormValidity();
              },
            ),
            CustomTextField(
              label: 'Languages',
              hint: 'e.g. English - Advanced',
              onChanged: (value) {
                languages = value;
                updateFormValidity();
              },
            ),
            CustomTextField(
              label: 'Schedule',
              hint: 'e.g. Sunday to Thursday',
              onChanged: (value) {
                schedule = value;
                updateFormValidity();
              },
            ),
            CustomTextField(
              label: 'Salary',
              hint: 'Hourly/ daily/ monthly',
              onChanged: (value) {
                salary = value;
                updateFormValidity();
              },
            ),

            // DropdownSelector for Experience
            DropdownSelector(
              label: 'Experience',
              options: [
                '0-1 years',
                '1-3 years',
                '3+ years',
                'Not required',
              ],
              selectedValue: selectedExperience,
              onChanged: (newValue) {
                setState(() {
                  selectedExperience = newValue;
                });
                updateFormValidity();
              },
            ),

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
              onChanged: (newValue) {
                setState(() {
                  selectedEmployment = newValue;
                });
                updateFormValidity();
              },
            ),

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
              onChanged: (newValue) {
                setState(() {
                  selectedCategory = newValue;
                });
                updateFormValidity();
              },
            ),
            const SizedBox(height: 20),
            //DocumentUploadButton(),
          ],
        ),
      ),
    );
  }
}
