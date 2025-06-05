import 'package:flutter/material.dart';
import 'package:ojps_flutter/constants/colors.dart';

class CoverLetterField extends StatefulWidget {
  const CoverLetterField({super.key});

  @override
  State<CoverLetterField> createState() => _CoverLetterFieldState();
}

class _CoverLetterFieldState extends State<CoverLetterField> {
  @override
  Widget build(BuildContext context) {
    return TextField(
      maxLines: 12,
      decoration: InputDecoration(
        hintText: "Write your Cover Letter...",
        hintStyle: TextStyle(color: secondaryTextColor.withOpacity(0.6)),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: primaryColor, width: 1.2),
          borderRadius: BorderRadius.circular(12),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: primaryColor, width: 1.6),
          borderRadius: BorderRadius.circular(12),
        ),
        fillColor: lightBlueBackgroundColor.withOpacity(0.1),
        filled: true,
      ),
    );
  }
}
