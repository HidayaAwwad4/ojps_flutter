import 'package:flutter/material.dart';
import 'package:ojps_flutter/models/applicant_model.dart';
import '../constants/colors.dart';
import '../models/job_model.dart';
import '../screens/applicant_details.dart';
import '../screens/job_applicants_employer.dart';
import '../screens/job_details_for_employer.dart';
import '../utils/network_utils.dart';
import 'job_card_content.dart';

class JobCardVertical extends StatelessWidget {
  final Job job;
  final Function(Job) onStatusChange;
  final Function(Job)? onJobDeleted;

  const JobCardVertical({
    Key? key,
    required this.job,
    this.onJobDeleted,
    required this.onStatusChange
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      child: JobCardContent(
        job: job,
        onStatusChange: onStatusChange,
        onJobDeleted: onJobDeleted,
        padding: const EdgeInsets.all(16),
        showVerticalLayout: true,
      ),
    );
  }
}
