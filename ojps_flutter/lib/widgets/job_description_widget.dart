import 'package:flutter/material.dart';
import 'package:ojps_flutter/constants/colors.dart';

class JobDescriptionWidget extends StatelessWidget {
  const JobDescriptionWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Text(
            "Description",
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: primaryTextColor),
          ),
          SizedBox(height: 4),
          Text(
            "Work on server-side applications and APIs for smooth operations.",
            style: TextStyle(fontSize: 13, color: secondaryTextColor),
          ),
        ],
      ),
    );
  }
}
