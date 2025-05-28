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
          vertical: Dimensions.dimentions.height5,
          horizontal: Dimensions.dimentions.width10,
        ),
        padding: EdgeInsets.all(Dimensions.dimentions.height10),
        decoration: BoxDecoration(
          color: isNew ? Colorss.primaryColor : Colors.white,
          border: Border.all(color: Colorss.primaryColor),
          borderRadius: BorderRadius.circular(Dimensions.dimentions.radius50),
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
              radius: Dimensions.dimentions.height20,
            ),
            SizedBox(width: Dimensions.dimentions.width10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title,
                      style: isNew
                          ? texttStyles.textStyleWhiteBold
                          : texttStyles.textStylePrimaryBold),
                  SizedBox(height: Dimensions.dimentions.height5),
                  Text(subtitle,
                      style: isNew
                          ? texttStyles.textStyleWhite
                          : texttStyles.textStyleSmallGrey),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
