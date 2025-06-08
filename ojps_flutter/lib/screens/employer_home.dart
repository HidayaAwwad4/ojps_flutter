import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../constants/colors.dart';
import '../constants/dimensions.dart';
import '../constants/spaces.dart';
import '../providers/employer_jobs_provider.dart';
import '../widgets/job_section_in_employer_home.dart';
import '../widgets/job_summary.dart';
import '../widgets/search_for_employer.dart';
import 'package:easy_localization/easy_localization.dart';

class EmployerHome extends StatefulWidget {
  const EmployerHome({super.key});

  @override
  State<EmployerHome> createState() => _EmployerHomeScreenState();
}

class _EmployerHomeScreenState extends State<EmployerHome> {
  final TextEditingController _searchController = TextEditingController();
  bool _isFirstLoad = true;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_isFirstLoad) {
      _loadJobs();
      _isFirstLoad = false;
    }
  }

  Future<void> _loadJobs() async {
    try {
      await Provider.of<EmployerJobsProvider>(context, listen: false).fetchJobs();
    } on SocketException {
      _showError('noInternetConnection');
    } on HttpException {
      _showError('failedServerCommunication');
    } on FormatException {
      _showError('unexpectedResponseFormat');
    } catch (e) {
      _showError('somethingWentWrong');
    }
  }

  void _showError(String key) {
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(tr(key), style: const TextStyle(color: Colorss.whiteColor)),
        backgroundColor: Colorss.errorColor,
      ),
    );
  }

  void _toggleLanguage() {
    final currentLocale = context.locale;
    if (currentLocale.languageCode == 'en') {
      context.setLocale(const Locale('ar'));
    } else {
      context.setLocale(const Locale('en'));
    }
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<EmployerJobsProvider>(context);
    final openJobs = provider.filteredJobs.where((job) => job.isOpened).toList();
    final closedJobs = provider.filteredJobs.where((job) => !job.isOpened).toList();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colorss.whiteColor,
        elevation: 0,
        automaticallyImplyLeading: false,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(tr('hello'),
                style: const TextStyle(
                    fontSize: AppDimensions.fontSizeMedium,
                    color: Colorss.primaryTextColor)),
            Text(tr('welcome'),
                style: const TextStyle(
                    fontSize: AppDimensions.fontSizeSmall,
                    color: Colorss.secondaryTextColor)),
          ],
        ),
        actions: [
          IconButton(
            padding: EdgeInsets.only(right: 20,left: 20),
            onPressed: _toggleLanguage,
            icon: const Icon(Icons.language, color: Colorss.primaryTextColor),
            iconSize: 32,
            tooltip: tr('changeLanguage'),
          ),
        ],
      ),
      body: provider.isLoading
          ? const Center(child: CircularProgressIndicator())
          : RefreshIndicator(
        onRefresh: _loadJobs,
        child: Padding(
          padding: const EdgeInsets.symmetric(
              horizontal: AppDimensions.horizontalSpacerLarge),
          child: ListView(
            physics: const AlwaysScrollableScrollPhysics(),
            children: [
              Spaces.vertical(AppDimensions.horizontalSpacerNormal),
              SearchWidget(
                searchController: _searchController,
                onSearchChanged: provider.searchJobs,
              ),
              Spaces.vertical(AppDimensions.verticalSpacerMedium),
              JobSummaryWidget(
                openJobsCount: openJobs.length,
                closedJobsCount: closedJobs.length,
              ),
              Spaces.vertical(AppDimensions.verticalSpacerXLarge),
              JobSectionWidget(
                title: tr('openJobs'),
                jobs: openJobs.take(5).toList(),
                tabIndex: 0,
                onStatusChange: provider.updateJobStatusByJob,
                onJobDeleted: provider.deleteJobByJob,
              ),
              Spaces.vertical(AppDimensions.verticalSpacerXLarge),
              JobSectionWidget(
                title: tr('closedJobs'),
                jobs: closedJobs.take(5).toList(),
                tabIndex: 1,
                onStatusChange: provider.updateJobStatusByJob,
                onJobDeleted: provider.deleteJobByJob,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
