import 'package:flutter/material.dart';
import '../widgets/search_bar_widget.dart';
import '../widgets/categories_widget.dart';
import '../widgets/recommended_jobs_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 10),

                // Row with name, location and profile picture
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text(
                          "Hello Razan",
                          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          "Palestine, Qalqilya",
                          style: TextStyle(
                            fontSize: 14,
                            color: Color(0xFF656464), // لون سكني
                          ),
                        ),
                      ],
                    ),
                    const CircleAvatar(
                      radius: 20,
                      backgroundImage: AssetImage('lib/assets/profile_picture.jpg'),
                    ),
                  ],
                ),

                const SizedBox(height: 10),
                const SearchBarWidget(),
                const SizedBox(height: 20),
                const CategoriesWidget(),
                const SizedBox(height: 20),
                const Text(
                  "Recommended Jobs",
                  style: TextStyle(fontSize: 18),
                ),
                const SizedBox(height: 10),
                const RecommendedJobsWidget(),
              ],
            ),
          ),
        ),
      ),

      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.bookmark), label: 'Save'),
          BottomNavigationBarItem(icon: Icon(Icons.notifications), label: 'Notification'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
    );
  }
}
