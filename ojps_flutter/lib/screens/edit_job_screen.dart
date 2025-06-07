import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

import '../constants/colors.dart';
import '../constants/dimensions.dart';
import '../constants/spaces.dart';
import '../models/job_model.dart';
import '../services/job_service.dart';
import '../utils/network_utils.dart';
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
      backgroundColor: Colorss.cardBackgroundColor,
      appBar: AppBar(
        backgroundColor: Colorss.whiteColor,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.close, color: Colorss.primaryTextColor),
          onPressed: () => Navigator.pop(context),
        ),
        title: Row(
          children: [
            CircleAvatar(
              radius: 24,
              backgroundImage: widget.job.companyLogo != null
                  ? NetworkImage(fixUrl(widget.job.companyLogo!))
                  : const AssetImage('assets/default-logo.png'),
            ),
            Spaces.horizontal(AppDimensions.spacingSmall),
          ],
        ),
        actions: [
          Container(
            margin: const EdgeInsets.symmetric(horizontal: AppDimensions.marginSmall),
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
                      SnackBar(content: Text(tr('job_updated_successfully'))),
                    );
                    Navigator.pop(context, widget.job.copyWith(
                      title: titleController.text,
                      description: descriptionController.text,
                      languages: languageController.text,
                      schedule: scheduleController.text,
                      salary: salaryController.text,
                      experience: selectedExperience,
                      employment: selectedEmployment,
                      category: selectedCategory,
                    ));
                  }
                } catch (e) {
                  if (context.mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('${tr('failed_to_update_job')}: $e')),
                    );
                  }
                }
              }
                  : null,
              style: ElevatedButton.styleFrom(
                backgroundColor: isFormValid ? Colorss.primaryColor : Colorss.buttonInactiveBackgroundColor,
                foregroundColor: isFormValid ? Colorss.whiteColor : Colorss.buttonInactiveTextColor,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(AppDimensions.borderRadiusLarge),
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: AppDimensions.horizontalSpacerXLarge,
                  vertical: AppDimensions.verticalSpacerMediumSmall,
                ),
              ),
              child: Text(tr('save')),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(AppDimensions.defaultPadding),
        child: ListView(
          children: [
            CustomTextField(
              label: tr('job_title'),
              controller: titleController,
              onChanged: (_) => updateFormValidity(),
            ),
            CustomTextField(
              label: tr('description'),
              maxLines: 4,
              controller: descriptionController,
              onChanged: (_) => updateFormValidity(),
            ),
            CustomTextField(
              label: tr('languages'),
              hint: tr('languages_hint'),
              controller: languageController,
              onChanged: (_) => updateFormValidity(),
            ),
            CustomTextField(
              label: tr('schedule'),
              hint: tr('schedule_hint'),
              controller: scheduleController,
              onChanged: (_) => updateFormValidity(),
            ),
            CustomTextField(
              label: tr('salary'),
              hint: tr('salary_hint'),
              controller: salaryController,
              onChanged: (_) => updateFormValidity(),
            ),
            DropdownSelector(
              label: tr('experience'),
              options: [
                tr('exp_0_1'),
                tr('exp_1_3'),
                tr('exp_3_plus'),
                tr('exp_not_required'),
              ],
              selectedValue: selectedExperience,
              onChanged: (value) {
                selectedExperience = value;
                updateFormValidity();
              },
            ),
            DropdownSelector(
              label: tr('employment'),
              options: [
                tr('full_time'),
                tr('part_time'),
                tr('remote'),
                tr('contract'),
                tr('internship'),
                tr('temporary'),
                tr('volunteer'),
              ],
              selectedValue: selectedEmployment,
              onChanged: (value) {
                selectedEmployment = value;
                updateFormValidity();
              },
            ),
            DropdownSelector(
              label: tr('category'),
              options: [
                tr('marketing'),
                tr('technology'),
                tr('design'),
                tr('sales'),
                tr('cooking'),
                tr('other'),
              ],
              selectedValue: selectedCategory,
              onChanged: (value) {
                selectedCategory = value;
                updateFormValidity();
              },
            ),
            Spaces.vertical(AppDimensions.verticalSpacerLarge),
          ],
        ),
      ),
    );
  }
}
