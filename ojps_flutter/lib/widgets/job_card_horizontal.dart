import 'package:flutter/material.dart';
import '../constants/dimensions.dart';
import '../models/job_model.dart';
import 'job_card_content.dart';

class JobCardHorizontal extends StatelessWidget {
  final Job job;

  const JobCardHorizontal({
    super.key,
    required this.job,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: AppDimensions.jobCardHorizontalWidth,
      margin: const EdgeInsets.symmetric(vertical: AppDimensions.verticalSpacerSmall),
      child: JobCardContent(
        job: job,
        padding: const EdgeInsets.all(AppDimensions.paddingSmall),
        showVerticalLayout: false,
      ),
    );
  }
}
