import 'package:flutter/material.dart';
import 'package:ojps_flutter/widgets/job_list.dart';
import 'package:ojps_flutter/constants/text_styles.dart';

class JobTabViews extends StatelessWidget {
  const JobTabViews({super.key});

  @override
  Widget build(BuildContext context) {
    return const TabBarView(
      children: [
        JobList(status: AppValues.statusUnderReview),
        JobList(status: AppValues.statusAccepted),
        JobList(status: AppValues.statusRejected),
      ],
    );
  }
}
