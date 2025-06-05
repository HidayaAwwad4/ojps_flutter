import 'package:flutter/material.dart';
import 'package:ojps_flutter/widgets/saved_jobs_widget.dart';
import 'package:ojps_flutter/constants/colors.dart';
import 'package:ojps_flutter/constants/text_styles.dart';
import '../widgets/custom_bottom_nav.dart';

class SavedJobsScreen extends StatefulWidget {
  const SavedJobsScreen({super.key});

  @override
  State<SavedJobsScreen> createState() => _SavedJobsScreenState();
}

class _SavedJobsScreenState extends State<SavedJobsScreen> {
  int _currentIndex = AppValues.savedJobsInitialIndex;

  void _onTap(int index) {
    if (index == _currentIndex) return;
    if (index == 0) {
      Navigator.pushReplacementNamed(context, '/home');
    } else if (index == 1) {
      // no action needed (current screen)
    } else if (index == 2) {
      // إضافة الأكشن المناسب هنا عند الحاجة
    } else if (index == 3) {
      Navigator.pushReplacementNamed(context, '/status');
    } else if (index == 4) {
      // إضافة الأكشن المناسب هنا عند الحاجة
    }
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colorss.whiteColor,
      appBar: AppBar(
        title: const Text(AppValues.savedJobsScreenTitle),
        centerTitle: AppValues.appBarCenterTitle,
        backgroundColor: Colorss.primaryColor,
      ),
      body: const Padding(
        padding: EdgeInsets.all(AppValues.savedJobsPadding),
        child: SavedJobsWidget(),
      ),
      bottomNavigationBar: CustomBottomNavBar(
        currentIndex: _currentIndex,
        onTap: _onTap,
      ),
    );
  }
}