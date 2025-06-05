import 'package:flutter/material.dart';
import 'package:ojps_flutter/constants/colors.dart';

class JobHeaderWidget extends StatelessWidget {
  const JobHeaderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [
        SizedBox(height: 2),
        CircleAvatar(
          radius: 36,
          backgroundImage: AssetImage('assets/adham.jpg'),
        ),
        SizedBox(height: 12),
        Text(
          "Backend Developer",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: primaryTextColor,
          ),
        ),
        SizedBox(height: 4),
        Text("Adham", style: TextStyle(fontSize: 16, color: primaryTextColor)),
        Text("Rafidia, Nablus", style: TextStyle(fontSize: 14, color: secondaryTextColor)),
        SizedBox(height: 20),
      ],
    );
  }
}
