import 'package:flutter/material.dart';
import '../widgets/job_tab_bar.dart';
import '../widgets/job_tab_views.dart';
import 'package:ojps_flutter/constants/colors.dart';
import 'package:ojps_flutter/constants/text_styles.dart';
import '../widgets/custom_bottom_nav.dart';
import 'package:ojps_flutter/widgets/job_card_widget.dart';
import 'package:ojps_flutter/services/job_service.dart';
class JobStatusScreen extends StatefulWidget {
  const JobStatusScreen({super.key});

  @override
  State<JobStatusScreen> createState() => _JobStatusScreenState();
}

class _JobStatusScreenState extends State<JobStatusScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  List<dynamic> underReviewJobs = [];
  List<dynamic> acceptedJobs = [];
  List<dynamic> rejectedJobs = [];

  bool isLoading = true;
  String error = '';

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);

    fetchApplications();
  }

  Future<void> fetchApplications() async {
    try {
      final jobService = JobService();
      final jobSeekerId = await jobService.getCurrentUserId(); // 🔥 استرجع من التوكن

      final applications = await jobService.getApplicationsByJobSeekerId(jobSeekerId);

      setState(() {
        underReviewJobs = applications.where((app) {
          final status = app['status']?.toLowerCase();
          return status == 'pending' || status == 'shortlisted';
        }).toList();

        acceptedJobs = applications.where((app) => app['status']?.toLowerCase() == 'accepted').toList();

        rejectedJobs = applications.where((app) => app['status']?.toLowerCase() == 'rejected').toList();

        isLoading = false;
      });
    } catch (e) {
      setState(() {
        error = e.toString();
        isLoading = false;
      });
    }
  }


  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  List<dynamic> getJobsByTabIndex(int index) {
    if (index == 0) return underReviewJobs;
    if (index == 1) return acceptedJobs;
    return rejectedJobs;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Applications Status'),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pushNamedAndRemoveUntil(context, '/home', (route) => false);
            },
          ),
          bottom: TabBar(
            controller: _tabController,
            tabs: const [
              Tab(text: 'Under Review'),
              Tab(text: 'Accepted'),
              Tab(text: 'Rejected'),
            ],
          ),
        ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : error.isNotEmpty
          ? Center(child: Text('Error: $error'))
          : TabBarView(
        controller: _tabController,
        children: List.generate(3, (index) {
          final jobs = getJobsByTabIndex(index);
          if (jobs.isEmpty) {
            return const Center(child: Text('No applications found in this status.'));
          }
          return ListView.builder(
            itemCount: jobs.length,
            itemBuilder: (context, i) {
              final app = jobs[i];
              final job = app['job'];
              final String status = app['status']?.toLowerCase() ?? '';

              Color statusColor;
              IconData statusIcon;
              String statusLabel;

              if (status == 'pending' || status == 'shortlisted') {
                statusColor = Colorss.pendingColor;
                statusIcon = Icons.hourglass_top;
                statusLabel = 'Under Review';
              } else if (status == 'accepted') {
                statusColor = Colorss.successColor;
                statusIcon = Icons.check_circle;
                statusLabel = 'Accepted';
              } else {
                statusColor = Colorss.closedColor;
                statusIcon = Icons.cancel;
                statusLabel = 'Rejected';
              }

              return JobCard(
                image: job['company_logo'] ?? 'assets/default-logo.png',
                title: job['title'] ?? 'No Title',
                location: job['location'] ?? 'No Location',
                type: job['type'] ?? 'Full Time',
                description: job['description'],
                salary: '\$${job['salary']} per hour',
                onTap: () {
                },
                statusLabel: statusLabel,
                statusColor: statusColor,
                statusIcon: statusIcon,
              );
            },
          );
        }),
      ),
    );
  }
}
