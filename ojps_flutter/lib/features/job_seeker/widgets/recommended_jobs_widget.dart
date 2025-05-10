import 'package:flutter/material.dart';

class RecommendedJobsWidget extends StatelessWidget {
  const RecommendedJobsWidget({super.key});

  Widget buildJobCard({
    required String image,
    required String title,
    required String location,
    required String type,
    required String description,
    required String salary,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image and Title Row
          Row(
            children: [
              ClipOval(
                child: Image.asset(
                  image,
                  width: 50,
                  height: 50,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16)),
                    const SizedBox(height: 4),
                    Text("$location • $type",
                        style: const TextStyle(
                            color: Colors.grey, fontSize: 12)),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(description, style: const TextStyle(fontSize: 12)),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(salary,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 14)),
              const Icon(Icons.bookmark_border, color: Colors.blue),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        buildJobCard(
          image: 'lib/assets/adham.jpg',
          title: 'Full-Stack Developer',
          location: 'Nablus-Rafidia',
          type: 'Full-Time',
          description:
          'Responsible for developing front-end and back-end systems.',
          salary: '\$800 - \$1000 Salary/Month',
        ),
        buildJobCard(
          image: 'lib/assets/adham.jpg',
          title: 'UI/UX Designer',
          location: 'Ramallah',
          type: 'Part-Time',
          description:
          'Design user interfaces with a focus on usability and beauty.',
          salary: '\$500 - \$800 Salary/Month',
        ),
      ],
    );
  }
}
