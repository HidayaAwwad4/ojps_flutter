import 'package:flutter/material.dart';
import 'package:ojps_flutter/constants/colors.dart';
import 'package:ojps_flutter/constants/text_styles.dart';
import 'package:ojps_flutter/widgets/category_dots_indicator.dart';
import 'package:ojps_flutter/widgets/category_list_row.dart';

class CategoriesWidget extends StatefulWidget {
  const CategoriesWidget({super.key});

  @override
  State<CategoriesWidget> createState() => _CategoriesWidgetState();
}

class _CategoriesWidgetState extends State<CategoriesWidget> {
  final List<Map<String, dynamic>> categories = [
    {'icon': Icons.computer, 'label': 'Web Developer'},
    {'icon': Icons.checkroom, 'label': 'Fashion'},
    {'icon': Icons.restaurant, 'label': 'Chef & Cook'},
    {'icon': Icons.palette, 'label': 'Designer'},
    {'icon': Icons.build, 'label': 'Technician'},
    {'icon': Icons.language, 'label': 'Translator'},
  ];

  int currentPage = 0;

  @override
  Widget build(BuildContext context) {
    final totalPages = (categories.length / AppValues.categoriesPerPage).ceil();
    final visibleCategories = categories
        .skip(currentPage * AppValues.categoriesPerPage)
        .take(AppValues.categoriesPerPage)
        .toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CategoryDotsIndicator(
          totalPages: totalPages,
          currentPage: currentPage,
          onDotTap: (index) {
            setState(() {
              currentPage = index;
            });
          },
        ),
        const SizedBox(height: 16),
        CategoryListRow(categories: visibleCategories),
      ],
    );
  }
}
