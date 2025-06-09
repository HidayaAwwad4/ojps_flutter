import 'package:flutter/material.dart';
import 'package:ojps_flutter/constants//colors.dart';
import 'package:ojps_flutter/constants//text_styles.dart';
import '../constants/dimensions.dart' as Dimensions;
import '../constants/spaces.dart';

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
          vertical: Dimensions.AppDimensions.height5,
          horizontal: Dimensions.AppDimensions.width10,
        ),
        padding: EdgeInsets.all(Dimensions.AppDimensions.height10),
        decoration: BoxDecoration(
          color: isNew ? Colorss.primaryColor : Colors.white,
          border: Border.all(color: Colorss.primaryColor),
          borderRadius: BorderRadius.circular(Dimensions.AppDimensions.radius50),
          boxShadow: [
            BoxShadow(
              color: Colorss.primaryColor,
              spreadRadius: 0.1,
              blurRadius: 3,
              offset: const Offset(1,2),
            )
          ]
        ),
        child: Row(
          children: [
            CircleAvatar(
              backgroundImage: AssetImage(imageUrl),
              radius: Dimensions.AppDimensions.height20,
            ),
            Spaces.horizontal(Dimensions.AppDimensions.width10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title,
                      style: isNew
                          ? AppValues.textStyleWhiteBold
                          : AppValues.textStylePrimaryBold),
                  Spaces.vertical(Dimensions.AppDimensions.height5),
                  Text(subtitle,
                      style: isNew
                          ? AppValues.textStyleWhite
                          : AppValues.textStyleSmallGrey),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}