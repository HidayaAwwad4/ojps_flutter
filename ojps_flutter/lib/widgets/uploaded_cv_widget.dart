import 'package:flutter/material.dart';
import 'package:ojps_flutter/constants/colors.dart';


class UploadedCvWidget extends StatelessWidget {
  const UploadedCvWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
      },
      borderRadius: BorderRadius.circular(10),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          border: Border.all(color: primaryColor),
          borderRadius: BorderRadius.circular(10),
          color: whiteColor,
          boxShadow: [
            BoxShadow(
              color: primaryColor.withOpacity(0.1),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: const [
            Text("cv_razan.pdf"),
            Icon(Icons.edit, color: primaryColor),
          ],
        ),
      ),
    );
  }
}
