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
      _showError('No internet connection. Please check your network.');
    } on HttpException {
      _showError('Failed to communicate with the server.');
    } on FormatException {
      _showError('Unexpected response format from the server.');
    } catch (e) {
      _showError('Something went wrong. Please try again.');
    }
  }

  void _showError(String message) {
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message, style: const TextStyle(color: Colorss.whiteColor)),
        backgroundColor: Colorss.errorColor,
      ),
    );
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
        title: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Hello, Hidaya', style: TextStyle(fontSize: AppDimensions.fontSizeMedium, color: Colorss.primaryTextColor)),
            Text('AL-Adham Company', style: TextStyle(fontSize: AppDimensions.fontSizeSmall, color: Colorss.secondaryTextColor)),
          ],
        ),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: AppDimensions.defaultPadding),
            child: CircleAvatar(
              backgroundImage: AssetImage('assets/adham.jpg'),
              radius: 18,
            ),
          ),
        ],
      ),
      body: provider.isLoading
          ? const Center(child: CircularProgressIndicator())
          : RefreshIndicator(
        onRefresh: _loadJobs,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppDimensions.horizontalSpacerLarge),
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
                title: 'Open jobs',
                jobs: openJobs.take(5).toList(),
                tabIndex: 0,
                onStatusChange: provider.updateJobStatusByJob,
                onJobDeleted: provider.deleteJobByJob,
              ),
              Spaces.vertical(AppDimensions.verticalSpacerXLarge),
              JobSectionWidget(
                title: 'Closed jobs',
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
