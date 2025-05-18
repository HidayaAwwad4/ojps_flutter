import 'package:flutter/material.dart';
import 'package:ojps_flutter/widgets/job_card_widget.dart';
import 'package:ojps_flutter/constants/colors.dart';

class JobList extends StatefulWidget {
  final String status;
  const JobList({super.key, required this.status});

  @override
  State<JobList> createState() => _JobListState();
}

class _JobListState extends State<JobList> {
  late List<bool> savedJobs;

  @override
  void initState() {
    super.initState();
    savedJobs = List.generate(dummyJobs.length, (index) => false);
  }

  @override
  Widget build(BuildContext context) {
    final filteredJobs = dummyJobs.where((job) => job['status'] == widget.status).toList();

    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      itemCount: filteredJobs.length,
      itemBuilder: (context, index) {
        final job = filteredJobs[index];
        return Padding(
          padding: const EdgeInsets.only(bottom: 16),
          child: JobCard(
            image: job['image'],
            title: job['title'],
            location: job['location'],
            type: job['type'],
            onTap: () {
            },
            salary: job['salary'],
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
      case 'under_review':
        return 'Under Review';
      case 'accepted':
        return 'Accepted';
      case 'rejected':
        return 'Rejected';
      default:
        return '';
    }
  }

  Color getStatusColor(String status) {
    switch (status) {
      case 'under_review':
        return primaryColor;
      case 'accepted':
        return successColor;
      case 'rejected':
        return closedColor;
      default:
        return secondaryTextColor;
    }
  }
}


final List<Map<String, dynamic>> dummyJobs = [
  {
    'image': 'assets/adham.jpg',
    'title': 'Mobile Developer',
    'location': 'Nablus',
    'type': 'Full-Time',
    'salary': '\$1200 / month',
    'status': 'under_review',
  },
  {
    'image': 'assets/adham.jpg',
    'title': 'Backend Developer',
    'location': 'Ramallah',
    'type': 'Part-Time',
    'salary': '\$800 / month',
    'status': 'accepted',
  },
  {
    'image': 'assets/adham.jpg',
    'title': 'UI/UX Designer',
    'location': 'Hebron',
    'type': 'Freelance',
    'salary': '\$1000 / month',
    'status': 'rejected',
  },
];

