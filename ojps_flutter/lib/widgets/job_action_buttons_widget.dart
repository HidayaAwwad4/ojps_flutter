import 'package:flutter/material.dart';
import 'package:ojps_flutter/constants/colors.dart';

class JobActionButtonsWidget extends StatelessWidget {
  const JobActionButtonsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        children: [
          Tooltip(
            message: 'View required job documents',
            child: ElevatedButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.description, color: primaryTextColor),
              label: const Text("Documents"),
              style: ElevatedButton.styleFrom(
                backgroundColor: cardBackgroundColor,
                foregroundColor: primaryTextColor,
                minimumSize: const Size(double.infinity, 48),
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                  side: const BorderSide(color: primaryColor),
                ),
              ),
            ),
          ),
          const SizedBox(height: 12),
          ElevatedButton(
            onPressed: () {},
            child: const Text("Apply Now"),
            style: ElevatedButton.styleFrom(
              backgroundColor: primaryColor,
              foregroundColor: whiteColor,
              minimumSize: const Size(double.infinity, 48),
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
