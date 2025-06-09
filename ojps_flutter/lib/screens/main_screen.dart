import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:ojps_flutter/screens/view_edit_employer_profile.dart';

import '../constants/colors.dart';
import 'create_job_screen.dart';
import 'employer_home.dart';
import 'job_posting_screen.dart';
import 'notifications.dart';

class MainScreen extends StatefulWidget {
  final int initialIndex;
  const MainScreen({super.key, this.initialIndex = 0});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;

  final List<Widget> _screens = const [
    EmployerHome(),
    JobPostingScreen(tabIndex: 0),
    Scaffold(body: Center(child: Text(''))),
    Notifications(),
    ViewEditEmployerProfile(),
  ];

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.initialIndex;
  }

  void _openCreateJobScreen() async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CreateJobScreen(),
        fullscreenDialog: true,
      ),
    );

    setState(() {
      _currentIndex = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_currentIndex],
      bottomNavigationBar: CupertinoTabBar(
        currentIndex: _currentIndex,
        activeColor: Colorss.primaryColor,
        inactiveColor: Colorss.blackColor,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });

          if (index == 2) {
            _openCreateJobScreen();
          }
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(_currentIndex == 0 ? Icons.home : Icons.home_outlined),
            label: tr('home'),
          ),
          BottomNavigationBarItem(
            icon: Icon(_currentIndex == 1 ? Icons.work : Icons.work_outline),
            label: tr('jobs'),
          ),
          BottomNavigationBarItem(
            icon: Icon(_currentIndex == 2 ? Icons.add_circle : Icons.add_circle_outline),
            label: tr('post'),
          ),
          BottomNavigationBarItem(
            icon: Icon(_currentIndex == 3 ? Icons.notifications : Icons.notifications_none),
            label: tr('notification'),
          ),
          BottomNavigationBarItem(
            icon: Icon(_currentIndex == 4 ? Icons.person : Icons.person_outline),
            label: tr('profile'),
          ),
        ],
      ),
    );
  }
}
