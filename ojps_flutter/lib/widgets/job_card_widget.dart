import 'package:flutter/material.dart';
import 'package:ojps_flutter/constants/colors.dart';

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
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.all(14),
        margin: const EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
          color: isSaved ? lightBlueBackgroundColor : cardBackgroundColor,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: isSaved ? primaryColor : lightBlueBackgroundColor),
          boxShadow: [
            BoxShadow(
              color: isSaved ? primaryColor.withOpacity(0.3) : primaryColor.withOpacity(0.15),
              blurRadius: 10,
              spreadRadius: 1,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(
              backgroundImage: AssetImage(image),
              radius: 26,
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15.5,
                      color: primaryTextColor,
                    ),
                  ),
                  const SizedBox(height: 4),

                  Text(
                    location,
                    style: const TextStyle(
                      fontSize: 13,
                      color: secondaryTextColor,
                    ),
                  ),
                  const SizedBox(height: 3),

                  Text(
                    type,
                    style: const TextStyle(
                      fontSize: 12.5,
                      color: secondaryTextColor,
                      fontStyle: FontStyle.italic,
                    ),
                  ),

                  if (description != null || salary != null) ...[
                    const SizedBox(height: 6),
                    if (description != null)
                      Text(
                        description!,
                        style: const TextStyle(
                          fontSize: 12,
                          color: secondaryTextColor,
                        ),
                      ),
                    if (salary != null)
                      Padding(
                        padding: const EdgeInsets.only(top: 2),
                        child: Text(
                          salary!,
                          style: const TextStyle(
                            fontSize: 12,
                            color: primaryColor,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                  ],

                  if (statusLabel != null && statusColor != null)
                    Container(
                      margin: const EdgeInsets.only(top: 6),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: statusColor!.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          if (statusIcon != null)
                            Icon(
                              statusIcon,
                              size: 14,
                              color: statusColor,
                            ),
                          if (statusIcon != null)
                            const SizedBox(width: 4),
                          Text(
                            statusLabel!,
                            style: TextStyle(
                              fontSize: 11.5,
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
                  size: 22,
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
