import 'package:flutter/material.dart';
import 'package:ojps_flutter/constants/colors.dart';

class JobInfoBoxWidget extends StatelessWidget {
  const JobInfoBoxWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      decoration: BoxDecoration(
        color: cardBackgroundColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          _infoRow("Experience", "Required"),
          _divider(),
          _infoRow("Languages", "English - Advanced"),
          _divider(),
          _infoRow("Employment", "Full - time"),
          _divider(),
          _infoRow("Schedule", "Wednesday to Saturday"),
          _divider(),
          _infoRow("Category", "web development"),
          _divider(),
          _infoRow("Salary", "\$800 - \$1000 monthly"),
        ],
      ),
    );
  }

  Widget _infoRow(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: primaryTextColor)),
          Text(value, style: const TextStyle(fontSize: 13, color: secondaryTextColor)),
        ],
      ),
    );
  }

  Widget _divider() {
    return const Divider(color: primaryTextColor, thickness: 1);
  }
}
