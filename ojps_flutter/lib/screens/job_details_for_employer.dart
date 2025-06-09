import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:easy_localization/easy_localization.dart';
import '../constants/colors.dart';
import '../constants/dimensions.dart';
import '../constants/spaces.dart';
import '../models/job_model.dart';
import '../utils/network_utils.dart';
import 'edit_job_screen.dart';
import '../widgets/detail_tile.dart';
import '../widgets/header_bar.dart';

class JobDetailsScreen extends StatefulWidget {
  final Job job;

  const JobDetailsScreen({super.key, required this.job});

  @override
  State<JobDetailsScreen> createState() => _JobDetailsScreenState();
}

class _JobDetailsScreenState extends State<JobDetailsScreen> {
  late Job job;

  @override
  void initState() {
    super.initState();
    job = widget.job;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colorss.whiteColor,
      body: SafeArea(
        child: Column(
          children: [
            HeaderBar(updatedJob: job),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: AppDimensions.defaultPadding),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      radius: AppDimensions.companyLogoRadiusInJobDetails,
                      backgroundImage: job.companyLogo != null
                          ? NetworkImage(fixUrl(job.companyLogo!))
                          : const AssetImage('assets/default-logo.png') as ImageProvider,
                      backgroundColor: Colorss.primaryTextColor,
                    ),
                    Spaces.vertical(AppDimensions.spacingXSmall),
                    Text(
                      job.title,
                      style: const TextStyle(fontSize: AppDimensions.fontSizeMedium, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      job.location,
                      style: const TextStyle(color: Colorss.greyColor),
                    ),
                    Spaces.vertical(AppDimensions.verticalSpacerMedium),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'description'.tr(),
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    Spaces.vertical(AppDimensions.spacingTiny),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(job.description),
                    ),
                    Spaces.vertical(AppDimensions.verticalSpacerLarge),
                    Container(
                      decoration: BoxDecoration(
                        color: Colorss.cardBackgroundColor,
                        borderRadius: BorderRadius.circular(AppDimensions.borderRadius),
                      ),
                      child: Column(
                        children: [
                          DetailTile(title: 'experience'.tr(), value: job.experience),
                          const Divider(height: 1),
                          DetailTile(title: 'languages'.tr(), value: job.languages),
                          const Divider(height: 1),
                          DetailTile(title: 'employment'.tr(), value: job.employment),
                          const Divider(height: 1),
                          DetailTile(title: 'schedule'.tr(), value: job.schedule),
                          const Divider(height: 1),
                          DetailTile(title: 'category'.tr(), value: job.category),
                          const Divider(height: 1),
                          DetailTile(
                            title: 'salary'.tr(),
                            value: job.salary.toStringAsFixed(2),
                          ),

                        ],
                      ),
                    ),
                    Spaces.vertical(AppDimensions.verticalSpacerLarge),
                    ElevatedButton(
                      onPressed: () async {
                        final updatedJob = await Navigator.push<Job>(
                          context,
                          MaterialPageRoute(
                            builder: (_) => EditJobScreen(job: job),
                          ),
                        );

                        if (updatedJob != null) {
                          setState(() {
                            job = updatedJob;
                          });
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colorss.primaryColor,
                        foregroundColor: Colorss.whiteColor,
                        minimumSize: const Size(double.infinity, AppDimensions.minimumSizeButton),
                      ),
                      child: Text('edit'.tr()),
                    ),
                    Spaces.vertical(AppDimensions.verticalSpacerXLarge),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
