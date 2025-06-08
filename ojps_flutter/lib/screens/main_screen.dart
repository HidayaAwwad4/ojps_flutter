import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
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
        inactiveColor: Colorss.primaryTextColor,
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
            icon: Icon(_currentIndex == 0 ? CupertinoIcons.house_fill : CupertinoIcons.house),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(_currentIndex == 1 ? CupertinoIcons.briefcase_fill : CupertinoIcons.briefcase),
            label: 'Jobs',
          ),
          BottomNavigationBarItem(
            icon: Icon(_currentIndex == 2 ? CupertinoIcons.add_circled_solid : CupertinoIcons.add_circled),
            label: 'Post',
          ),
          BottomNavigationBarItem(
            icon: Icon(_currentIndex == 3 ? CupertinoIcons.bell_fill : CupertinoIcons.bell),
            label: 'Notification',
          ),
          BottomNavigationBarItem(
            icon: Icon(_currentIndex == 4 ? CupertinoIcons.person_fill : CupertinoIcons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}