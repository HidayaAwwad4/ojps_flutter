import 'package:flutter/material.dart';
import 'package:ojps_flutter/constants/colors.dart';
import 'package:ojps_flutter/widgets/job_card_widget.dart';
import 'package:ojps_flutter/screens/job_details_job_seeker_screen.dart';

class JobListScreen extends StatelessWidget {
  final String categoryLabel;

  const JobListScreen({super.key, required this.categoryLabel});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
              child: Row(
                children: [
                  InkWell(
                    onTap: () => Navigator.pop(context),
                    child: Icon(
                      Icons.arrow_back,
                      color: primaryTextColor,
                      size: 28,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      categoryLabel,
                      style: TextStyle(
                        fontSize: MediaQuery.of(context).size.width * 0.06,
                        fontWeight: FontWeight.bold,
                        color: primaryTextColor,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Elevate your career with exclusive web\ndevelopment opportunities!',
                  style: TextStyle(
                    fontSize: MediaQuery.of(context).size.width * 0.04,
                    color: secondaryTextColor,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 8),
            Expanded(
              child: ListView.builder(
                itemCount: 10,
                itemBuilder: (context, index) {
                  return JobCard(
                    title: 'Full-Stack Developer',
                    location: 'Nablus-Rafidia',
                    type: 'Full-Time',
                    logoPath: 'assets/adham.jpg',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => JobDetailsJobSeekerScreen(),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
