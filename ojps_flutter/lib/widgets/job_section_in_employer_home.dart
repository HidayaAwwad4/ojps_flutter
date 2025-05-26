import 'package:flutter/material.dart';
import '../models/job_model.dart';
import '../screens/job_posting_screen.dart';
import 'job_card_horizontal.dart';

class JobSectionWidget extends StatelessWidget {
  final String title;
  final List<Job> jobs;
  final int tabIndex;
  final Function(Job) onStatusChange;
  final Function(Job)? onJobDeleted;

  const JobSectionWidget({
    super.key,
    required this.title,
    required this.jobs,
    required this.tabIndex,
    required this.onStatusChange,
    this.onJobDeleted,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            const Spacer(),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => JobPostingScreen(tabIndex: tabIndex),
                  ),
                );
              },
              child: const Text(
                'See All',
                style: TextStyle(fontSize: 14, color: Color(0xFF0273B1), fontWeight: FontWeight.w500),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        SizedBox(
          height: 270,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: jobs.length,
            separatorBuilder: (context, index) => const SizedBox(width: 16),
            itemBuilder: (context, index) {
              return SizedBox(
                width: 320,
                child: JobCardHorizontal(
                  job: jobs[index],
                  onStatusChange: onStatusChange,
                  onJobDeleted: onJobDeleted,
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
