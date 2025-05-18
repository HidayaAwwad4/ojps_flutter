import 'package:flutter/material.dart';
import 'package:ojps_flutter/widgets/job_list.dart';

class JobTabViews extends StatelessWidget {
  const JobTabViews({super.key});

  @override
  Widget build(BuildContext context) {
    return const TabBarView(
      children: [
        JobList(status: 'under_review'),
        JobList(status: 'accepted'),
        JobList(status: 'rejected'),
      ],
    );
  }
}
