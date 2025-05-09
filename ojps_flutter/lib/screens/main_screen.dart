import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'create_job_screen.dart';
import 'employer_home.dart';
import 'job_posting_screen.dart';

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
    CreateJobScreen(),
    // Placeholder widgets for Notification and Profile
    Scaffold(body: Center(child: Text('Notifications'))),
    Scaffold(body: Center(child: Text('Profile'))),
  ];

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.initialIndex;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_currentIndex],
      bottomNavigationBar: CupertinoTabBar(
        currentIndex: _currentIndex,
        activeColor: const Color(0xFF0273B1),
        inactiveColor: Colors.black,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
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
