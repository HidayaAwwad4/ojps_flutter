import 'package:flutter/material.dart';

import '../constants/dimensions.dart';
import '../constants/spaces.dart';
class HeaderBar extends StatelessWidget {
  const HeaderBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppDimensions.defaultPadding, vertical: AppDimensions.paddingSmall),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: const Icon(Icons.close),
          ),
          Spaces.horizontal(AppDimensions.horizontalSpacerXLarge),
        ],
      ),
    );
  }
}
