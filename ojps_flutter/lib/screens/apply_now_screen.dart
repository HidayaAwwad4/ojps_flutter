import 'package:flutter/material.dart';
import 'package:ojps_flutter/constants/colors.dart';
import '../widgets/uploaded_cv_widget.dart';
import '../widgets/cover_letter_field.dart';
import '../widgets/submit_button.dart';

class ApplyNow extends StatelessWidget {
  const ApplyNow({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        backgroundColor: whiteColor,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          "Apply Now",
          style: TextStyle(
            color: secondaryTextColor,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: secondaryTextColor),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TweenAnimationBuilder<double>(
                tween: Tween(begin: 0, end: 1),
                duration: const Duration(milliseconds: 600),
                child: const Text(
                  "Great work so far!",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                builder: (context, value, child) => Opacity(
                  opacity: value,
                  child: Transform.translate(
                    offset: Offset(0, (1 - value) * 20),
                    child: child,
                  ),
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
              const SizedBox(height: 24),
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
              const SizedBox(height: 30),
              const SubmitButton(),
            ],
          ),
        ),
      ),
    );
  }
}
