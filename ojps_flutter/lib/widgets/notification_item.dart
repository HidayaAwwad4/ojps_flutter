import 'package:flutter/material.dart';
import 'package:ojps_flutter/constants//colors.dart';
import 'package:ojps_flutter/constants//text_styles.dart';

import '../constants/dimensions.dart' as Dimensions;

class NotificationItem extends StatelessWidget {
  final String title;
  final String subtitle;
  final String imageUrl;
  final bool isNew;
  final VoidCallback onTap;

  const NotificationItem({
    super.key,
    required this.title,
    required this.subtitle,
    required this.imageUrl,
    required this.isNew,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.symmetric(
          vertical: Dimensions.height5,
          horizontal: Dimensions.width10,
        ),
        padding: EdgeInsets.all(Dimensions.height10),
        decoration: BoxDecoration(
          color: isNew ? primaryColor : Colors.white,
          border: Border.all(color: primaryColor),
          borderRadius: BorderRadius.circular(Dimensions.radius20),
        ),
        child: Row(
          children: [
            CircleAvatar(
              backgroundImage: AssetImage(imageUrl),
              radius: Dimensions.height20,
            ),
            SizedBox(width: Dimensions.width10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title,
                      style: isNew
                          ? textStyleWhiteBold
                          : textStylePrimaryBold),
                  SizedBox(height: Dimensions.height5),
                  Text(subtitle,
                      style: isNew
                          ? textStyleWhite
                          : textStyleSmallGrey),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
