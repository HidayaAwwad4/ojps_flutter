import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:ojps_flutter/constants/colors.dart';
import 'package:ojps_flutter/constants/text_styles.dart';
import 'package:ojps_flutter/widgets/category_dots_indicator.dart';
import 'package:ojps_flutter/widgets/category_list_row.dart';
import 'package:ojps_flutter/screens/job_list_screen.dart';

class CategoriesWidget extends StatefulWidget {
  const CategoriesWidget({super.key});

  @override
  State<CategoriesWidget> createState() => _CategoriesWidgetState();
}

class _CategoriesWidgetState extends State<CategoriesWidget> {
  final List<Map<String, dynamic>> categories = [
    {'icon': Icons.campaign, 'key': 'marketing'},
    {'icon': Icons.computer, 'key': 'technology'},
    {'icon': Icons.palette, 'key': 'design'},
    {'icon': Icons.sell, 'key': 'sales'},
    {'icon': Icons.restaurant, 'key': 'cooking'},
  ];

  int currentPage = 0;
  late final int totalPages;
  final PageController _pageController = PageController();

  @override
  void initState() {
    super.initState();
    totalPages = (categories.length / AppValues.categoriesPerPage).ceil();
  }

  List<List<Map<String, dynamic>>> _chunkCategories() {
    List<List<Map<String, dynamic>>> chunks = [];
    for (int i = 0; i < totalPages; i++) {
      int start = i * AppValues.categoriesPerPage;
      int end = start + AppValues.categoriesPerPage;
      chunks.add(categories.sublist(start, end > categories.length ? categories.length : end));
    }
    return chunks;
  }

  String getCategoryLabel(Map<String, dynamic> category) {
    return category['key'].toString().tr();
  }

  Widget _buildCategoryItem(Map<String, dynamic> category, double width) {
    return SizedBox(
      width: width,
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
            getCategoryLabel(category),
            style: TextStyle(
              fontSize: AppValues.categoryFontSize,
              color: Colorss.secondaryTextColor,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final chunks = _chunkCategories();
    final screenWidth = MediaQuery.of(context).size.width;
    final bool isWide = screenWidth >= 800;

    if (isWide) {
      final double itemWidth = 120;
      return SizedBox(
        height: 140,
        child: Center(
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppValues.horizontalPadding),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: categories.map((category) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => JobListScreen(
                              categoryLabel: getCategoryLabel(category),
                            ),
                          ),
                        );
                      },
                      child: _buildCategoryItem(category, itemWidth),
                    ),
                  );
                }).toList(),
              ),
            ),
          ),
        ),
      );
    } else {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CategoryDotsIndicator(
            totalPages: totalPages,
            currentPage: currentPage,
            onDotTap: (index) {
              _pageController.animateToPage(
                index,
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
              );
            },
          ),
          const SizedBox(height: 16),
          SizedBox(
            height: 120,
            child: PageView.builder(
              controller: _pageController,
              itemCount: totalPages,
              onPageChanged: (index) {
                setState(() {
                  currentPage = index;
                });
              },
              itemBuilder: (context, index) {
                return CategoryListRow(categories: chunks[index]);
              },
            ),
          ),
        ],
      );
    }
  }
}