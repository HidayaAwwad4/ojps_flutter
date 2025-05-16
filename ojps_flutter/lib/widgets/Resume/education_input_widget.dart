import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '/constants/colors.dart';
import '/constants/dimensions.dart';
import '/widgets/view&edit_profile/profile_field_widget.dart';

class EducationInputWidget extends StatefulWidget {
  final VoidCallback? onRemove;

  const EducationInputWidget({super.key, this.onRemove});

  @override
  State<EducationInputWidget> createState() => _EducationInputWidgetState();
}

class _EducationInputWidgetState extends State<EducationInputWidget> {
  final TextEditingController institutionController = TextEditingController();
  final TextEditingController gpaController = TextEditingController();
  final TextEditingController honorsController = TextEditingController();
  final TextEditingController startDateController = TextEditingController();
  final TextEditingController endDateController = TextEditingController();

  String selectedDegree = 'Bachelor';

  final List<String> degreeOptions = [
    'In progress',
    'Diploma',
    'Bachelor',
    'Master',
    'Doctor of philosophy',
    'Professional Doctorate',
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

  @override
  void dispose() {
    institutionController.dispose();
    gpaController.dispose();
    honorsController.dispose();
    startDateController.dispose();
    endDateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        DropdownButtonFormField<String>(
          decoration: const InputDecoration(labelText: 'Degree'),
          value: selectedDegree,
          items: degreeOptions.map((degree) {
            return DropdownMenuItem<String>(
              value: degree,
              child: Text(degree),
            );
          }).toList(),
          onChanged: (value) {
            if (value != null) {
              setState(() {
                selectedDegree = value;
              });
            }
          },
        ),
        ProfileFieldWidget(label: "Institution", controller: institutionController),
        Row(
          children: [
            Expanded(
              child: GestureDetector(
                onTap: () => _pickDate(startDateController),
                child: AbsorbPointer(
                  child: ProfileFieldWidget(label: "Start Date", controller: startDateController),
                ),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: GestureDetector(
                onTap: () => _pickDate(endDateController),
                child: AbsorbPointer(
                  child: ProfileFieldWidget(label: "End Date", controller: endDateController),
                ),
              ),
            ),
          ],
        ),
        ProfileFieldWidget(label: "GPA", controller: gpaController),
        ProfileFieldWidget(label: "Honors (if included)", controller: honorsController),
        if (widget.onRemove != null)
          Align(
            alignment: Alignment.centerRight,
            child: TextButton.icon(
              onPressed: widget.onRemove,
              icon: const Icon(Icons.delete, color: Colors.red),
              label: const Text("Remove", style: TextStyle(color: Colors.red)),
            ),
          ),
      ],
    );
  }
}
