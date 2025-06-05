import 'package:flutter/material.dart';
import '../models/job_model.dart';
import '../services/job_service.dart';

class EmployerJobsProvider extends ChangeNotifier {
  final JobService jobService;

  List<Job> _jobs = [];
  bool _isLoading = false;
  String? _error;
  String _searchQuery = '';

  EmployerJobsProvider({required this.jobService});

  List<Job> get jobs => _jobs;
  bool get isLoading => _isLoading;
  String? get error => _error;
  List<Job> get filteredJobs {
    if (_searchQuery.isEmpty) return _jobs;
    return _jobs.where((job) => job.title.toLowerCase().contains(_searchQuery.toLowerCase())).toList();
  }

  Future<void> fetchJobs() async {
    _isLoading = true;
    notifyListeners();

    try {
      final employerId = await jobService.getEmployerId();
      final jobsData = await jobService.getJobsByEmployer(employerId);
      _jobs = jobsData.map<Job>((json) => Job.fromJson(json)).toList();
      _error = null;
    } catch (e) {
      _error = e.toString();
      _jobs = [];
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> deleteJob(int id) async {
    try {
      await jobService.deleteJob(id);
      _jobs.removeWhere((job) => job.id == id);
      notifyListeners();
    } catch (e) {
      _error = e.toString();
      notifyListeners();
      rethrow;
    }
  }

  Future<void> updateJob(Job updatedJob) async {
    try {
      final updatedData = await jobService.updateJob(updatedJob.id, updatedJob.toJson());
      final newJob = Job.fromJson(updatedData);
      final index = _jobs.indexWhere((job) => job.id == newJob.id);
      if (index != -1) {
        _jobs[index] = newJob;
        notifyListeners();
      }
    } catch (e) {
      _error = e.toString();
      notifyListeners();
      rethrow;
    }
  }

  Future<void> addJob(Job newJob) async {
    try {
      final createdData = await jobService.createJob(newJob.toJson());
      final job = Job.fromJson(createdData);
      _jobs.add(job);
      notifyListeners();
    } catch (e) {
      _error = e.toString();
      notifyListeners();
      rethrow;
    }
  }

  void clearError() {
    _error = null;
    notifyListeners();
  }

  void searchJobs(String query) {
    _searchQuery = query;
    notifyListeners();
  }

  void updateJobStatus(int jobId, bool newStatus) {
    final index = _jobs.indexWhere((job) => job.id == jobId);
    if (index != -1) {
      _jobs[index] = _jobs[index].copyWith(isOpened: newStatus);
      notifyListeners();
    }
  }

  void updateJobStatusByJob(Job job) {
    updateJobStatus(job.id, !job.isOpened);
  }

  Future<void> deleteJobByJob(Job job) async {
    await deleteJob(job.id);
  }
}
