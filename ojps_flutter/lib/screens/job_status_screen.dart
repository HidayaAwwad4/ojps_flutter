import 'package:flutter/material.dart';
import '../widgets/job_tab_bar.dart';
import '../widgets/job_tab_views.dart';
import 'package:ojps_flutter/constants/colors.dart';
import 'package:ojps_flutter/constants/text_styles.dart';
import '../widgets/custom_bottom_nav.dart';

class JobStatusScreen extends StatefulWidget {
  const JobStatusScreen({super.key});

  @override
  State<JobStatusScreen> createState() => _JobStatusScreenState();
}

class _JobStatusScreenState extends State<JobStatusScreen> {
  int _currentIndex = AppValues.jobStatusInitialIndex;

  void _onTap(int index) {
    if (index == _currentIndex) return;

    if (index == 0) {
      Navigator.pushReplacementNamed(context, '/home');
    } else if (index == 1) {
      Navigator.pushReplacementNamed(context, '/saved_jobs');
    } else if (index == 2) {
      // add if needed
    } else if (index == 3) {
      // add if needed
    } else if (index == 4) {
      // add if needed
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.pushReplacementNamed(context, '/home');
        return false; // prevent default pop
      },
      child: DefaultTabController(
        length: AppValues.jobStatusTabCount,
        child: Scaffold(
          backgroundColor: whiteColor,
          appBar: AppBar(
            title: const Text(
              AppValues.jobStatusScreenTitle,
              style: TextStyle(fontWeight: AppValues.appBarTitleFontWeight),
            ),
            backgroundColor: primaryColor,
            centerTitle: AppValues.appBarCenterTitle,
            bottom: const JobTabBar(),
            elevation: 4,
            shadowColor: primaryTextColor,
          ),
          body: const JobTabViews(),
          bottomNavigationBar: CustomBottomNavBar(
            currentIndex: _currentIndex,
            onTap: _onTap,
          ),
        ),
      ),
    );
  }
}
