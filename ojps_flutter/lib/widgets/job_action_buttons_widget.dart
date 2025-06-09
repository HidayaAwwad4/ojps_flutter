import 'package:flutter/material.dart';
import 'package:ojps_flutter/constants/colors.dart';
import 'package:ojps_flutter/constants/text_styles.dart';
import 'package:ojps_flutter/screens/apply_now_screen.dart';

class JobActionButtonsWidget extends StatelessWidget {
  const JobActionButtonsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppValues.horizontalPadding),
      child: Column(
        children: [
          Tooltip(
            message: 'View required job documents',
            child: ElevatedButton.icon(
              onPressed: () {},
              icon: Icon(Icons.description, color: Colorss.primaryTextColor),
              label: const Text("Documents"),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colorss.cardBackgroundColor,
                foregroundColor: Colorss.primaryTextColor,
                minimumSize: const Size(double.infinity, AppValues.buttonHeight),
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(AppValues.borderRadiusButton),
                  side: const BorderSide(color: Colorss.primaryColor),
                ),
              ),
            ),
          ),
          const SizedBox(height: AppValues.jobActionButtonsSpacing),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const ApplyNow(),
                ),
              );
            },
            child: const Text("Apply Now"),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colorss.primaryColor,
              foregroundColor: Colorss.whiteColor,
              minimumSize: const Size(double.infinity, AppValues.buttonHeight),
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(AppValues.borderRadiusButton),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

