import 'package:flutter/material.dart';

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
        const SizedBox(width: 10),
        _buildJobSummaryItem('$closedJobsCount job closed'),
      ],
    );
  }

  Widget _buildJobSummaryItem(String text) {
    return Expanded(
      child: Container(
        height: 40,
        decoration: BoxDecoration(
          color: const Color(0xFFDDEAF3),
          borderRadius: BorderRadius.circular(20),
        ),
        alignment: Alignment.center,
        child: Text(
          text,
          style: const TextStyle(color: Colors.black),
        ),
      ),
    );
  }
}
