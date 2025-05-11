import 'package:flutter/material.dart';
import '../models/job_model.dart';
import 'edit_job_screen.dart';
import '../widgets/detail_tile.dart';
import '../widgets/header_bar.dart';

class JobDetailsScreen extends StatelessWidget {
  final Job job;

  const JobDetailsScreen({super.key, required this.job});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            const HeaderBar(),

            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      radius: 36,
                      backgroundImage: AssetImage(job.imageUrl),
                      backgroundColor: Colors.black,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      job.title,
                      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      job.companyLocation,
                      style: const TextStyle(color: Colors.grey),
                    ),
                    const SizedBox(height: 16),

                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Description',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(job.description),
                    ),
                    const SizedBox(height: 20),

                    DetailTile(title: 'Experience', value: job.experience),
                    DetailTile(title: 'Languages', value: job.language),
                    DetailTile(title: 'Employment', value: job.employment),
                    DetailTile(title: 'Schedule', value: job.schedule),
                    DetailTile(title: 'Salary', value: job.salary),

                    const SizedBox(height: 24),

                    ElevatedButton.icon(
                      onPressed: () {
                        // Handle documents logic
                      },
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.black,
                        backgroundColor: const Color(0xFFE8E8E8),
                        minimumSize: const Size(double.infinity, 48),
                      ),
                      icon: const Icon(Icons.file_download),
                      label: const Text('Documents'),
                    ),

                    const SizedBox(height: 12),

                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => EditJobScreen(job: job),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF007ACC),
                        foregroundColor: Colors.white,
                        minimumSize: const Size(double.infinity, 48),
                      ),
                      child: const Text('Edit'),
                    ),

                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
