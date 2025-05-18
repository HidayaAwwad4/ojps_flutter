import 'package:flutter/material.dart';
import 'package:ojps_flutter/widgets/job_card_widget.dart';
import 'package:ojps_flutter/constants/colors.dart';

class SavedJobsWidget extends StatefulWidget {
  const SavedJobsWidget({super.key});

  @override
  State<SavedJobsWidget> createState() => _SavedJobsWidgetState();
}

class _SavedJobsWidgetState extends State<SavedJobsWidget> {
  List<Map<String, String>> savedJobs = [
    {
      'image': 'assets/adham.jpg',
      'title': 'Backend Developer',
      'location': 'Hebron',
      'type': 'Remote',
      'description': 'Maintain and scale server-side applications.',
      'salary': '\$1000 - \$1500 Salary/Month',
    },
    {
      'image': 'assets/adham.jpg',
      'title': 'Data Analyst',
      'location': 'Ramallah',
      'type': 'Full-Time',
      'description': 'Analyze data trends and build insights reports.',
      'salary': '\$700 - \$1000 Salary/Month',
    },
  ];

  void removeJob(int index) {
    setState(() {
      savedJobs.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    if (savedJobs.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Icon(Icons.bookmark_border, size: 60, color: customLightPurple),
            SizedBox(height: 16),
            Text(
              'No saved jobs yet.',
              style: TextStyle(fontSize: 18, color:customLightPurple),
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      itemCount: savedJobs.length,
      itemBuilder: (context, index) {
        final job = savedJobs[index];
        return JobCard(
          image: job['image']!,
          title: job['title']!,
          location: job['location']!,
          type: job['type']!,
          description: job['description']!,
          salary: job['salary']!,
          isSaved: true,
          onSaveToggle: () => removeJob(index),
          onTap: () {

          },
        );
      },
    );
  }
}
