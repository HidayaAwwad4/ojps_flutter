import 'package:flutter/material.dart';
import 'package:ojps_flutter/widgets/saved_jobs_widget.dart';
import 'package:ojps_flutter/constants/colors.dart';
import '../widgets/custom_bottom_nav.dart';

class SavedJobsScreen extends StatefulWidget {
  const SavedJobsScreen({super.key});

  @override
  State<SavedJobsScreen> createState() => _SavedJobsScreenState();
}

class _SavedJobsScreenState extends State<SavedJobsScreen> {
  int _currentIndex = 1;

  void _onTap(int index) {
    if (index == _currentIndex) return;
    if (index == 0) {
      Navigator.pushReplacementNamed(context, '/home');
    } else if (index == 1) {
    } else if (index == 2) {
    } else if (index == 3) {
      Navigator.pushReplacementNamed(context, '/status');
    } else if (index == 4) {
    }
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        title: const Text('Saved Jobs'),
        centerTitle: true,
        backgroundColor: primaryColor,
      ),
      body: const Padding(
        padding: EdgeInsets.all(16.0),
        child: SavedJobsWidget(),
      ),
      bottomNavigationBar: CustomBottomNavBar(
        currentIndex: _currentIndex,
        onTap: _onTap,
      ),
    );
  }
}
