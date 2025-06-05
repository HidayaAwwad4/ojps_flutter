import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../constants/colors.dart';
import '../providers/employer_jobs_provider.dart';
import '../widgets/job_card_vertical.dart';
import '../models/job_model.dart';

class JobPostingScreen extends StatefulWidget {
  final int tabIndex;

  const JobPostingScreen({super.key, required this.tabIndex});

  @override
  State<JobPostingScreen> createState() => _JobPostingScreenState();
}

class _JobPostingScreenState extends State<JobPostingScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  bool _isFirstLoad = true;

  @override
  void initState() {
    super.initState();
    _tabController =
        TabController(length: 2, vsync: this, initialIndex: widget.tabIndex);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_isFirstLoad) {
      Provider.of<EmployerJobsProvider>(context, listen: false).fetchJobs();
      _isFirstLoad = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<EmployerJobsProvider>(context);

    final openJobs = provider.filteredJobs.where((job) => job.isOpened).toList();
    final closedJobs = provider.filteredJobs.where((job) => !job.isOpened).toList();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'Job Postings',
          style: TextStyle(color: Colorss.primaryTextColor),
        ),
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: Colorss.primaryColor,
          labelColor: Colorss.primaryColor,
          unselectedLabelColor: Colorss.greyColor,
          tabs: const [
            Tab(text: 'Open Positions'),
            Tab(text: 'Closed Positions'),
          ],
        ),
      ),
      body: provider.isLoading
          ? const Center(child: CircularProgressIndicator())
          : TabBarView(
        controller: _tabController,
        children: [
          // Open Jobs
          ListView.builder(
            itemCount: openJobs.length,
            itemBuilder: (context, index) {
              final job = openJobs[index];
              return JobCardVertical(
                job: job,
                onStatusChange: provider.updateJobStatusByJob,
                onJobDeleted: provider.deleteJobByJob,
              );
            },
          ),

          // Closed Jobs
          ListView.builder(
            itemCount: closedJobs.length,
            itemBuilder: (context, index) {
              final job = closedJobs[index];
              return JobCardVertical(
                job: job,
                onStatusChange: provider.updateJobStatusByJob,
                onJobDeleted: provider.deleteJobByJob,
              );
            },
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }
}
