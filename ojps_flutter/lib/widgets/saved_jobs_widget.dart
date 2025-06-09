import 'package:flutter/material.dart';
import 'package:ojps_flutter/services/favorite_job_service.dart';

class SavedJobsWidget extends StatefulWidget {
  @override
  _SavedJobsWidgetState createState() => _SavedJobsWidgetState();
}

class _SavedJobsWidgetState extends State<SavedJobsWidget> {
  List<Map<String, dynamic>> savedJobs = [];
  final int jobSeekerId = 1; // عدلها حسب المستخدم الحالي

  @override
  void initState() {
    super.initState();
    fetchSavedJobs();
  }

  Future<void> fetchSavedJobs() async {
    try {
      final jobs = await FavoriteJobService.getSavedJobs(jobSeekerId);
      setState(() {
        savedJobs = jobs;
      });
    } catch (e) {
      debugPrint('Error fetching saved jobs: $e');
    }
  }

  Future<void> toggleSaveJob(int index) async {
    final job = savedJobs[index];
    final jobId = job['id'];

    final success = await FavoriteJobService.removeJobFromFavorites(
      jobSeekerId: jobSeekerId,
      jobId: jobId,
    );

    if (success) {
      setState(() {
        savedJobs.removeAt(index);
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to remove from favorites')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    if (savedJobs.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Icon(Icons.bookmark_border, size: 80, color: Colors.purple),
            SizedBox(height: 20),
            Text('No saved jobs yet.', style: TextStyle(fontSize: 18, color: Colors.purple)),
          ],
        ),
      );
    }

    return ListView.builder(
      itemCount: savedJobs.length,
      itemBuilder: (context, index) {
        final job = savedJobs[index];
        return Card(
          margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
          child: ListTile(
            leading: Image.network(
              job['image'] ?? 'https://via.placeholder.com/100',
              width: 60,
              height: 60,
              fit: BoxFit.cover,
            ),
            title: Text(job['title'] ?? ''),
            subtitle: Text(job['location'] ?? ''),
            trailing: IconButton(
              icon: const Icon(Icons.bookmark, color: Colors.purple),
              onPressed: () => toggleSaveJob(index),
            ),
            onTap: () {
              // ممكن تضيف وظيفة عند الضغط على الوظيفة
            },
          ),
        );
      },
    );
  }
}
