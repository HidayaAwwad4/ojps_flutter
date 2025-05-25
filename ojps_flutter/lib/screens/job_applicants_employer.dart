import 'package:flutter/material.dart';
import '../constants/colors.dart';
import '../models/applicant_model.dart';
import '../services/application_service.dart';
import '../utils/network_utils.dart';
import 'applicant_details.dart';
// import 'applicant_details_screen.dart';

class JobApplicantsScreen extends StatefulWidget {
  final int jobId;

  const JobApplicantsScreen({super.key, required this.jobId});

  @override
  _JobApplicantsScreenState createState() => _JobApplicantsScreenState();
}
class _JobApplicantsScreenState extends State<JobApplicantsScreen> {
  final ApplicationService _applicationService = ApplicationService();
  late Future<List<Applicant>> _applicantsFuture;

  // حالة الفلتر الحالية (default = الجميع)
  String _selectedStatus = 'all';

  @override
  void initState() {
    super.initState();
    _applicantsFuture = _applicationService.getApplicantsByJobId(widget.jobId);
  }

  // دالة لتصفية المتقدمين حسب الحالة المختارة
  List<Applicant> _filterApplicants(List<Applicant> applicants) {
    if (_selectedStatus == 'all') {
      return applicants;
    } else {
      return applicants.where((a) => a.status.toLowerCase() == _selectedStatus).toList();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Applicants'),
        backgroundColor: primaryColor,
        foregroundColor: whiteColor,
      ),
      body: Column(
        children: [
          // شريط الفلتر
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            color: Colors.white,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  _buildFilterButton('All', 'all'),
                  _buildFilterButton('Pending', 'pending'),
                  _buildFilterButton('Shortlisted', 'shortlisted'),
                  _buildFilterButton('Accepted', 'accepted'),
                  _buildFilterButton('Rejected', 'rejected'),
                ],
              ),
            ),
          ),

          Expanded(
            child: FutureBuilder<List<Applicant>>(
              future: _applicantsFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return const Center(child: Text('Failed to load applicants'));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Center(child: Text('No applicants found'));
                }

                final filteredApplicants = _filterApplicants(snapshot.data!);

                if (filteredApplicants.isEmpty) {
                  return const Center(child: Text('No applicants found for this status'));
                }

                return ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: filteredApplicants.length,
                  itemBuilder: (context, index) {
                    final applicant = filteredApplicants[index];
                    return GestureDetector(
                      onTap: () async {
                        final updatedApplicant = await Navigator.push<Applicant>(
                          context,
                          MaterialPageRoute(
                            builder: (_) => ApplicantDetailsScreen(applicantId: applicant.id),
                          ),
                        );
                      },
                      child: Container(
                        margin: const EdgeInsets.only(bottom: 12),
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: cardBackgroundColor,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Row(
                          children: [
                            CircleAvatar(
                              radius: 24,
                              backgroundColor: Colors.grey[200],
                              backgroundImage: applicant.imageUrl != null
                                  ? NetworkImage(fixUrl(applicant.imageUrl!))
                                  : const AssetImage('assets/Profile_avatar.png'),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    applicant.name,
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    applicant.email,
                                    style: const TextStyle(fontSize: 14, color: secondaryTextColor),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                              decoration: BoxDecoration(
                                color: _statusColor(applicant.status),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Text(
                                applicant.status,
                                style: const TextStyle(
                                  color: whiteColor,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 12,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  // زر الفلتر مع تغيير اللون عند التحديد
  Widget _buildFilterButton(String label, String statusValue) {
    final isSelected = _selectedStatus == statusValue;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 6),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: isSelected ? primaryColor : Colors.grey[300],
          foregroundColor: isSelected ? whiteColor : Colors.black,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
          elevation: 0,
        ),
        onPressed: () {
          setState(() {
            _selectedStatus = statusValue;
          });
        },
        child: Text(label),
      ),
    );
  }

  Color _statusColor(String status) {
    switch (status.toLowerCase()) {
      case 'accepted':
        return openColor;
      case 'rejected':
        return closedColor;
      default:
        return const Color(0xFF0273B1);
    }
  }
}
