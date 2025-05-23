import 'package:flutter/material.dart';
import 'package:ojps_flutter/constants/colors.dart';
import 'package:ojps_flutter/constants/text_styles.dart';

class JobInfoBoxWidget extends StatelessWidget {
  const JobInfoBoxWidget({super.key});

  final List<Map<String, String>> jobInfo = const [
    {"title": "Experience", "value": "Required"},
    {"title": "Languages", "value": "English - Advanced"},
    {"title": "Employment", "value": "Full-time"},
    {"title": "Schedule", "value": "Wednesday to Saturday"},
    {"title": "Category", "value": "Web Development"},
    {"title": "Salary", "value": "\$800 - \$1000 monthly"},
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: AppValues.horizontalPadding),
      padding: const EdgeInsets.symmetric(
        vertical: AppValues.verticalButtonPadding,
        horizontal: AppValues.allPadding,
      ),
      decoration: BoxDecoration(
        color: cardBackgroundColor,
        borderRadius: BorderRadius.circular(AppValues.borderRadiusContainer),
      ),
      child: Column(
        children: List.generate(jobInfo.length * 2 - 1, (index) {
          if (index.isEven) {
            final item = jobInfo[index ~/ 2];
            return _infoRow(item['title']!, item['value']!);
          } else {
            return _divider();
          }
        }),
      ),
    );
  }

  Widget _infoRow(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppValues.jobDescSpacingHeight),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: AppValues.jobDescTitleFontSize,
              fontWeight: FontWeight.bold,
              color: primaryTextColor,
            ),
          ),
          Text(
            value,
            style: const TextStyle(
              fontSize: AppValues.jobDescContentFontSize,
              color: secondaryTextColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _divider() {
    return const Divider(
      color: primaryTextColor,
      thickness: 1,
    );
  }
}


