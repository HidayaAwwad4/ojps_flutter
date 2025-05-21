import 'package:flutter/material.dart';
import 'package:ojps_flutter/constants/colors.dart';
import '../widgets/uploaded_cv_widget.dart';
import '../widgets/cover_letter_field.dart';
import '../widgets/submit_button.dart';
import 'package:ojps_flutter/constants/colors.dart';

class ApplyNow extends StatelessWidget {
  const ApplyNow({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        backgroundColor: primaryColor,
        elevation: 4,
        centerTitle: true,
        title: const Text(
          "Apply Now",
          style: TextStyle(
            color: whiteColor,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: whiteColor),
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
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Apply Now',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /*Center(
               child: Image.asset(
                  'assets/job_apply_illustration.png',
                  height: 180,
                ),
              ),*/

              const SizedBox(height: 20),

              const Text(
                "You're almost there ",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                "Please review your details and submit your application confidently.",
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.black54,
                  height: 1.5,
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
              const SizedBox(height: 25),

              Container(
                decoration: BoxDecoration(
                  color: lightBlueBackgroundColor.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: primaryColor, width: 1),
                ),
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Row(
                      children: [
                        Icon(Icons.insert_drive_file, color: primaryColor),
                        SizedBox(width: 8),
                        Text(
                          "Your CV",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 12),
                    UploadedCvWidget(),
                  ],
                ),
              ),

              const SizedBox(height: 30),

              const Text(
                "Cover Letter ",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 10),
              const CoverLetterField(),
              const SizedBox(height: 30),
              const SubmitButton(),
            ],
          ),
        ),
      ),

              const SizedBox(height: 30),
            ],
          ),
        ),
      ),

      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: whiteColor,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, -2),
            )
          ],
        ),
        child: ElevatedButton(
          onPressed: () {
            showDialog(
              context: context,
              builder: (_) => AlertDialog(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: const [
                    Icon(Icons.check_circle, color: Colors.green, size: 50),
                    SizedBox(height: 12),
                    Text(
                      "Application Submitted!",
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 8),
                    Text("We'll notify you once the employer reviews your application."),
                  ],
                ),
              ),
            );
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: primaryColor,
            padding: const EdgeInsets.symmetric(vertical: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          child: const Text(
            "Submit Application",
            style: TextStyle(color: Colors.white, fontSize: 16),
          ),
        ),
      ),

    );
  }
}
