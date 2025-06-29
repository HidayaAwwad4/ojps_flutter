import 'package:flutter/material.dart';
import 'package:ojps_flutter/constants/colors.dart';
import 'package:ojps_flutter/widgets/job_details_job_seeker_widget.dart';

class JobDetailsJobSeekerScreen extends StatelessWidget {
  const JobDetailsJobSeekerScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colorss.whiteColor,
      appBar: AppBar(
        backgroundColor: Colorss.whiteColor,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.close, color: Colorss.primaryTextColor),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: const JobDetailsJopSeekerWidget(),
    );
  }
}
