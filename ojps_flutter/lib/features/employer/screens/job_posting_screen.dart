import 'package:flutter/material.dart';
import '../models/job_model.dart';
import '../widgets/bottom_nav_bar.dart';
import '../widgets/job_card.dart';

class JobPostingScreen extends StatefulWidget {
  const JobPostingScreen({super.key});

  @override
  State<JobPostingScreen> createState() => _JobPostingScreenState();
}

class _JobPostingScreenState extends State<JobPostingScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void _toggleJobStatus(Job job) {
    setState(() {
      job.isOpen = !job.isOpen;
    });
  }

  @override
  Widget build(BuildContext context) {
    final openJobs = jobs.where((job) => job.isOpen).toList();
    final closedJobs = jobs.where((job) => !job.isOpen).toList();

    return Scaffold(
      backgroundColor: const Color(0xFFFFFFFF),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        centerTitle: true,
        title: const Text(
          'Job Posting',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        bottom: TabBar(
          controller: _tabController,
          labelColor: Colors.black,
          unselectedLabelColor: Colors.grey,
          indicatorColor: const Color(0xFF0273B1),
          tabs: const [
            Tab(text: 'Open Jobs'),
            Tab(text: 'Closed Jobs'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildJobList(openJobs),
          _buildJobList(closedJobs),
        ],
      ),
      bottomNavigationBar: const BottomNavBar(),
    );
  }

  Widget _buildJobList(List<Job> jobs) {
    if (jobs.isEmpty) {
      return const Center(child: Text('No jobs to show'));
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: jobs.length,
      itemBuilder: (context, index) {
        return JobCard(
          job: jobs[index],
          onStatusChange: _toggleJobStatus,
        );
      },
    );
  }
}
