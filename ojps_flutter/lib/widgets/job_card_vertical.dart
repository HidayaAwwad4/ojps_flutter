import 'package:flutter/material.dart';
import '../constants/dimensions.dart';
import '../models/job_model.dart';
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
      margin: const EdgeInsets.symmetric(horizontal: AppDimensions.horizontalSpacerLarge, vertical: AppDimensions.verticalSpacerMediumSmall),
      child: JobCardContent(
        job: job,
        onStatusChange: onStatusChange,
        onJobDeleted: onJobDeleted,
        padding: const EdgeInsets.all(AppDimensions.defaultPadding),
        showVerticalLayout: true,
      ),
    );
  }
}
