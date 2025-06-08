import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import '../constants/colors.dart';
import '../constants/dimensions.dart';
import '../constants/spaces.dart';
import '../models/job_model.dart';
import '../services/job_service.dart';
import '../utils/network_utils.dart';

class JobCardContent extends StatefulWidget {
  final Job job;
  final Function(Job) onStatusChange;
  final Function(Job)? onJobDeleted;
  final EdgeInsetsGeometry? padding;
  final bool showVerticalLayout;

  const JobCardContent({
    super.key,
    required this.job,
    required this.onStatusChange,
    this.onJobDeleted,
    this.padding,
    this.showVerticalLayout = true,
  });

  @override
  State<JobCardContent> createState() => _JobCardContentState();
}

class _JobCardContentState extends State<JobCardContent> {
  Future<void> _toggleJobStatus(BuildContext context) async {
    bool newStatus = !widget.job.isOpened;
    final updatedData = {'isOpened': newStatus ? 1 : 0};

    try {
      await JobService().updateJob(widget.job.id, updatedData);

      final updatedJob = widget.job.copyWith(isOpened: newStatus);

      widget.onStatusChange(updatedJob);

      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(tr(newStatus ? 'job_opened' : 'job_closed'))),
        );
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(tr('job_status_failed'))),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        try {
          final data = await JobService().getJobById(widget.job.id);
          final jobDetails = Job.fromJson(data);
          if (context.mounted) {
            Navigator.pushNamed(
              context,
              '/employer/job-details',
              arguments: jobDetails,
            );
          }
        } catch (e) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(tr('job_details_failed'))),
          );
        }
      },
      child: Container(
        padding: widget.padding ?? const EdgeInsets.all(AppDimensions.paddingSmall),
        decoration: BoxDecoration(
          color: Colorss.cardBackgroundColor,
          borderRadius: BorderRadius.circular(AppDimensions.borderRadius),
          boxShadow: const [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 4,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: widget.showVerticalLayout
              ? CrossAxisAlignment.center
              : CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.all(2),
                  decoration: BoxDecoration(
                    color: Colorss.whiteColor,
                    shape: BoxShape.circle,
                    border: Border.all(color: Colorss.blackColor, width: 2),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(AppDimensions.searchBorderRadius),
                    child: widget.job.companyLogo != null && widget.job.companyLogo!.isNotEmpty
                        ? Image.network(
                      fixUrl(widget.job.companyLogo!),
                      width: AppDimensions.jobCardImageSize,
                      height: AppDimensions.jobCardImageSize,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Image.asset(
                          'assets/default-logo.png',
                          width: AppDimensions.jobCardImageSize,
                          height: AppDimensions.jobCardImageSize,
                          fit: BoxFit.cover,
                        );
                      },
                    )
                        : Image.asset(
                      'assets/default-logo.png',
                      width: AppDimensions.jobCardImageSize,
                      height: AppDimensions.jobCardImageSize,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),

                Spaces.horizontal(AppDimensions.horizontalSpacerNormal),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.job.title,
                        style: const TextStyle(
                            fontSize: AppDimensions.fontSizeNormal, fontWeight: FontWeight.bold),
                        overflow: TextOverflow.ellipsis,
                      ),
                      Spaces.vertical(AppDimensions.spacingTiny),
                      Text(
                        widget.job.employment,
                        style: const TextStyle(
                            fontSize: AppDimensions.fontSizeSmall, color: Colorss.secondaryTextColor),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: Text(widget.job.isOpened ? tr('close_job') : tr('open_job')),
                        content: Text(
                          widget.job.isOpened
                              ? tr('confirm_close')
                              : tr('confirm_open'),
                        ),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.of(context).pop(),
                            child: Text(tr('cancel')),
                          ),
                          TextButton(
                            onPressed: () async {
                              Navigator.of(context).pop();
                              await _toggleJobStatus(context);
                            },
                            child: Text(tr('confirm')),
                          ),
                        ],
                      ),
                    );
                  },
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        widget.job.isOpened
                            ? Icons.cancel_outlined
                            : Icons.check_circle_outline,
                        color: widget.job.isOpened ? Colorss.closedColor : Colorss.openColor,
                        size: AppDimensions.iconSizeSmall,
                      ),
                      Spaces.horizontal(AppDimensions.horizontalSpacerExtraSmall),
                      Text(
                        widget.job.isOpened ? tr('closed') : tr('open'),
                        style: TextStyle(
                          fontSize: AppDimensions.fontSizeSmall,
                          fontWeight: FontWeight.w500,
                          color: widget.job.isOpened ? Colorss.closedColor : Colorss.openColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Spaces.vertical(AppDimensions.spacingSmall),
            Text(
              widget.job.description,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontSize: AppDimensions.fontSizeSmall, color: Colorss.secondaryTextColor),
            ),
            Spaces.vertical(AppDimensions.verticalSpacerMediumSmall),
            Text(
              widget.job.salary.toString(),
              style: const TextStyle(fontSize: AppDimensions.fontSizeSmall, fontWeight: FontWeight.bold),
            ),
            Spaces.vertical(AppDimensions.verticalSpacerMedium),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(
                        context,
                        '/employer/job-applicants',
                        arguments: widget.job.id,
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colorss.whiteColor,
                      backgroundColor: Colorss.primaryColor,
                    ),
                    child: Text(tr('applicants')),
                  ),
                ),
                Spaces.horizontal(AppDimensions.horizontalSpacerSmall),
                Expanded(
                  child: OutlinedButton(
                    onPressed: () async {
                      final confirm = await showDialog<bool>(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: Text(tr('confirm_deletion')),
                          content: Text(tr('confirm_delete_job')),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.of(context).pop(false),
                              child: Text(tr('cancel')),
                            ),
                            TextButton(
                              onPressed: () => Navigator.of(context).pop(true),
                              child: Text(tr('confirm')),
                            ),
                          ],
                        ),
                      );

                      if (confirm == true) {
                        try {
                          await JobService().deleteJob(widget.job.id);
                          if (context.mounted) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text(tr('job_deleted_success'))),
                            );
                            if (widget.onJobDeleted != null) {
                              widget.onJobDeleted!(widget.job);
                            }
                          }
                        } catch (e) {
                          if (context.mounted) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('${tr('job_delete_failed')}: $e')),
                            );
                          }
                        }
                      }
                    },
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: Colorss.primaryColor),
                      foregroundColor: Colorss.primaryColor,
                    ),
                    child: Text(tr('cancel')),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
