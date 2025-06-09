import 'package:flutter/material.dart';
import 'package:ojps_flutter/constants/colors.dart';
import 'package:ojps_flutter/constants/text_styles.dart';
import 'package:ojps_flutter/widgets/job_card_widget.dart';

class RecommendedJobsWidget extends StatefulWidget {
  const RecommendedJobsWidget({Key? key}) : super(key: key);

  @override
  State<RecommendedJobsWidget> createState() => _RecommendedJobsWidgetState();
}

class _RecommendedJobsWidgetState extends State<RecommendedJobsWidget> {
  late List<Map<String, dynamic>> jobs;
  late List<bool> savedJobs;

  @override
  void initState() {
    super.initState();

    jobs = [
      {
        'image': 'assets/default-logo.png',
        'title': 'Flutter Developer',
        'location': 'Ramallah, Palestine',
        'type': 'Full-time',
        'description': 'Build and maintain Flutter applications.',
        'salary': '\$1200/month',
      },
      {
        'image': 'assets/default-logo.png',
        'title': 'Backend Engineer',
        'location': 'Nablus, Palestine',
        'type': 'Part-time',
        'description': 'Work with Laravel and MySQL.',
        'salary': '\$800/month',
      },
      {
        'image': 'assets/default-logo.png',
        'title': 'UI/UX Designer',
        'location': 'Hebron, Palestine',
        'type': 'Remote',
        'description': 'Design beautiful and intuitive interfaces.',
        'salary': '\$1000/month',
      },
    ];

    savedJobs = List<bool>.filled(jobs.length, false);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(jobs.length, (index) {
        final job = jobs[index];
        return JobCardWrapper(
          child: JobCard(
            image: job['image'],
            title: job['title'],
            location: job['location'],
            type: job['type'],
            description: job['description'],
            salary: job['salary'],
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