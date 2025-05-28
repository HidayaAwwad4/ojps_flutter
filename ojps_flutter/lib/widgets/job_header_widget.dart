import 'package:flutter/material.dart';
import 'package:ojps_flutter/constants/colors.dart';
import 'package:ojps_flutter/constants/text_styles.dart';

class JobHeaderWidget extends StatelessWidget {
  const JobHeaderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [
        SizedBox(height: AppValues.jobDescSpacingHeight * 0.5),
        CircleAvatar(
          radius: AppValues.avatarRadius,
          backgroundImage: AssetImage('assets/adham.jpg'),
        ),
        SizedBox(height: AppValues.jobHeaderSpacing),
        Text(
          "Backend Developer",
          style: TextStyle(
            fontSize: AppValues.jobHeaderTitleFontSize,
            fontWeight: FontWeight.bold,
            color: primaryTextColor,
          ),
        ),
        SizedBox(height: AppValues.jobDescSpacingHeight),
        Text(
          "Adham",
          style: TextStyle(
            fontSize: AppValues.jobHeaderNameFontSize,
            color: primaryTextColor,
          ),
        ),
        Text(
          "Rafidia, Nablus",
          style: TextStyle(
            fontSize: AppValues.jobHeaderLocationFontSize,
            color: secondaryTextColor,
          ),
        ),
        SizedBox(height: AppValues.jobHeaderBottomSpacing),
      ],
    );
  }
}
