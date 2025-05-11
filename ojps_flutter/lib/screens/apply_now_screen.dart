import 'package:flutter/material.dart';
import '../widgets/uploaded_cv_widget.dart';
import '../widgets/cover_letter_field.dart';
import '../widgets/submit_button.dart';
import '../widgets/custom_bottom_nav.dart';
import 'package:ojps_flutter/constants/colors.dart';
class ApplyNow extends StatelessWidget {
  const ApplyNow({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Great work so far!",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: secondaryTextColor,
                ),
              ),
              const SizedBox(height: 12),
              const Text(
                "Please review your CV and make sure it's up to date.",
                style: TextStyle(
                  fontSize: 14,
                  height: 1.5,
                  color: secondaryTextColor,
                ),
              ),
              const SizedBox(height: 10),
              const UploadedCvWidget(),
              const SizedBox(height: 20),
              const Text(
                "A short cover letter helps show your interest and skills.",
                style: TextStyle(
                  fontSize: 14,
                  height: 1.5,
                  color: secondaryTextColor,
                ),
              ),
              const SizedBox(height: 10),
              const CoverLetterField(),
              const SizedBox(height: 20),
              const SubmitButton(),
            ],
          ),
        ),
      ),
      bottomNavigationBar: CustomBottomNavBar(
        currentIndex: 0,
        onTap: (index) {
          if (index == 0) {
            Navigator.pushNamed(context, '/home');
          } else if (index == 1) {
            Navigator.pushNamed(context, '/saved');
          } else if (index == 2) {
            Navigator.pushNamed(context, '/notifications');
          } else if (index == 3) {
            Navigator.pushNamed(context, '/profile');
          }
        },
      ),
    );
  }
}

