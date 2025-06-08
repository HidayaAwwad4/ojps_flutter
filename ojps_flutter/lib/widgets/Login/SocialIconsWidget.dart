import 'package:flutter/material.dart';
import 'package:social_media_buttons/social_media_buttons.dart';
import 'package:ojps_flutter/constants/colors.dart';
import 'package:ojps_flutter/constants/dimensions.dart';

class SocialIconsWidget extends StatelessWidget {
  const SocialIconsWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(AppDimensions.defaultPadding),
      child: Column(
        children: [
          Text(
            "Or sign in with",
            style: TextStyle(color: Colorss.secondaryTextColor),
          ),
          SizedBox(height: AppDimensions.verticalSpacerSmall),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SocialMediaButton.google(
                url: "https://google.com",
                color: Colors.red,
                size: AppDimensions.socialIconSize,
              ),
              SizedBox(width: AppDimensions.horizontalSpacerMedium),
              SocialMediaButton.linkedin(
                url: "https://linkedin.com",
                color: Colors.blue,
                size: AppDimensions.socialIconSize,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
