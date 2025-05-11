import 'package:flutter/material.dart';

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
      onTap: onTap,
      type: BottomNavigationBarType.fixed,
      backgroundColor: Colors.white,
      selectedItemColor: const Color(0xFF0273B1),
      unselectedItemColor: Colors.black,
      selectedLabelStyle: const TextStyle(fontWeight: FontWeight.normal),
      items: [
        BottomNavigationBarItem(
          icon: Icon(
            Icons.home,
            color: currentIndex == 0 ? const Color(0xFF0273B1) : Colors.black,
            size:  25,
          ),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.bookmark_border,
            color: currentIndex == 1 ? const Color(0xFF0273B1) : Colors.black,
            size:  25,
          ),
          label: 'Save',
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.notifications_none,
            color: currentIndex == 2 ? const Color(0xFF0273B1) : Colors.black,
            size:  25,
          ),
          label: 'Notification',
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.person_outline,
            color: currentIndex == 3 ? const Color(0xFF0273B1) : Colors.black,
            size: 25,
          ),
          label: 'Profile',
        ),
      ],
    );
  }
}
