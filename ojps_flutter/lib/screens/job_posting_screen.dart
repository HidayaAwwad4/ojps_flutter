import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../constants/colors.dart';
import '../providers/employer_jobs_provider.dart';
import '../widgets/job_card_vertical.dart';

class JobPostingScreen extends StatefulWidget {
  final int tabIndex;

  const JobPostingScreen({super.key, required this.tabIndex});

  @override
  State<JobPostingScreen> createState() => _JobPostingScreenState();
}

class _JobPostingScreenState extends State<JobPostingScreen>
    with SingleTickerProviderStateMixin {
  late bool fromSeeAll;
  late TabController _tabController;
  bool _isFirstLoad = true;
  late ScrollController _openScrollController;
  late ScrollController _closedScrollController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this, initialIndex: widget.tabIndex);

    _openScrollController = ScrollController();
    _closedScrollController = ScrollController();

    _openScrollController.addListener(() {
      final provider = Provider.of<EmployerJobsProvider>(context, listen: false);
      if (_openScrollController.position.pixels >=
          _openScrollController.position.maxScrollExtent - 200 &&
          !provider.isFetchingMore &&
          provider.hasMore) {
        provider.fetchJobs(loadMore: true);
      }
    });

    _closedScrollController.addListener(() {
      final provider = Provider.of<EmployerJobsProvider>(context, listen: false);
      if (_closedScrollController.position.pixels >=
          _closedScrollController.position.maxScrollExtent - 200 &&
          !provider.isFetchingMore &&
          provider.hasMore) {
        provider.fetchJobs(loadMore: true);
      }
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final args = ModalRoute.of(context)?.settings.arguments as Map?;
    fromSeeAll = args?['fromSeeAll'] ?? false;

    if (_isFirstLoad) {
      Provider.of<EmployerJobsProvider>(context, listen: false).fetchJobs(reset: true);
      _isFirstLoad = false;
    }
  }

  @override
  void dispose() {
    _tabController.dispose();
    _openScrollController.dispose();
    _closedScrollController.dispose();
    super.dispose();
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
        leading: fromSeeAll
            ? IconButton(
          icon: const Icon(Icons.arrow_back, color: Colorss.primaryTextColor),
          onPressed: () => Navigator.pop(context),
        )
            : null,
        title: Text(
            tr('job_postings'),
          style: TextStyle(color: Colorss.primaryTextColor),
        ),
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: Colorss.primaryColor,
          labelColor: Colorss.primaryColor,
          unselectedLabelColor: Colorss.greyColor,
          tabs: [
            Tab(text: tr('open_positions')),
            Tab(text: tr('closed_positions')),
          ],
        ),
      ),

      body: provider.isLoading && provider.jobs.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : TabBarView(
        controller: _tabController,
        children: [
          // Open Jobs
          ListView.builder(
            controller: _openScrollController,
            itemCount: openJobs.length + (provider.hasMore ? 1 : 0),
            itemBuilder: (context, index) {
              if (index == openJobs.length) {
                return provider.isFetchingMore
                    ? const Padding(
                  padding: EdgeInsets.all(16),
                  child: Center(child: CircularProgressIndicator()),
                )
                    : const SizedBox.shrink();
              }

              final job = openJobs[index];
              return JobCardVertical(
                job: job,
              );
            },
          ),

          // Closed Jobs
          ListView.builder(
            controller: _closedScrollController,
            itemCount: closedJobs.length + (provider.hasMore ? 1 : 0),
            itemBuilder: (context, index) {
              if (index == closedJobs.length) {
                return provider.isFetchingMore
                    ? const Padding(
                  padding: EdgeInsets.all(16),
                  child: Center(child: CircularProgressIndicator()),
                )
                    : const SizedBox.shrink();
              }

              final job = closedJobs[index];
              return JobCardVertical(
                job: job,
              );
            },
          ),
        ],
      ),
    );
  }
}
