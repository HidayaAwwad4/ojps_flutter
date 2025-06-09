import 'package:flutter/material.dart';
import 'package:ojps_flutter/widgets/job_card_widget.dart';
import 'package:ojps_flutter/constants/colors.dart';
import 'package:ojps_flutter/constants/text_styles.dart';

class JobList extends StatefulWidget {
  final String status;
  const JobList({super.key, required this.status});

  @override
  State<JobList> createState() => _JobListState();
}

class _JobListState extends State<JobList> {
  late List<bool> savedJobs;

  final List<Map<String, dynamic>> dummyJobs = [
    {
      'image': 'assets/adham.jpg',
      'title': 'UI/UX Designer',
      'location': 'New York, NY',
      'type': 'Full-time',
      'salary': '\$40/hr',
      'status': AppValues.statusUnderReview,
    },
    {
      'image': 'assets/adham.jpg',
      'title': 'Frontend Developer',
      'location': 'San Francisco, CA',
      'type': 'Part-time',
      'salary': '\$30/hr',
      'status': AppValues.statusAccepted,
    },
    {
      'image': 'assets/adham.jpg',
      'title': 'Backend Developer',
      'location': 'Remote',
      'type': 'Contract',
      'salary': '\$50/hr',
      'status': AppValues.statusRejected,
    },
  ];

  @override
  void initState() {
    super.initState();
    savedJobs = List.generate(dummyJobs.length, (index) => false);
  }

  @override
  Widget build(BuildContext context) {
    final filteredJobs =
    dummyJobs.where((job) => job['status'] == widget.status).toList();

    return ListView.builder(
      padding: const EdgeInsets.symmetric(
        horizontal: AppValues.jobListHorizontalPadding,
        vertical: AppValues.jobListVerticalPadding,
      ),
      itemCount: filteredJobs.length,
      itemBuilder: (context, index) {
        final job = filteredJobs[index];
        return Padding(
          padding: const EdgeInsets.only(bottom: AppValues.jobCardBottomPadding),
          child: JobCard(
            image: job['image'],
            title: job['title'],
            location: job['location'],
            type: job['type'],
            salary: job['salary'],
            onTap: () {
            },

            isSaved: savedJobs[index],
            onSaveToggle: () {
              setState(() {
                savedJobs[index] = !savedJobs[index];
              });
            },
            statusLabel: getStatusLabel(job['status']),
            statusColor: getStatusColor(job['status']),
          ),
        );
      },
    );
  }

  String getStatusLabel(String status) {
    switch (status) {
      case AppValues.statusUnderReview:
        return 'Under Review';
      case AppValues.statusAccepted:
        return 'Accepted';
      case AppValues.statusRejected:
        return 'Rejected';
      default:
        return '';
    }
  }

  Color getStatusColor(String status) {
    switch (status) {
      case AppValues.statusUnderReview:
        return Colorss.primaryColor;
      case AppValues.statusAccepted:
        return Colorss.successColor;
      case AppValues.statusRejected:
        return Colorss.closedColor;
      default:
        return Colorss.secondaryTextColor;
    }
  }
}