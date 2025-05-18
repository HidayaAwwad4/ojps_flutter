import 'package:flutter/material.dart';
import '../widgets/search_bar_widget.dart';
import '../widgets/categories_widget.dart';
import '../widgets/recommended_jobs_widget.dart';
import 'package:ojps_flutter/constants/colors.dart';
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
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Hello Razan",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: primaryTextColor,
                          ),
                        ),
                        Text(
                          "Palestine, Qalqilya",
                          style: TextStyle(
                            fontSize: 14,
                            color: secondaryTextColor,
                          ),
                        ),
                      ],
                    ),
                    const CircleAvatar(
                      radius: 20,
                      backgroundImage: AssetImage('assets/profile_picture.jpg'),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                const SearchBarWidget(),
                const SizedBox(height: 20),
                Text(
                  "Categories",
                  style: TextStyle(
                    fontSize: 18,
                    color: primaryTextColor,
                  ),
                ),
                const SizedBox(height: 10),
                const CategoriesWidget(),

                const SizedBox(height: 20),
                Text(
                  "Recommended Jobs",
                  style: TextStyle(
                    fontSize: 18,
                    color: primaryTextColor,
                  ),
                ),
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                  child: const RecommendedJobsWidget(),
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

