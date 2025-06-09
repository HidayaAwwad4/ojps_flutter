import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:ojps_flutter/constants/colors.dart';
import 'package:ojps_flutter/screens/job_list_screen.dart';
import 'package:ojps_flutter/constants/text_styles.dart';

class CategoryListRow extends StatelessWidget {
  final List<Map<String, dynamic>> categories;

  const CategoryListRow({super.key, required this.categories});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppValues.horizontalPadding),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: categories.map((category) {
          final String translatedLabel = category['key'].toString().tr();

          return Expanded(
            child: InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        JobListScreen(categoryLabel: translatedLabel),
                  ),
                );
              },
              child: Column(
                children: [
                  Container(
                    width: AppValues.categoryIconContainerSize,
                    height: AppValues.categoryIconContainerSize,
                    decoration: BoxDecoration(
                      color: Colorss.whiteColor,
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Colorss.primaryColor,
                        width: AppValues.categoryBorderWidth,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colorss.primaryColor.withOpacity(0.1),
                          blurRadius: AppValues.categoryShadowBlur,
                          offset: AppValues.categoryShadowOffset,
                        ),
                      ],
                    ),
                    child: Icon(
                      category['icon'] as IconData,
                      color: Colorss.primaryColor,
                      size: AppValues.categoryIconSize,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    translatedLabel,
                    style: TextStyle(
                      fontSize: AppValues.categoryFontSize,
                      color: Colorss.secondaryTextColor,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
