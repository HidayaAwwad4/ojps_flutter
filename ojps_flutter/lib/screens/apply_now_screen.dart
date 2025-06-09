import 'package:flutter/material.dart';
import 'package:ojps_flutter/constants/colors.dart';
import 'package:ojps_flutter/constants/text_styles.dart';
 import 'package:ojps_flutter/widgets/cover_letter_field.dart';
import 'package:ojps_flutter/widgets/submit_button.dart';
import 'package:ojps_flutter/widgets/uploaded_cv_widget.dart';

class ApplyNow extends StatelessWidget {
  const ApplyNow({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colorss.whiteColor,
      appBar: AppBar(
        backgroundColor: Colorss.primaryColor,
        elevation: 4,
        centerTitle: true,
        title: const Text(
          "Apply Now",
          style: TextStyle(
            color: Colorss.whiteColor,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colorss.whiteColor),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(AppValues.defaultPadding),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TweenAnimationBuilder<double>(
                tween: Tween(begin: 0, end: 1),
                duration: AppValues.tweenAnimationDuration,
                child: const Text(
                  "Great work so far!",
                  style: TextStyle(
                    fontSize: AppValues.titleFontSize,
                    fontWeight: FontWeight.bold,
                    color: Colorss.primaryColor,
                  ),
                ),
                builder: (context, value, child) => Opacity(
                  opacity: value,
                  child: Transform.translate(
                    offset: Offset(0, (1 - value) * AppValues.tweenTranslateOffset),
                    child: child,
                  ),
                ),
              ),
              const SizedBox(height: AppValues.smallVerticalSpace),
              const Text(
                "Please review your CV and make sure it's up to date.",
                style: TextStyle(
                  fontSize: AppValues.bodyFontSize,
                  height: 1.5,
                  color: Colorss.secondaryTextColor,
                ),
              ),
              const SizedBox(height: AppValues.verticalSpaceAfterText),
              const UploadedCvWidget(),
              const SizedBox(height: AppValues.largeVerticalSpace),
              const Text(
                "A short cover letter helps show your interest and skills.",
                style: TextStyle(
                  fontSize: AppValues.bodyFontSize,
                  height: 1.5,
                  color: Colorss.secondaryTextColor,
                ),
              ),
              const SizedBox(height: AppValues.verticalSpaceAfterText),
              const CoverLetterField(),
              const SizedBox(height: AppValues.extraLargeVerticalSpace),
              const SubmitButton(),
            ],
          ),
        ),
      ),
    );
  }
}
