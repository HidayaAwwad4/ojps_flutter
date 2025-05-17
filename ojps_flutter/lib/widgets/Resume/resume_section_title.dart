import 'package:flutter/material.dart';
import '/constants/dimensions.dart';
import '/constants/colors.dart';

class ResumeSectionTitleWidget extends StatelessWidget {
  final String title;
  const ResumeSectionTitleWidget({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: defaultPadding),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: primaryColor,
        ),
      ),
    );
  }
}
