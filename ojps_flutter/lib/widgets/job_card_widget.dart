import 'package:flutter/material.dart';
import 'package:ojps_flutter/constants/colors.dart';
import 'package:ojps_flutter/constants/text_styles.dart';

class JobCard extends StatelessWidget {
  final String image;
  final String title;
  final String location;
  final String type;
  final VoidCallback onTap;

  final String? description;
  final String? salary;
  final bool isSaved;
  final VoidCallback? onSaveToggle;
  final String? statusLabel;
  final Color? statusColor;
  final IconData? statusIcon;

  const JobCard({
    super.key,
    required this.image,
    required this.title,
    required this.location,
    required this.type,
    required this.onTap,
    this.description,
    this.salary,
    this.isSaved = false,
    this.onSaveToggle,
    this.statusLabel,
    this.statusColor,
    this.statusIcon,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(AppValues.cardRadius),
      child: Container(
        padding: const EdgeInsets.all(AppValues.cardPadding),
        margin: const EdgeInsets.symmetric(vertical: AppValues.cardVerticalMargin),
        decoration: BoxDecoration(
          color: isSaved ? lightBlueBackgroundColor : cardBackgroundColor,
          borderRadius: BorderRadius.circular(AppValues.cardRadius),
          border: Border.all(color: isSaved ? primaryColor : lightBlueBackgroundColor),
          boxShadow: [
            BoxShadow(
              color: isSaved
                  ? primaryColor.withOpacity(AppValues.shadowOpacitySaved)
                  : primaryColor.withOpacity(AppValues.shadowOpacityLight),
              blurRadius: AppValues.cardShadowBlur,
              spreadRadius: AppValues.cardShadowSpread,
              offset: const Offset(0, AppValues.shadowOffsetY),
            ),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(
              backgroundImage: AssetImage(image),
              radius: AppValues.avatarRadius,
            ),
            const SizedBox(width: AppValues.cardSpacing),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: AppValues.fontTitle,
                      color: primaryTextColor,
                    ),
                  ),
                  const SizedBox(height: AppValues.extraSmallSpacing),
                  Text(
                    location,
                    style: const TextStyle(
                      fontSize: AppValues.fontLocation,
                      color: secondaryTextColor,
                    ),
                  ),
                  const SizedBox(height: AppValues.tinySpacing),
                  Text(
                    type,
                    style: const TextStyle(
                      fontSize: AppValues.fontType,
                      color: secondaryTextColor,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                  if (description != null || salary != null) ...[
                    const SizedBox(height: AppValues.smallSpacing),
                    if (description != null)
                      Text(
                        description!,
                        style: const TextStyle(
                          fontSize: AppValues.fontDescription,
                          color: secondaryTextColor,
                        ),
                      ),
                    if (salary != null)
                      Padding(
                        padding: const EdgeInsets.only(top: AppValues.tinySpacing),
                        child: Text(
                          salary!,
                          style: const TextStyle(
                            fontSize: AppValues.fontSalary,
                            color: primaryColor,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                  ],
                  if (statusLabel != null && statusColor != null)
                    Container(
                      margin: const EdgeInsets.only(top: AppValues.smallSpacing),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: statusColor!.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(AppValues.statusRadius),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          if (statusIcon != null)
                            Icon(
                              statusIcon,
                              size: AppValues.iconSizeStatus,
                              color: statusColor,
                            ),
                          if (statusIcon != null)
                            const SizedBox(width: AppValues.extraSmallSpacing),
                          Text(
                            statusLabel!,
                            style: TextStyle(
                              fontSize: AppValues.fontStatus,
                              color: statusColor,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                ],
              ),
            ),
            if (onSaveToggle != null)
              IconButton(
                icon: Icon(
                  isSaved ? Icons.bookmark : Icons.bookmark_border,
                  color: primaryColor,
                  size: AppValues.iconSizeBookmark,
                ),
                onPressed: onSaveToggle,
                tooltip: isSaved ? 'save' : 'save_job',
              ),
          ],
        ),
      ),
    );
  }
}

