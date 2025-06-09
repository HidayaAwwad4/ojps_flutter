import 'package:flutter/material.dart';
import 'package:ojps_flutter/constants/colors.dart';
import 'package:ojps_flutter/constants/text_styles.dart';

import '../screens/notifications.dart';

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
      if (index == 2) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const Notifications()),
        );
      } else if (index == 3) {
          Navigator.pushNamed(context, '/job_status');
        } else {
          onTap(index);
        }
      },
      type: BottomNavigationBarType.fixed,
      backgroundColor: Colorss.whiteColor,
      selectedItemColor: Colorss.primaryColor,
      unselectedItemColor: Colorss.secondaryTextColor,
      selectedLabelStyle: const TextStyle(fontWeight: FontWeight.normal),
      items: [
        BottomNavigationBarItem(
          icon: Icon(
            currentIndex == 0 ? Icons.home : Icons.home_outlined,
            color: currentIndex == 0 ? Colorss.primaryColor : Colorss.secondaryTextColor,
            size: AppValues.bottomNavIconSize,
          ),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(
            currentIndex == 1 ? Icons.bookmark : Icons.bookmark_border,
            color: currentIndex == 1 ? Colorss.primaryColor : Colorss.secondaryTextColor,
            size: AppValues.bottomNavIconSize,
          ),
          label: 'Save',
        ),
        BottomNavigationBarItem(
          icon: Icon(
            currentIndex == 2 ? Icons.notifications : Icons.notifications_none,
            color: currentIndex == 2 ? Colorss.primaryColor : Colorss.secondaryTextColor,
            size: AppValues.bottomNavIconSize,
          ),
          label: 'Notification',
        ),
        BottomNavigationBarItem(
          icon: Icon(
            currentIndex == 3 ? Icons.work : Icons.work_outline,
            color: currentIndex == 3 ? Colorss.primaryColor : Colorss.secondaryTextColor,
            size: AppValues.bottomNavIconSize,
          ),
          label: 'Status',
        ),
        BottomNavigationBarItem(
          icon: Icon(
            currentIndex == 4 ? Icons.person : Icons.person_outline,
            color: currentIndex == 4 ? Colorss.primaryColor : Colorss.secondaryTextColor,
            size: AppValues.bottomNavIconSize,
          ),
          label: 'Profile',
        ),
      ],
    );
  }
}