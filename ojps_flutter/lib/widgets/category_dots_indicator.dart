import 'package:flutter/material.dart';
import 'package:ojps_flutter/constants/colors.dart';
import 'package:ojps_flutter/constants/text_styles.dart';

class CategoryDotsIndicator extends StatelessWidget {
  final int totalPages;
  final int currentPage;
  final Function(int) onDotTap;

  const CategoryDotsIndicator({
    super.key,
    required this.totalPages,
    required this.currentPage,
    required this.onDotTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
          horizontal: AppValues.horizontalPadding),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: List.generate(
          totalPages,
              (index) => GestureDetector(
            onTap: () => onDotTap(index),
            child: Container(
              width: AppValues.dotSize,
              height: AppValues.dotSize,
              margin: const EdgeInsets.only(left: AppValues.dotSpacing),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: currentPage == index
                    ? Colorss.primaryColor
                    : Colorss.secondaryTextColor.withOpacity(0.3),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

