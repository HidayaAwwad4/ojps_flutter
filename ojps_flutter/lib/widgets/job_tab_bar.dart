import 'package:flutter/material.dart';
import 'package:ojps_flutter/constants/colors.dart';
import 'package:ojps_flutter/constants/text_styles.dart';

class JobTabBar extends StatelessWidget implements PreferredSizeWidget {
  const JobTabBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colorss.primaryColor,
        borderRadius: BorderRadius.vertical(
          bottom: Radius.circular(AppValues.tabBarRadius),
        ),
        boxShadow: [
          BoxShadow(
            color: Colorss.primaryTextColor,
            blurRadius: AppValues.tabBarBlurRadius,
            offset: Offset(0, AppValues.tabBarOffsetY),
          ),
        ],
      ),
      child: TabBar(
        isScrollable: false,
        indicator: BoxDecoration(
          color: Colorss.whiteColor,
          borderRadius: BorderRadius.circular(AppValues.tabBarRadius),
        ),
        labelColor: Colorss.primaryColor,
        unselectedLabelColor: Colorss.whiteColor,
        labelPadding: EdgeInsets.zero,
        labelStyle: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: AppValues.tabBarFontSize,
          letterSpacing: AppValues.tabBarLetterSpacing,
        ),
        unselectedLabelStyle: const TextStyle(
          fontWeight: FontWeight.normal,
          fontSize: AppValues.tabBarFontSize,
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