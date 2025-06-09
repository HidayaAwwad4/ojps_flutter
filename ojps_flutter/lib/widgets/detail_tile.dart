import 'package:flutter/material.dart';

import '../constants/dimensions.dart';
import '../constants/spaces.dart';

class DetailTile extends StatelessWidget {
  final String title;
  final String value;

  const DetailTile({super.key, required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppDimensions.spacingSmall, horizontal: AppDimensions.horizontalSpacerLarge),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(
              title,
              style: const TextStyle(
                fontSize: AppDimensions.fontSizeSmall,
                color: Colors.black87,
              ),
            ),
          ),
          Spaces.horizontal(AppDimensions.verticalSpacerMedium),
          Text(
            value,
            style: const TextStyle(
              fontWeight: FontWeight.w600,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}
