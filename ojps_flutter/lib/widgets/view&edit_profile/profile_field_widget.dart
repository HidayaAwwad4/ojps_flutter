import 'package:flutter/material.dart';
import '/constants/dimensions.dart';

class ProfileFieldWidget extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final bool enabled;

  const ProfileFieldWidget({
    super.key,
    required this.label,
    required this.controller,
    this.enabled = true,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: defaultPadding),
      child: TextField(
        controller: controller,
        enabled: enabled,
        decoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(),
        ),
      ),
    );
  }
}
