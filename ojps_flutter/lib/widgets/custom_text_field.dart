import 'package:flutter/material.dart';
import 'package:ojps_flutter/constants/colors.dart';
import 'package:ojps_flutter/constants/text_styles.dart';

class CustomTextField extends StatelessWidget {
  final String label;
  final String? hint;
  final int maxLines;
  final Function(String)? onChanged;
  final TextEditingController? controller;
  final TextInputType? keyboardType;

  const CustomTextField({
    super.key,
    required this.label,
    this.hint,
    this.maxLines = 1,
    this.onChanged,
    this.controller,
    this.keyboardType,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppValues.textFieldVerticalPadding),
      child: TextField(
        controller: controller,
        maxLines: maxLines,
        keyboardType: keyboardType,
        onChanged: onChanged,
        decoration: InputDecoration(
          labelText: label,
          hintText: hint,
          border: const OutlineInputBorder(),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colorss.primaryColor, width: 2),
          ),
          labelStyle: const TextStyle(color: Colorss.secondaryTextColor),
          floatingLabelStyle: const TextStyle(color: Colorss.primaryColor),
        ),
      ),
    );
  }
}
