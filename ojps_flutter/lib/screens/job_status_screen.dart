import 'package:flutter/material.dart';
import '../widgets/job_tab_bar.dart';
import '../widgets/job_tab_views.dart';
import 'package:ojps_flutter/constants/colors.dart';
import '../widgets/custom_bottom_nav.dart';


class JobStatusScreen extends StatefulWidget {
  const JobStatusScreen({super.key});

  @override
  State<JobStatusScreen> createState() => _JobStatusScreenState();
}

class _JobStatusScreenState extends State<JobStatusScreen> {
  int _currentIndex = 3;

  void _onTap(int index) {
    if (index == _currentIndex) return;

    if (index == 0) {
      Navigator.pushReplacementNamed(context, '/home');
    } else if (index == 1) {
      Navigator.pushReplacementNamed(context, '/saved_jobs');
    } else if (index == 2) {
    } else if (index == 3) {
    } else if (index == 4) {
    }
  }


  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: whiteColor,
        appBar: AppBar(
          title: const Text(
            'Job Status',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          backgroundColor: primaryColor,
          centerTitle: true,
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
    );
  }
}
