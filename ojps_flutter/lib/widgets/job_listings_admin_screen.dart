import 'package:flutter/material.dart';
import '../services/admin_service.dart';

class JobListingsScreen extends StatefulWidget {
  final AdminService adminService;

  const JobListingsScreen({Key? key, required this.adminService}) : super(key: key);

  @override
  State<JobListingsScreen> createState() => _JobListingsScreenState();
}

class _JobListingsScreenState extends State<JobListingsScreen> {
  late Future<List<dynamic>> _jobListingsFuture;

  @override
  void initState() {
    super.initState();
    _loadJobListings();
  }

  void _loadJobListings() {
    _jobListingsFuture = widget.adminService.getAllJobListings();
  }

  void _deleteJob(int jobId) async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Delete Job Listing'),
        content: const Text('Are you sure you want to delete this job listing?'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx, false), child: const Text('Cancel')),
          TextButton(onPressed: () => Navigator.pop(ctx, true), child: const Text('Delete')),
        ],
      ),
    );

    if (confirm == true) {
      try {
        await widget.adminService.deleteJobListing(jobId);
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Job deleted')));
        setState(() {
          _loadJobListings();
        });
      } catch (e) {
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error: $e')));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Job Listings'),
      ),
      body: FutureBuilder<List<dynamic>>(
        future: _jobListingsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          final jobs = snapshot.data!;
          if (jobs.isEmpty) {
            return const Center(child: Text('No job listings available'));
          }

          return ListView.builder(
            itemCount: jobs.length,
            itemBuilder: (context, index) {
              final job = jobs[index];
              return Card(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: ListTile(
                  title: Text(job['title'] ?? 'No Title'),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (job['company_name'] != null)
                        Text('Company: ${job['company_name']}'),
                      if (job['location'] != null)
                        Text('Location: ${job['location']}'),
                    ],
                  ),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete, color: Colors.red),
                    tooltip: 'Delete Job',
                    onPressed: () => _deleteJob(job['id']),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
