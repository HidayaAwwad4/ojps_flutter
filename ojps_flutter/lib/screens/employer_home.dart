// lib/screens/employer_home.dart
import 'package:flutter/material.dart';
import '../constants/colors.dart';
import '../models/job_model.dart';
import '../services/job_service.dart';
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

  List<Job> allJobs = [];
  List<Job> filteredJobs = [];
  bool isLoading = true;
  final int employerId = 38;

  @override
  void initState() {
    super.initState();
    fetchEmployerJobs();
  }

  Future<void> fetchEmployerJobs() async {
    try {
      final jobService = JobService();
      final jobsJson = await jobService.getJobsByEmployer(employerId);
      final fetchedJobs = jobsJson.map<Job>((json) => Job.fromJson(json)).toList();

      setState(() {
        allJobs = fetchedJobs;
        filteredJobs = fetchedJobs;
        isLoading = false;
      });
    } catch (e) {
      print("Error fetching jobs: $e");
      setState(() => isLoading = false);
    }
  }

  void handleStatusChange(Job updatedJob) {
    setState(() {
      int index = allJobs.indexWhere((job) => job.id == updatedJob.id);
      if (index != -1) {
        allJobs[index] = updatedJob;
      }

      index = filteredJobs.indexWhere((job) => job.id == updatedJob.id);
      if (index != -1) {
        filteredJobs[index] = updatedJob;
      }
    });
  }

  void handleJobDeleted(Job job) {
    setState(() {
      allJobs.removeWhere((j) => j.id == job.id);
      filteredJobs.removeWhere((j) => j.id == job.id);
    });
  }

  void searchJobs(String query) {
    final searchResults = allJobs.where((job) {
      final jobTitle = job.title.toLowerCase();
      final searchQuery = query.toLowerCase();
      return jobTitle.contains(searchQuery);
    }).toList();
    setState(() {
      filteredJobs = searchResults;
    });
  }

  @override
  Widget build(BuildContext context) {
    final openJobs = filteredJobs.where((job) => job.isOpened).toList();
    final closedJobs = filteredJobs.where((job) => !job.isOpened).toList();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colorss.whiteColor,
        elevation: 0,
        automaticallyImplyLeading: false,
        title: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Hello, Hidaya', style: TextStyle(fontSize: 18, color: Colorss.primaryTextColor)),
            Text('AL-Adham Company', style: TextStyle(fontSize: 14, color: Colorss.secondaryTextColor)),
          ],
        ),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 16),
            child: CircleAvatar(
              backgroundImage: AssetImage('assets/adham.jpg'),
              radius: 18,
            ),
          ),
        ],
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : RefreshIndicator(
        onRefresh: fetchEmployerJobs,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: ListView(
            physics: const AlwaysScrollableScrollPhysics(),
            children: [
              const SizedBox(height: 12),
              SearchWidget(
                searchController: _searchController,
                onSearchChanged: searchJobs,
              ),
              const SizedBox(height: 16),
              JobSummaryWidget(
                openJobsCount: openJobs.length,
                closedJobsCount: closedJobs.length,
              ),
              const SizedBox(height: 24),
              JobSectionWidget(
                title: 'Open jobs',
                jobs: openJobs,
                tabIndex: 0,
                onStatusChange: handleStatusChange,
                onJobDeleted: handleJobDeleted,
              ),
              const SizedBox(height: 24),
              JobSectionWidget(
                title: 'Closed jobs',
                jobs: closedJobs,
                tabIndex: 1,
                onStatusChange: handleStatusChange,
                onJobDeleted: handleJobDeleted,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
