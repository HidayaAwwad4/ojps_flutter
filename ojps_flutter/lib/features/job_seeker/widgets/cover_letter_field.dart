import 'package:flutter/material.dart';

class CoverLetterField extends StatefulWidget {
  const CoverLetterField({super.key});

  @override
  State<CoverLetterField> createState() => _CoverLetterFieldState();
}

class _CoverLetterFieldState extends State<CoverLetterField> {
  @override
  Widget build(BuildContext context) {
    return TextField(
      maxLines: 9,
      decoration: InputDecoration(
        hintText: "Write your Cover Letter...",
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: Colors.blue,
            width: 1.5,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: Colors.blue,
            width: 1.5,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }
}
