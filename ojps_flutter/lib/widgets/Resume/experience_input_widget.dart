import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../constants/spaces.dart';
import '/constants/colors.dart';
import '/widgets/view&edit_profile/profile_field_widget.dart';

class ExperienceInputWidget extends StatefulWidget {
  final VoidCallback? onRemove;

  const ExperienceInputWidget({super.key, this.onRemove});

  @override
  State<ExperienceInputWidget> createState() => _ExperienceInputWidgetState();
}

class _ExperienceInputWidgetState extends State<ExperienceInputWidget> {
  final TextEditingController jobTitleController = TextEditingController();
  final TextEditingController companyController = TextEditingController();
  final TextEditingController startDateController = TextEditingController();
  final TextEditingController endDateController = TextEditingController();
  final List<TextEditingController> responsibilityControllers = [
    TextEditingController(),
  ];

  Future<void> _pickDate(TextEditingController controller) async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1990),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      controller.text = DateFormat('yyyy-MM-dd').format(picked);
    }
  }

  void _addResponsibilityField() {
    setState(() {
      responsibilityControllers.add(TextEditingController());
    });
  }

  @override
  void dispose() {
    jobTitleController.dispose();
    companyController.dispose();
    startDateController.dispose();
    endDateController.dispose();
    for (var controller in responsibilityControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ProfileFieldWidget(label: "Job Title", controller: jobTitleController),
        ProfileFieldWidget(
          label: "Company Name",
          controller: companyController,
        ),
        Row(
          children: [
            Expanded(
              child: GestureDetector(
                onTap: () => _pickDate(startDateController),
                child: AbsorbPointer(
                  child: ProfileFieldWidget(
                    label: "Start Date",
                    controller: startDateController,
                  ),
                ),
              ),
            ),
            Spaces.horizontal(10),
            Expanded(
              child: GestureDetector(
                onTap: () => _pickDate(endDateController),
                child: AbsorbPointer(
                  child: ProfileFieldWidget(
                    label: "End Date",
                    controller: endDateController,
                  ),
                ),
              ),
            ),
          ],
        ),
        Spaces.vertical(10),
        const Align(
          alignment: Alignment.centerLeft,
          child: Text(
            "Responsibilities / Achievements",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        ...responsibilityControllers.map(
          (controller) =>
              ProfileFieldWidget(label: "Bullet Point", controller: controller),
        ),

        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextButton.icon(
              onPressed: _addResponsibilityField,
              icon: const Icon(Icons.add, color: Colorss.primaryColor),
              label: const Text(
                "Add More",
                style: TextStyle(color: Colorss.primaryColor),
              ),
            ),

            if (widget.onRemove != null)
              TextButton.icon(
                onPressed: widget.onRemove,
                icon: const Icon(Icons.delete, color: Colors.red),
                label: const Text(
                  "Remove",
                  style: TextStyle(color: Colors.red),
                ),
              ),
          ],
        ),
      ],
    );
  }
}
