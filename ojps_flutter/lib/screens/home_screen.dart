import 'package:flutter/material.dart';
import '../widgets/search_bar_widget.dart';
import '../widgets/categories_widget.dart';
import '../widgets/recommended_jobs_widget.dart';
import 'package:ojps_flutter/constants/colors.dart';
import 'package:ojps_flutter/constants/text_styles.dart';
import '../widgets/custom_bottom_nav.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  void _onTap(int index) {
    if (index == 1) {
      Navigator.pushNamed(context, '/saved_jobs');
    } else if (index == 3) {
      Navigator.pushNamed(context, '/job_status');
    } else {
      setState(() {
        _currentIndex = index;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppValues.horizontalPadding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: AppValues.smallVerticalSpace),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Hello Razan",
                          style: TextStyle(
                            fontSize: AppValues.mainTitleFontSize,
                            fontWeight: FontWeight.bold,
                            color: primaryTextColor,
                          ),
                        ),
                        Text(
                          "Palestine, Qalqilya",
                          style: TextStyle(
                            fontSize: AppValues.secondaryTextFontSize,
                            color: secondaryTextColor,
                          ),
                        ),
                      ],
                    ),
                    const CircleAvatar(
                      radius: AppValues.profileAvatarRadius,
                      backgroundImage: AssetImage('assets/profile_picture.jpg'),
                    ),
                  ],
                ),
                const SizedBox(height: AppValues.smallVerticalSpace),
                const SearchBarWidget(),
                const SizedBox(height: AppValues.largeVerticalSpace),
                Text(
                  "Categories",
                  style: TextStyle(
                    fontSize: AppValues.sectionTitleFontSize,
                    color: primaryTextColor,
                  ),
                ),
                const SizedBox(height: AppValues.smallVerticalSpace),
                const CategoriesWidget(),

                const SizedBox(height: AppValues.largeVerticalSpace),
                Text(
                  "Recommended Jobs",
                  style: TextStyle(
                    fontSize: AppValues.sectionTitleFontSize,
                    color: primaryTextColor,
                  ),
                ),
                const SizedBox(height: AppValues.smallVerticalSpace),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 4),
                  child: RecommendedJobsWidget(),
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: CustomBottomNavBar(
        currentIndex: _currentIndex,
        onTap: _onTap,
      ),
    );
  }
}