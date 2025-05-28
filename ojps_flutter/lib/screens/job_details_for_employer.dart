import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../constants/colors.dart';
import '../models/job_model.dart';
import '../utils/network_utils.dart';
import 'edit_job_screen.dart';
import '../widgets/detail_tile.dart';
import '../widgets/header_bar.dart';

class JobDetailsScreen extends StatefulWidget {
  final Job job;

  const JobDetailsScreen({super.key, required this.job});

  @override
  State<JobDetailsScreen> createState() => _JobDetailsScreenState();
}

class _JobDetailsScreenState extends State<JobDetailsScreen> {
  late Job job;

  @override
  void initState() {
    super.initState();
    job = widget.job;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colorss.whiteColor,
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
                      backgroundImage: job.companyLogo != null
                          ? NetworkImage(fixUrl(job.companyLogo!))
                          : const AssetImage('assets/default-logo.png') as ImageProvider,
                      backgroundColor: Colorss.primaryTextColor,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      job.title,
                      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      job.location,
                      style: const TextStyle(color: Colorss.greyColor),
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
                        color: Colorss.cardBackgroundColor,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Column(
                        children: [
                          DetailTile(title: 'Experience', value: job.experience),
                          const Divider(height: 1),
                          DetailTile(title: 'Languages', value: job.languages),
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
                    if (job.documents != null)
                      ElevatedButton.icon(
                        onPressed: () async {
                          final fixedUrl = fixUrl(job.documents!);
                          final Uri url = Uri.parse(fixedUrl);
                          if (await canLaunchUrl(url)) {
                            await launchUrl(url);
                          } else {
                            print('Could not launch $fixedUrl');
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colorss.primaryTextColor,
                          backgroundColor: Colorss.cardBackgroundColor,
                          minimumSize: const Size(double.infinity, 48),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        icon: const Icon(Icons.description),
                        label: const Text('View Documents'),
                      ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () async {
                        final updatedJob = await Navigator.push<Job>(
                          context,
                          MaterialPageRoute(
                            builder: (_) => EditJobScreen(job: job),
                          ),
                        );

                        if (updatedJob != null) {
                          setState(() {
                            job = updatedJob;
                          });
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colorss.primaryColor,
                        foregroundColor: Colorss.whiteColor,
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
