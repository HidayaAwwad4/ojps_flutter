import 'package:flutter/material.dart';
import '../constants/colors.dart';
import '../models/job_model.dart';
import '../screens/job_applicants_employer.dart';
import '../screens/job_details_for_employer.dart';
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
      await JobService().updateJob(widget.job.id!, updatedData);

      final updatedJob = widget.job.copyWith(isOpened: newStatus);

      widget.onStatusChange(updatedJob);

      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(newStatus ? 'Job opened' : 'Job closed')),
        );
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Failed to update job status')),
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
            const SnackBar(content: Text('Failed to load job details')),
          );
        }
      },
      child: Container(
        padding: widget.padding ?? const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colorss.cardBackgroundColor,
          borderRadius: BorderRadius.circular(12),
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
                    color: Colors.white,
                    shape: BoxShape.circle,
                    border: Border.all(color: Colorss.blackColor, width: 2),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(50),
                    child: widget.job.companyLogo != null && widget.job.companyLogo!.isNotEmpty
                        ? Image.network(
                      fixUrl(widget.job.companyLogo!),
                      width: 40,
                      height: 40,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Image.asset(
                          'assets/default-logo.png',
                          width: 40,
                          height: 40,
                          fit: BoxFit.cover,
                        );
                      },
                    )
                        : Image.asset(
                      'assets/default-logo.png',
                      width: 40,
                      height: 40,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),

                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.job.title,
                        style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        widget.job.employment,
                        style: const TextStyle(
                            fontSize: 13, color: Colorss.secondaryTextColor),
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
                        title:
                        Text(widget.job.isOpened ? 'Close Job?' : 'Open Job?'),
                        content: Text(
                          widget.job.isOpened
                              ? 'Are you sure you want to close this job?'
                              : 'Are you sure you want to open this job?',
                        ),
                        actions: [
                          TextButton(
                              onPressed: () => Navigator.of(context).pop(),
                              child: const Text('Cancel')),
                          TextButton(
                            onPressed: () async {
                              Navigator.of(context).pop();
                              await _toggleJobStatus(context);
                            },
                            child: const Text('Confirm'),
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
                        color: widget.job.isOpened ?Colorss.closedColor : Colorss.openColor,
                        size: 20,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        widget.job.isOpened ? 'Closed' : 'Open',
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                          color:
                          widget.job.isOpened ? Colorss.closedColor : Colorss.openColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              widget.job.description,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontSize: 14, color: Colorss.secondaryTextColor),
            ),
            const SizedBox(height: 10),
            Text(
              widget.job.salary.toString(),
              style:
              const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
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
                    child: const Text('Applicants'),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: OutlinedButton(
                    onPressed: () async {
                      final confirm = await showDialog<bool>(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: const Text('Confirm Deletion'),
                          content: const Text(
                              'Are you sure you want to delete this job?'),
                          actions: [
                            TextButton(
                              onPressed: () =>
                                  Navigator.of(context).pop(false),
                              child: const Text('Cancel'),
                            ),
                            TextButton(
                              onPressed: () =>
                                  Navigator.of(context).pop(true),
                              child: const Text('Confirm'),
                            ),
                          ],
                        ),
                      );

                      if (confirm == true) {
                        try {
                          await JobService().deleteJob(widget.job.id!);
                          if (context.mounted) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text('Job deleted successfully')),
                            );
                            if (widget.onJobDeleted != null) {
                              widget.onJobDeleted!(widget.job);
                            }
                          }
                        } catch (e) {
                          if (context.mounted) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                  content: Text('Failed to delete job: $e')),
                            );
                          }
                        }
                      }
                    },
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: Colorss.primaryColor),
                      foregroundColor: Colorss.primaryColor,
                    ),
                    child: const Text('Delete'),
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
