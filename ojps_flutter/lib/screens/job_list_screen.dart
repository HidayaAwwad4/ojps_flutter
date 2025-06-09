import 'package:flutter/material.dart';
import 'package:ojps_flutter/constants/colors.dart';
import 'package:ojps_flutter/constants/text_styles.dart';
import 'package:ojps_flutter/widgets/job_card_widget.dart';
import 'package:ojps_flutter/services/job_service.dart';

class JobListScreen extends StatefulWidget {
  final String categoryLabel;

  const JobListScreen({super.key, required this.categoryLabel});

  @override
  State<JobListScreen> createState() => _JobListScreenState();
}

class _JobListScreenState extends State<JobListScreen> {
  final JobService _jobService = JobService();
  late Future<List<dynamic>> _jobsFuture;

  @override
  void initState() {
    super.initState();
    _jobsFuture = _jobService.fetchJobsByCategory(widget.categoryLabel);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Jobs: ${widget.categoryLabel}'),
        backgroundColor: Colorss.primaryColor,
      ),
      body: SafeArea(
        child: FutureBuilder<List<dynamic>>(
          future: _jobsFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('An error occurred: ${snapshot.error}'));
            } else if (snapshot.data == null || snapshot.data!.isEmpty) {
              return const Center(child: Text('No jobs found'));
            }

            final jobs = snapshot.data!;
            return ListView.builder(
              itemCount: jobs.length,
              itemBuilder: (context, index) {
                final job = jobs[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppValues.horizontalPadding,
                    vertical: AppValues.jobCardVerticalPadding,
                  ),
                  child: JobCard(
                    image: job['image_url'] ?? 'assets/default-logo.png',
                    title: job['title'] ?? '',
                    location: job['location'] ?? '',
                    type: job['type'] ?? '',
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        '/job_details',
                        arguments: job,
                      );
                    },
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
