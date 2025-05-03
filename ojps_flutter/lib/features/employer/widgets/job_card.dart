import 'package:flutter/material.dart';
import '../models/job_model.dart';

class JobCard extends StatelessWidget {
  final Job job;
  final Function(Job) onStatusChange;

  const JobCard({super.key, required this.job, required this.onStatusChange});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFFF0F0F0),
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
                child: Image.asset(
                  job.imageUrl,
                  width: 40,
                  height: 40,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      job.title,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      job.employment,
                      style: const TextStyle(fontSize: 13, color: Colors.black87),
                    ),
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
                            ? 'Are you sure you want to close this job? It will no longer be visible to job seekers.'
                            : 'Are you sure you want to open this job? It will now be visible to job seekers.',
                      ),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.of(context).pop(),
                          child: const Text('Cancel'),
                        ),
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
                      color: job.isOpen ? Colors.red : Colors.green,
                      size: 20,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      job.isOpen ? 'Closed' : 'Open',
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                        color: job.isOpen ? Colors.red : Colors.green,
                      ),
                    ),
                  ],
                ),
              ),


            ],
          ),
          const SizedBox(height: 12),
          Text(
            job.description,
            style: const TextStyle(fontSize: 14, color: Colors.black87),
          ),
          const SizedBox(height: 10),
          Text(
            job.salary,
            style: const TextStyle(
              fontSize: 14,
              color: Colors.black87,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    // Show applicants
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF007ACC),
                    foregroundColor: Colors.white,
                  ),
                  child: const Text('Applicants'),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: OutlinedButton(
                  onPressed: () {
                    // Delete job
                  },
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: Color(0xFF007ACC)),
                    foregroundColor: const Color(0xFF007ACC),
                  ),
                  child: const Text('Delete'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
