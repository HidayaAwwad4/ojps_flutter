import 'package:flutter/material.dart';

class CategoriesWidget extends StatelessWidget {
  const CategoriesWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final categories = [
      {'icon': Icons.computer, 'label': 'Web Developer'},
      {'icon': Icons.checkroom, 'label': 'Fashion'},
      {'icon': Icons.restaurant, 'label': 'Chef & Cook'},
      {'icon': Icons.phone_iphone, 'label': 'Mobile Developer'},
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Title Row
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Text(
                'Categories',
                style: TextStyle(fontSize: 18),
              ),
              Text(
                'See all',
                style: TextStyle(fontSize: 14, color: Colors.blue),
              ),
            ],
          ),
        ),
        const SizedBox(height: 10),
        // Categories Row
        SizedBox(
          height: 100,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            itemCount: categories.length,
            separatorBuilder: (context, index) => const SizedBox(width: 16),
            itemBuilder: (context, index) {
              final category = categories[index];
              return Column(
                children: [
                  Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.blue, width: 2),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.3),
                          blurRadius: 6,
                          offset: const Offset(2, 4),
                        ),
                      ],
                    ),
                    child: Icon(
                      category['icon'] as IconData,
                      color: Colors.blue,
                      size: 30,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    category['label'] as String,
                    style: const TextStyle(fontSize: 12),
                  ),
                ],
              );
            },
          ),
        ),
      ],
    );
  }
}
