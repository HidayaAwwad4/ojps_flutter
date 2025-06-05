import 'package:flutter/material.dart';
import '../constants/colors.dart';
import '../constants/dimensions.dart';
import '../constants/spaces.dart';
import '../models/application_model.dart';
import '../services/application_service.dart';
import '../utils/network_utils.dart';
import 'applicant_details.dart';


class JobApplicantsScreen extends StatefulWidget {
  final int jobId;

  const JobApplicantsScreen({super.key, required this.jobId});

  @override
  _JobApplicantsScreenState createState() => _JobApplicantsScreenState();
}
class _JobApplicantsScreenState extends State<JobApplicantsScreen> {
  final ApplicationService _applicationService = ApplicationService();
  late Future<List<Application>> _applicantsFuture;
  List<Application> _applicantsFutureData = [];

  String _selectedStatus = 'all';

  @override
  void initState() {
    super.initState();
    _loadApplicants();
  }

  void _loadApplicants() {
    _applicantsFuture = _applicationService.getApplicantsByJobId(widget.jobId);
    _applicantsFuture.then((data) {
      setState(() {
        _applicantsFutureData = data;
      });
    });
  }

  List<Application> _filterApplicants(List<Application> applicants) {
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
        backgroundColor: Colorss.primaryColor,
        foregroundColor: Colorss.whiteColor,
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: AppDimensions.horizontalSpacerLarge, vertical: AppDimensions.verticalSpacerSmall),
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
            child: FutureBuilder<List<Application>>(
              future: _applicantsFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting && _applicantsFutureData.isEmpty) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return const Center(child: Text('Failed to load applicants'));
                }

                final filteredApplicants = _filterApplicants(_applicantsFutureData);

                if (filteredApplicants.isEmpty) {
                  return const Center(child: Text('No applicants found for this status'));
                }

                return ListView.builder(
                  padding: const EdgeInsets.all(AppDimensions.defaultPadding),
                  itemCount: filteredApplicants.length,
                  itemBuilder: (context, index) {
                    final applicant = filteredApplicants[index];
                    return GestureDetector(
                      onTap: () async {
                        final updatedApplicant = await Navigator.push<Application>(
                          context,
                          MaterialPageRoute(
                            builder: (_) => ApplicantDetailsScreen(applicantId: applicant.id),
                          ),
                        );

                        if (updatedApplicant != null) {
                          setState(() {
                            final i = _applicantsFutureData.indexWhere((a) => a.id == updatedApplicant.id);
                            if (i != -1) {
                              _applicantsFutureData[i] = updatedApplicant;
                            }
                            if (_selectedStatus != 'all' &&
                                updatedApplicant.status.toLowerCase() != _selectedStatus) {
                              _selectedStatus = updatedApplicant.status.toLowerCase();
                            }
                          });
                        }

                      },
                      child: Container(
                        margin: const EdgeInsets.only(bottom: AppDimensions.marginSmall),
                        padding: const EdgeInsets.all(AppDimensions.paddingSmall),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(color: Colors.grey.shade300),
                          borderRadius: BorderRadius.circular(AppDimensions.borderRadius),
                        ),
                        child: Row(
                          children: [
                            CircleAvatar(
                              radius: AppDimensions.companyLogoRadiusSmall,
                              backgroundImage: applicant.imageUrl != null
                                  ? NetworkImage(fixUrl(applicant.imageUrl!))
                                  : const AssetImage('assets/Profile_avatar.png') as ImageProvider,
                            ),
                            Spaces.horizontal(AppDimensions.horizontalSpacerNormal),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(applicant.name, style: const TextStyle(fontWeight: FontWeight.bold)),
                                  Spaces.vertical(AppDimensions.spacingTiny),
                                  Text(applicant.email, style: TextStyle(color: Colors.grey.shade600)),
                                ],
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: AppDimensions.horizontalSpacerSmall, vertical: AppDimensions.verticalSpacerExtraSmall),
                              decoration: BoxDecoration(
                                color: getStatusColor(applicant.status).withOpacity(0.1),
                                borderRadius: BorderRadius.circular(AppDimensions.borderRadiusLarge),
                              ),
                              child: Text(
                                applicant.status.toUpperCase(),
                                style: TextStyle(
                                  color: getStatusColor(applicant.status),
                                  fontSize: AppDimensions.fontSizeSmall,
                                  fontWeight: FontWeight.bold,
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

  Color getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'accepted':
        return Colorss.openColor;
      case 'rejected':
        return Colorss.closedColor;
      case 'pending':
        return Colorss.pendingColor;
      default:
        return Colorss.primaryColor;
    }
  }

  Widget _buildFilterButton(String label, String status) {
    final bool isSelected = _selectedStatus == status;
    return Padding(
      padding: const EdgeInsets.only(right: AppDimensions.paddingXSmall),
      child: ChoiceChip(
        label: Text(label),
        selected: isSelected,
        onSelected: (_) {
          setState(() {
            _selectedStatus = status;
          });
        },
        selectedColor: Colorss.primaryColor,
        labelStyle: TextStyle(color: isSelected ? Colorss.whiteColor : Colorss.primaryTextColor),
      ),
    );
  }
}
