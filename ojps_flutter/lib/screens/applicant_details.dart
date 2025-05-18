import 'package:flutter/material.dart';
import '../constants/colors.dart';
import '../models/applicant_model.dart';
import 'job_applicants_employer.dart';
class JobApplicantsScreen extends StatefulWidget {
  final List<Applicant> applicants;

  const JobApplicantsScreen({super.key, required this.applicants});

  @override
  _JobApplicantsScreenState createState() => _JobApplicantsScreenState();
}

class _JobApplicantsScreenState extends State<JobApplicantsScreen> {
  void _updateApplicantStatus(Applicant updatedApplicant) {
    setState(() {
      final index = widget.applicants.indexWhere((applicant) => applicant.id == updatedApplicant.id);
      if (index != -1) {
        widget.applicants[index] = updatedApplicant;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Applicants'),
        backgroundColor: primaryColor,
        foregroundColor: whiteColor,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: widget.applicants.length,
        itemBuilder: (context, index) {
          final applicant = widget.applicants[index];

          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => ApplicantDetailsScreen(
                    applicant: applicant,
                  ),
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
                    backgroundImage: AssetImage(
                      applicant.imageUrl ?? 'assets/default_profile.png',
                    ),
                    radius: 24,
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
                          style: const TextStyle(fontSize: 14, color:secondaryTextColor),
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
      ),
    );
  }

  Color _statusColor(String status) {
    switch (status) {
      case 'Accepted':
        return openColor;
      case 'Rejected':
        return closedColor;
      default:
        return const Color(0xFF0273B1);
    }
  }
}
