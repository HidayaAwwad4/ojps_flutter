 import 'package:flutter/material.dart';
import '../constants/colors.dart';
import '../models/job_model.dart';
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
  List<Job> filteredJobs = List.from(jobs);

  void toggleJobStatus(Job job) {
    setState(() {
      job.isOpen = !job.isOpen;
    });
  }

  void searchJobs(String query) {
    final searchResults = jobs.where((job) {
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
    final openJobs = filteredJobs.where((job) => job.isOpen).toList();
    final closedJobs = filteredJobs.where((job) => !job.isOpen).toList();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: whiteColor,
        elevation: 0,
        automaticallyImplyLeading: false,
        title: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Welcome Back!', style: TextStyle(fontSize: 18, color: primaryTextColor)),
            Text('AL-Adham Company', style: TextStyle(fontSize: 14, color: secondaryTextColor)),
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
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: ListView(
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
              onStatusChange: toggleJobStatus,
            ),
            const SizedBox(height: 24),
            JobSectionWidget(
              title: 'Closed jobs',
              jobs: closedJobs,
              tabIndex: 1,
              onStatusChange: toggleJobStatus,
            ),
          ],
        ),
      ),
    );
  }
}
