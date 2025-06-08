import 'package:flutter/material.dart';
import '../models/job_model.dart';
import '../services/job_service.dart';
class EmployerJobsProvider extends ChangeNotifier {
  final JobService jobService;

  List<Job> _jobs = [];
  bool _isLoading = false;
  bool _isFetchingMore = false;
  bool _hasMore = true;
  int _currentPage = 1;
  final int _limit = 8;
  String? _error;
  String _searchQuery = '';

  EmployerJobsProvider({required this.jobService});

  List<Job> get jobs => _jobs;
  bool get isLoading => _isLoading;
  bool get isFetchingMore => _isFetchingMore;
  bool get hasMore => _hasMore;
  String? get error => _error;

  List<Job> get filteredJobs {
    if (_searchQuery.isEmpty) return _jobs;
    return _jobs.where((job) => job.title.toLowerCase().contains(_searchQuery.toLowerCase())).toList();
  }
  Future<void> fetchJobs({bool reset = false, bool loadMore = false}) async {
    if (_isLoading || _isFetchingMore || (!_hasMore && loadMore)) return;

    if (reset) {
      _currentPage = 1;
      _jobs = [];
      _hasMore = true;
    }

    if (_currentPage == 1 && !loadMore) {
      _isLoading = true;
    } else {
      _isFetchingMore = true;
    }

    notifyListeners();

    try {
      final employerId = await jobService.getEmployerId();
      final jobsData = await jobService.getJobsByEmployer(
        employerId,
        page: _currentPage,
        limit: _limit,
      );

      final newJobs = jobsData.map<Job>((json) => Job.fromJson(json)).toList();

      if (newJobs.length < _limit) {
        _hasMore = false;
      }

      _jobs.addAll(newJobs);
      _error = null;
      _currentPage++;
    } catch (e) {
      _error = e.toString();
      if (_currentPage == 1) {
        _jobs = [];
      }
    } finally {
      _isLoading = false;
      _isFetchingMore = false;
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
