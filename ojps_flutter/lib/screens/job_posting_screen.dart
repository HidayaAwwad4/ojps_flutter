import 'package:flutter/material.dart';
import '../models/job_model.dart';
import '../services/job_service.dart';
import '../widgets/job_card_vertical.dart';

class JobPostingScreen extends StatefulWidget {
  final int tabIndex;

  const JobPostingScreen({super.key, required this.tabIndex});

  @override
  State<JobPostingScreen> createState() => _JobPostingScreenState();
}

class _JobPostingScreenState extends State<JobPostingScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  List<Job> allJobs = [];
  bool isLoading = true;
  final int employerId = 38;

  @override
  void initState() {
    super.initState();
    _tabController =
        TabController(length: 2, vsync: this, initialIndex: widget.tabIndex);
    fetchEmployerJobs();
  }

  Future<void> fetchEmployerJobs() async {
    try {
      final jobService = JobService();
      final jobsJson = await jobService.getJobsByEmployer(employerId);
      final fetchedJobs =
      jobsJson.map<Job>((json) => Job.fromJson(json)).toList();

      setState(() {
        allJobs = fetchedJobs;
        isLoading = false;
      });
    } catch (e) {
      print("Error fetching jobs: $e");
      setState(() => isLoading = false);
    }
  }

  void toggleJobStatus(Job job) {
    setState(() {
      job.isOpened = !job.isOpened;
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final openJobs = allJobs.where((job) => job.isOpened).toList();
    final closedJobs = allJobs.where((job) => !job.isOpened).toList();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'Job Postings',
          style: TextStyle(color: Colors.black),
        ),
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: Color(0xFF0273B1),
          labelColor: Color(0xFF0273B1),
          unselectedLabelColor: Colors.grey,
          tabs: const [
            Tab(text: 'Open Positions'),
            Tab(text: 'Closed Positions'),
          ],
        ),
      ),
      body: isLoading
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
                onStatusChange: toggleJobStatus,
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
                onStatusChange: toggleJobStatus,
              );
            },
          ),
        ],
      ),
    );
  }
}
