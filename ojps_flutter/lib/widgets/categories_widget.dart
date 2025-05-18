import 'package:flutter/material.dart';
import 'package:ojps_flutter/constants/colors.dart';

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
    final totalPages = (categories.length / 3).ceil();

    final visibleCategories = categories.skip(currentPage * 3).take(3).toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Categories',
                    style: TextStyle(fontSize: 18, color: primaryTextColor),
                  ),
                  Row(
                    children: List.generate(
                      totalPages,
                          (index) => GestureDetector(
                        onTap: () {
                          setState(() {
                            currentPage = index;
                          });
                        },
                        child: Container(
                          width: 8,
                          height: 8,
                          margin: const EdgeInsets.only(left: 6),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: currentPage == index
                                ? primaryColor
                                : secondaryTextColor.withOpacity(0.3),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
            ],
          ),
        ),
        const SizedBox(height: 16),

        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: visibleCategories.map((category) {
              return SizedBox(
                width: (MediaQuery.of(context).size.width - 64) / 3,
                child: Column(
                  children: [
                    Container(
                      width: 70,
                      height: 70,
                      decoration: BoxDecoration(
                        color: whiteColor,
                        shape: BoxShape.circle,
                        border: Border.all(color: primaryColor, width: 2),
                        boxShadow: [
                          BoxShadow(
                            color: primaryColor.withOpacity(0.1),
                            blurRadius: 6,
                            offset: const Offset(2, 4),
                          ),
                        ],
                      ),
                      child: Icon(
                        category['icon'] as IconData,
                        color: primaryColor,
                        size: 32,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      category['label'] as String,
                      style: TextStyle(fontSize: 12, color: secondaryTextColor),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}

