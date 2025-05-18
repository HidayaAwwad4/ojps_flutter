import 'package:flutter/material.dart';
import 'package:ojps_flutter/constants/colors.dart';

class JobTabBar extends StatelessWidget implements PreferredSizeWidget {
  const JobTabBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: primaryColor,
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(12)),
        boxShadow: [
          BoxShadow(
            color: primaryTextColor,
            blurRadius: 6,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: TabBar(
        isScrollable: false,
        indicator: BoxDecoration(
          color: whiteColor,
          borderRadius: BorderRadius.circular(12),
        ),
        labelColor: primaryColor,
        unselectedLabelColor: whiteColor,
        labelPadding: EdgeInsets.zero,
        labelStyle: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 14,
          letterSpacing: 0.3,
        ),
        unselectedLabelStyle: const TextStyle(
          fontWeight: FontWeight.normal,
          fontSize: 14,
        ),
        tabs: const [
          Tab(child: Center(child: Text('Under Review'))),
          Tab(child: Center(child: Text('Accepted'))),
          Tab(child: Center(child: Text('Rejected'))),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
