import 'package:flutter/material.dart';
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

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this, initialIndex: widget.tabIndex);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final openJobs = jobs.where((job) => job.isOpen).toList();
    final closedJobs = jobs.where((job) => !job.isOpen).toList();

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
          indicatorColor: const Color(0xFF0273B1),
          labelColor: const Color(0xFF0273B1),
          unselectedLabelColor: Colors.grey,
          tabs: const [
            Tab(text: 'Open Positions'),
            Tab(text: 'Closed Positions'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          // Open Jobs
          ListView.builder(
            itemCount: openJobs.length,
            itemBuilder: (context, index) {
              final job = openJobs[index];
              return JobCardVertical(
                job: job,
                onStatusChange: (updatedJob) {
                  setState(() {
                    job.isOpen = !job.isOpen;
                  });
                },
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
                onStatusChange: (updatedJob) {
                  setState(() {
                    job.isOpen = !job.isOpen;
                  });
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
