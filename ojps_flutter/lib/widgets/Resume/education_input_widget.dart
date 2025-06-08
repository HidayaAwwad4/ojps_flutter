import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../constants/spaces.dart';
import '/constants/colors.dart';
import '/constants/dimensions.dart';
import '/widgets/view&edit_profile/profile_field_widget.dart';

class EducationInputWidget extends StatefulWidget {
  final TextEditingController institutionController;
  final TextEditingController startDateController;
  final TextEditingController endDateController;
  final TextEditingController gpaController;
  final TextEditingController honorsController;
  final String selectedDegree;
  final Function(String)? onDegreeChanged;
  final VoidCallback? onRemove;

  const EducationInputWidget({
    super.key,
    required this.institutionController,
    required this.startDateController,
    required this.endDateController,
    required this.gpaController,
    required this.honorsController,
    required this.selectedDegree,
    this.onDegreeChanged,
    this.onRemove,
  });

  @override
  State<EducationInputWidget> createState() => _EducationInputWidgetState();
}

class _EducationInputWidgetState extends State<EducationInputWidget> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();


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
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          DropdownButtonFormField<String>(
            decoration: const InputDecoration(labelText: 'Degree'),
            value: widget.selectedDegree,
            items: [
            'In progress',
            'Diploma',
            'Bachelor',
            'Master',
            'Doctor of philosophy',
            'Professional Doctorate',
                ].map((degree) {
                  return DropdownMenuItem<String>(
                    value: degree,
                    child: Text(degree),
                  );
                }).toList(),
            onChanged: (value) {
              if (value != null) {
                widget.onDegreeChanged!(value);
              }
            },
          ),
          ProfileFieldWidget(
            label: "Institution",
            controller: widget.institutionController,
          ),
          Row(
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: () => _pickDate(widget.startDateController),
                  child: AbsorbPointer(
                    child: ProfileFieldWidget(
                      label: "Start Date",
                      controller: widget.startDateController,
                    ),
                  ),
                ),
              ),
              Spaces.horizontal(10),
              Expanded(
                child: GestureDetector(
                  onTap: () => _pickDate(widget.endDateController),
                  child: AbsorbPointer(
                    child: ProfileFieldWidget(
                      label: "End Date",
                      controller: widget.endDateController,
                    ),
                  ),
                ),
              ),
            ],
          ),
          ProfileFieldWidget(label: "GPA", controller: widget.gpaController),
          ProfileFieldWidget(
            label: "Honors (if included)",
            controller: widget.honorsController,
          ),
          if (widget.onRemove != null)
            Align(
              alignment: Alignment.centerRight,
              child: TextButton.icon(
                onPressed: widget.onRemove,
                icon: const Icon(Icons.delete, color: Colors.red),
                label: const Text(
                  "Remove",
                  style: TextStyle(color: Colors.red),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
