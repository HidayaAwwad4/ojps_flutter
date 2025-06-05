import 'package:flutter/material.dart';
import 'package:ojps_flutter/constants/colors.dart';
import 'package:ojps_flutter/constants/text_styles.dart';

class JobDescriptionWidget extends StatelessWidget {
  const JobDescriptionWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppValues.horizontalPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Text(
            "Description",
            style: TextStyle(
              fontSize: AppValues.bodyFontSize,
              fontWeight: FontWeight.bold,
              color: Colorss.primaryTextColor,
            ),
          ),
          SizedBox(height: AppValues.sectionSpacing),
          Text(
            "Work on server-side applications and APIs for smooth operations.",
            style: TextStyle(
              fontSize: AppValues.bodyFontSize,
              color: Colorss.secondaryTextColor,
            ),
          ),
        ],
      ),
    );
  }
}
