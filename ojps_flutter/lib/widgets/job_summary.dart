import 'package:flutter/material.dart';
import '../constants/colors.dart';
import '../constants/dimensions.dart';
import '../constants/spaces.dart';

class JobSummaryWidget extends StatelessWidget {
  final int openJobsCount;
  final int closedJobsCount;

  const JobSummaryWidget({
    super.key,
    required this.openJobsCount,
    required this.closedJobsCount,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _buildJobSummaryItem('$openJobsCount job open'),
        const SizedBox(width: AppDimensions.verticalSpacerMediumSmall),
        _buildJobSummaryItem('$closedJobsCount job closed'),
      ],
    );
  }

  Widget _buildJobSummaryItem(String text) {
    return Expanded(
      child: Container(
        height: AppDimensions.containerHeight,
        decoration: BoxDecoration(
          color: Colorss.lightBlueBackgroundColor,
          borderRadius: BorderRadius.circular(AppDimensions.borderRadiusLarge),
        ),
        alignment: Alignment.center,
        child: Text(
          text,
          style: const TextStyle(color: Colorss.primaryTextColor),
        ),
      ),
    );
  }
}
