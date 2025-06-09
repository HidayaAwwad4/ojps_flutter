import 'package:flutter/material.dart';
import '../../constants/spaces.dart';
import '/constants/colors.dart';
import '/constants/dimensions.dart';

class ProfileInfoTile extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const ProfileInfoTile({
    super.key,
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: AppDimensions.defaultPadding / 2),
      padding: EdgeInsets.all(AppDimensions.defaultPadding),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colorss.primaryColor),
        borderRadius: BorderRadius.circular(AppDimensions.defaultRadius),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            blurRadius: 5,
            offset: Offset(0, 3),
          )
        ],
      ),
      child: Row(
        children: [
          Icon(icon, color: Colorss.primaryColor),
          Spaces.horizontal( AppDimensions.defaultPadding),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(label,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                      color: Colors.black54,
                    )),
                Spaces.vertical(10),
                Text(value, style: TextStyle(fontSize: 16)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
