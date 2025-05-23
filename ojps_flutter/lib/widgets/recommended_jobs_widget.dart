import 'package:flutter/material.dart';
import 'package:ojps_flutter/constants/colors.dart';
import 'package:ojps_flutter/constants/text_styles.dart';
import 'package:ojps_flutter/screens/job_details_job_seeker_screen.dart';
import 'package:ojps_flutter/widgets/job_card_widget.dart';

class RecommendedJobsWidget extends StatefulWidget {
  const RecommendedJobsWidget({super.key});

  @override
  State<RecommendedJobsWidget> createState() => _RecommendedJobsWidgetState();
}

class _RecommendedJobsWidgetState extends State<RecommendedJobsWidget> {
  List<bool> savedJobs = [false, false, false];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        JobCardWrapper(
          child: JobCard(
            image: 'assets/adham.jpg',
            title: 'UI/UX Designer',
            location: 'Ramallah',
            type: 'Part-Time',
            description: 'Design user interfaces with a focus on usability and beauty.',
            salary: '\$500 - \$800 Salary/Month',
            isSaved: savedJobs[0],
            onSaveToggle: () {
              setState(() {
                savedJobs[0] = !savedJobs[0];
              });
            },
            onTap: () {
              Navigator.pushNamed(context, '/job_details');
            },

          ),
        ),
        JobCardWrapper(
          child: JobCard(
            image: 'assets/adham.jpg',
            title: 'Frontend Developer',
            location: 'Nablus',
            type: 'Full-Time',
            description: 'Develop beautiful and performant web applications.',
            salary: '\$1000 - \$1500 Salary/Month',
            isSaved: savedJobs[1],
            onSaveToggle: () {
              setState(() {
                savedJobs[1] = !savedJobs[1];
              });
            },
            onTap: () {
              Navigator.pushNamed(context, '/job_details');
            },

          ),
        ),
        JobCardWrapper(
          child: JobCard(
            image: 'assets/adham.jpg',
            title: 'Backend Developer',
            location: 'Hebron',
            type: 'Contract',
            description: 'Build scalable and secure backend services.',
            salary: '\$1200 - \$1700 Salary/Month',
            isSaved: savedJobs[2],
            onSaveToggle: () {
              setState(() {
                savedJobs[2] = !savedJobs[2];
              });
            },
            onTap: () {
              Navigator.pushNamed(context, '/job_details');
            },

          ),
        ),
      ],
    );
  }
}

class JobCardWrapper extends StatelessWidget {
  final Widget child;

  const JobCardWrapper({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: AppValues.jobCardMarginHorizontal,
        vertical: AppValues.jobCardMarginVertical,
      ),
      width: double.infinity,
      child: child,
    );
  }
}