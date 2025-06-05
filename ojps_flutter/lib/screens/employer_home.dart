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
      Provider.of<EmployerJobsProvider>(context, listen: false).fetchJobs();
      _isFirstLoad = false;
    }
  }
  @override
  void initState() {
    super.initState();
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
        onRefresh: provider.fetchJobs,
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
                jobs: openJobs,
                tabIndex: 0,
                onStatusChange: provider.updateJobStatusByJob,
                onJobDeleted: provider.deleteJobByJob,
              ),
              Spaces.vertical(AppDimensions.verticalSpacerXLarge),
              JobSectionWidget(
                title: 'Closed jobs',
                jobs: closedJobs,
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
