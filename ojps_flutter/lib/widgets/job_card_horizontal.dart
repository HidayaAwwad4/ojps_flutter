import 'package:flutter/material.dart';
import '../constants/colors.dart';
import '../models/applicant_model.dart';
import '../models/job_model.dart';
import '../screens/applicant_details.dart';
import '../screens/job_details_for_employer.dart';

class JobCardHorizontal extends StatelessWidget {
  final Job job;
  final Function(Job) onStatusChange;

  const JobCardHorizontal({super.key, required this.job, required this.onStatusChange});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => JobDetailsScreen(job: job)),
        );
      },
      child: Container(
        width: 320,
        margin: const EdgeInsets.symmetric(vertical: 8),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: cardBackgroundColor,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(50),
                  child: Image.asset(job.imageUrl, width: 40, height: 40, fit: BoxFit.cover),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(job.title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 4),
                      Text(job.employment, style: const TextStyle(fontSize: 13, color: secondaryTextColor)),
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: Text(job.isOpen ? 'Close Job?' : 'Open Job?'),
                        content: Text(
                          job.isOpen
                              ? 'Are you sure you want to close this job?'
                              : 'Are you sure you want to open this job?',
                        ),
                        actions: [
                          TextButton(onPressed: () => Navigator.of(context).pop(), child: const Text('Cancel')),
                          TextButton(
                            onPressed: () {
                              onStatusChange(job);
                              Navigator.of(context).pop();
                            },
                            child: const Text('Confirm'),
                          ),
                        ],
                      ),
                    );
                  },
                  child: Row(
                    children: [
                      Icon(
                        job.isOpen ? Icons.cancel_outlined : Icons.check_circle_outline,
                        color: job.isOpen ?closedColor : openColor,
                        size: 20,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        job.isOpen ? 'Closed' : 'Open',
                        style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500, color: job.isOpen ? closedColor : openColor),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Text(job.description, style: const TextStyle(fontSize: 14, color: secondaryTextColor)),
            const SizedBox(height: 10),
            Text(job.salary, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => JobApplicantsScreen(applicants: applicants),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      foregroundColor: whiteColor,
                      backgroundColor: primaryColor,
                    ),
                    child: const Text('Applicants'),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {},
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: Color(0xFF0273B1)),
                      foregroundColor: primaryColor,
                    ),
                    child: const Text('Delete'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
