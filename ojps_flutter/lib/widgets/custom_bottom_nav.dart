import 'package:flutter/material.dart';
import 'package:ojps_flutter/constants/colors.dart';

class CustomBottomNavBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const CustomBottomNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: (index) {
        if (index == 3) {
          Navigator.pushNamed(context, '/job_status');
        } else {
          onTap(index);
        }
      },
      type: BottomNavigationBarType.fixed,
      backgroundColor: whiteColor,
      selectedItemColor: primaryColor,
      unselectedItemColor: secondaryTextColor,
      selectedLabelStyle: const TextStyle(fontWeight: FontWeight.normal),
      items: [
        BottomNavigationBarItem(
          icon: Icon(
            Icons.home,
            color: currentIndex == 0 ? primaryColor : secondaryTextColor,
            size: 25,
          ),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.bookmark_border,
            color: currentIndex == 1 ? primaryColor : secondaryTextColor,
            size: 25,
          ),
          label: 'Save',
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.notifications_none,
            color: currentIndex == 2 ? primaryColor : secondaryTextColor,
            size: 25,
          ),
          label: 'Notification',
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.work_outline,
            color: currentIndex == 3 ? primaryColor : secondaryTextColor,
            size: 25,
          ),
          label: 'Status',
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.person_outline,
            color: currentIndex == 4 ? primaryColor : secondaryTextColor,
            size: 25,
          ),
          label: 'Profile',
        ),
      ],
    );
  }
}


