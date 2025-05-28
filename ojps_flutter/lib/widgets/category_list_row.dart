import 'package:flutter/material.dart';
import 'package:ojps_flutter/constants/colors.dart';
import 'package:ojps_flutter/screens/job_list_screen.dart';
import 'package:ojps_flutter/constants/text_styles.dart';

class CategoryListRow extends StatelessWidget {
  final List<Map<String, dynamic>> categories;

  const CategoryListRow({super.key, required this.categories});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
          horizontal: AppValues.horizontalPadding),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: categories.map((category) {
          return InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      JobListScreen(categoryLabel: category['label']),
                ),
              );
            },
            child: SizedBox(
              width: (MediaQuery.of(context).size.width -
                  (AppValues.horizontalPadding * 4)) /
                  AppValues.categoriesPerPage,
              child: Column(
                children: [
                  Container(
                    width: AppValues.categoryIconContainerSize,
                    height: AppValues.categoryIconContainerSize,
                    decoration: BoxDecoration(
                      color: whiteColor,
                      shape: BoxShape.circle,
                      border: Border.all(
                          color: primaryColor,
                          width: AppValues.categoryBorderWidth),
                      boxShadow: [
                        BoxShadow(
                          color: primaryColor.withOpacity(0.1),
                          blurRadius: AppValues.categoryShadowBlur,
                          offset: AppValues.categoryShadowOffset,
                        ),
                      ],
                    ),
                    child: Icon(
                      category['icon'] as IconData,
                      color: primaryColor,
                      size: AppValues.categoryIconSize,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    category['label'] as String,
                    style: TextStyle(
                        fontSize: AppValues.categoryFontSize,
                        color: secondaryTextColor),
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
