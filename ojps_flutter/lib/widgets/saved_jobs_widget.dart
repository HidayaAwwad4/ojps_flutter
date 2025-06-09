import 'package:flutter/material.dart';
import 'package:ojps_flutter/services/favorite_job_service.dart';
import 'package:ojps_flutter/widgets/job_card_widget.dart';


class SavedJobsWidget extends StatelessWidget {
  final List<Map<String, dynamic>> savedJobs = [
    {
      'image': 'assets/default-logo.png',
      'title': 'Graphic Designer',
      'location': 'Berlin, Germany',
      'type': 'Full-time',
      'description': 'Design engaging graphics for digital and print media.',
      'salary': '\$70,000',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: savedJobs.length,
      itemBuilder: (context, index) {
        final job = savedJobs[index];
        return JobCard(
          image: job['image'],
          title: job['title'],
          location: job['location'],
          type: job['type'],
          description: job['description'],
          salary: job['salary'],
          isSaved: true,
          onTap: () {
            Navigator.pushNamed(context, '/job_details');
          },
          onSaveToggle: () {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Unsave feature is disabled (static mode).')),
            );
          },
        );
      },
    );
  }
}