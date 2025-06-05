import 'package:flutter/material.dart';
import 'package:ojps_flutter/constants/colors.dart';
class ProfileDisplayFieldWidget extends StatelessWidget {
  final IconData icon;
  final String value;

  const ProfileDisplayFieldWidget({
    Key? key,
    required this.icon,
    required this.value,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: Colorss.primaryColor, size: 20),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }
}
