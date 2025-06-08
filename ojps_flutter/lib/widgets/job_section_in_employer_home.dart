import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import '../constants/colors.dart';
import '../constants/dimensions.dart';
import '../models/job_model.dart';
import 'job_card_horizontal.dart';

class JobSectionWidget extends StatelessWidget {
  final String title;
  final List<Job> jobs;
  final int tabIndex;

  const JobSectionWidget({
    super.key,
    required this.title,
    required this.jobs,
    required this.tabIndex,
  });

  @override
  Widget build(BuildContext context) {
    if (jobs.isEmpty) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(title, style: const TextStyle(fontSize: AppDimensions.fontSizeNormal, fontWeight: FontWeight.bold)),
            ],
          ),
          const SizedBox(height: AppDimensions.verticalSpacerBetweenTitleAndList),
          Text(
            tr('noJobsAvailable'),
            style: const TextStyle(
              color: Colorss.secondaryTextColor,
              fontSize: AppDimensions.fontSizeSmall,
            ),
          ),
        ],
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(title, style: const TextStyle(fontSize: AppDimensions.fontSizeNormal, fontWeight: FontWeight.bold)),
            const Spacer(),
            GestureDetector(
              onTap: () {
                Navigator.pushNamed(
                  context,
                  '/employer/job-posting',
                  arguments: {
                    'tabIndex': tabIndex,
                    'fromSeeAll': true,
                  },
                );
              },
              child: Text(
                tr('seeAll'),
                style: const TextStyle(
                  fontSize: AppDimensions.fontSizeSmall,
                  color: Colorss.primaryColor,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: AppDimensions.verticalSpacerBetweenTitleAndList),
        SizedBox(
          height: AppDimensions.horizontalJobListHeight,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: jobs.length,
            separatorBuilder: (context, index) => const SizedBox(width: AppDimensions.horizontalSpacerLarge),
            itemBuilder: (context, index) {
              return SizedBox(
                width: AppDimensions.jobCardHorizontalWidth,
                child: JobCardHorizontal(
                  job: jobs[index],

                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
