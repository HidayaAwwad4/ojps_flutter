import 'package:flutter/material.dart';
import '../constants/dimensions.dart';
import '../models/job_model.dart';
import 'job_card_content.dart';

class JobCardHorizontal extends StatelessWidget {
  final Job job;
  final Function(Job) onStatusChange;
  final Function(Job)? onJobDeleted;

  const JobCardHorizontal({
    super.key,
    required this.job,
    required this.onStatusChange,
    this.onJobDeleted,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: AppDimensions.jobCardHorizontalWidth,
      margin: const EdgeInsets.symmetric(vertical: AppDimensions.verticalSpacerSmall),
      child: JobCardContent(
        job: job,
        onStatusChange: onStatusChange,
        onJobDeleted: onJobDeleted,
        padding: const EdgeInsets.all(AppDimensions.paddingSmall),
        showVerticalLayout: false,
      ),
    );
  }
}
