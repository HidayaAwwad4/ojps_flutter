import 'package:flutter/material.dart';
import '../constants/dimensions.dart';
import '../constants/spaces.dart';
import '../models/job_model.dart';

class HeaderBar extends StatelessWidget {
  final Job updatedJob;

  const HeaderBar({super.key, required this.updatedJob});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppDimensions.defaultPadding, vertical: AppDimensions.paddingSmall),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: () => Navigator.pop(context, updatedJob),
            child: const Icon(Icons.close),
          ),
          Spaces.horizontal(AppDimensions.horizontalSpacerXLarge),
        ],
      ),
    );
  }
}

