import 'package:flutter/material.dart';
import '../constants/colors.dart';
import '../models/job_model.dart';
//import 'edit_job_screen.dart';
import '../widgets/detail_tile.dart';
import '../widgets/header_bar.dart';
import 'edit_job_screen.dart';

class JobDetailsScreen extends StatelessWidget {
  final Job job;

  const JobDetailsScreen({super.key, required this.job});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
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
                      backgroundColor: primaryTextColor,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      job.title,
                      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      job.companyLocation,
                      style: const TextStyle(color:greyColor),
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

                    Container(
                      decoration: BoxDecoration(
                        color: cardBackgroundColor,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Column(
                        children: [
                          DetailTile(title: 'Experience', value: job.experience),
                          const Divider(height: 1),
                          DetailTile(title: 'Languages', value: job.language),
                          const Divider(height: 1),
                          DetailTile(title: 'Employment', value: job.employment),
                          const Divider(height: 1),
                          DetailTile(title: 'Schedule', value: job.schedule),
                          const Divider(height: 1),
                          DetailTile(title: 'Category', value: job.category),
                          const Divider(height: 1),
                          DetailTile(title: 'Salary', value: job.salary),
                        ],
                      ),
                    ),


                    const SizedBox(height: 16),

                    ElevatedButton.icon(
                      onPressed: () {
                        // Handle documents logic
                      },
                      style: ElevatedButton.styleFrom(
                        foregroundColor: primaryTextColor,
                        backgroundColor: cardBackgroundColor,
                        minimumSize: const Size(double.infinity, 48),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      icon: const Icon(Icons.description),
                      label: const Text('Documents'),
                    ),


                    const SizedBox(height: 20),

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
                        backgroundColor: primaryColor,
                        foregroundColor: whiteColor,
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
