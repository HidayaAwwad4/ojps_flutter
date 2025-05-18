import 'package:flutter/material.dart';
import 'package:ojps_flutter/widgets/job_header_widget.dart';
import 'package:ojps_flutter/widgets/job_description_widget.dart';
import 'package:ojps_flutter/widgets/job_info_box_widget.dart';
import 'package:ojps_flutter/widgets/job_action_buttons_widget.dart';

class JobDetailsJopSeekerWidget extends StatelessWidget {
  const JobDetailsJopSeekerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: const [
          JobHeaderWidget(),
          JobDescriptionWidget(),
          SizedBox(height: 16),
          JobInfoBoxWidget(),
          SizedBox(height: 16),
          JobActionButtonsWidget(),
          SizedBox(height: 24),
        ],
      ),
    );
  }
}

