import 'package:flutter/material.dart';
import 'package:ojps_flutter/constants/colors.dart';
import 'package:ojps_flutter/constants/text_styles.dart';
import 'package:ojps_flutter/widgets/job_card_widget.dart';

class JobListScreen extends StatefulWidget {
  final String categoryLabel;

  const JobListScreen({super.key, required this.categoryLabel});

  @override
  State<JobListScreen> createState() => _JobListScreenState();
}

class _JobListScreenState extends State<JobListScreen> {
  List<bool> savedJobs = List<bool>.filled(10, false);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppValues.horizontalPadding,
                vertical: AppValues.topRowVerticalPadding,
              ),
              child: Row(
                children: [
                  InkWell(
                    onTap: () => Navigator.pop(context),
                    child: Icon(
                      Icons.arrow_back,
                      color: primaryTextColor,
                      size: AppValues.backIconSize,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      widget.categoryLabel,
                      style: TextStyle(
                        fontSize: MediaQuery.of(context).size.width * AppValues.categoryFontSizeRatio,
                        fontWeight: AppValues.categoryFontWeight,
                        color: primaryTextColor,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppValues.horizontalPadding),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Elevate your career with exclusive web\ndevelopment opportunities!',
                  style: TextStyle(
                    fontSize: MediaQuery.of(context).size.width * AppValues.descriptionFontSizeRatio,
                    color: secondaryTextColor,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 8),
            Expanded(
              child: ListView.builder(
                itemCount: savedJobs.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppValues.horizontalPadding,
                      vertical: AppValues.jobCardVerticalPadding,
                    ),
                    child: JobCard(
                      image: 'assets/adham.jpg',
                      title: 'Full-Stack Developer',
                      location: 'Nablus-Rafidia',
                      type: 'Full-Time',
                      isSaved: savedJobs[index],
                      onSaveToggle: () {
                        setState(() {
                          savedJobs[index] = !savedJobs[index];
                        });
                      },
                      onTap: () {
                        Navigator.pushNamed(context, '/job_details');
                      },
                    ),
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

