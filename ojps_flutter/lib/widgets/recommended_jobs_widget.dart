import 'package:flutter/material.dart';
import 'package:ojps_flutter/constants/colors.dart';
import 'package:ojps_flutter/constants/text_styles.dart';
import 'package:ojps_flutter/screens/job_details_job_seeker_screen.dart';
import 'package:ojps_flutter/widgets/job_card_widget.dart';
import 'package:ojps_flutter/services/job_service.dart';

class RecommendedJobsWidget extends StatefulWidget {
  const RecommendedJobsWidget({Key? key}) : super(key: key);

  @override
  State<RecommendedJobsWidget> createState() => _RecommendedJobsWidgetState();
}

class _RecommendedJobsWidgetState extends State<RecommendedJobsWidget> {
  late Future<List<dynamic>> _futureJobs;
  List<bool> savedJobs = [];

  @override
  void initState() {
    super.initState();
    _futureJobs = JobService().fetchRecommendedJobs();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<dynamic>>(
      future: _futureJobs,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text('No recommended jobs found.'));
        } else {
          final jobs = snapshot.data!;
          if (savedJobs.length != jobs.length) {
            savedJobs = List<bool>.filled(jobs.length, false);
          }
          return Column(
            children: List.generate(jobs.length, (index) {
              final job = jobs[index];
              return JobCardWrapper(
                child: JobCard(
                  image: job['image'] ?? 'assets/default-logo.png',
                  title: job['title'] ?? 'No Title',
                  location: job['location'] ?? 'Unknown',
                  type: job['type'] ?? '',
                  description: job['description'] ?? '',
                  salary: job['salary'] ?? '',
                  isSaved: savedJobs[index],
                  onSaveToggle: () {
                    setState(() {
                      savedJobs[index] = !savedJobs[index];
                    });
                  },
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      '/job_details',
                      arguments: job,
                    );
                  },
                ),
              );
            }),
          );
        }
      },
    );
  }
}

class JobCardWrapper extends StatelessWidget {
  final Widget child;

  const JobCardWrapper({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      width: double.infinity,
      child: child,
    );
  }
}