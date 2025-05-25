import 'package:flutter/material.dart';
import '../constants/colors.dart';
import '../models/applicant_model.dart';
import '../services/application_service.dart';
import '../utils/network_utils.dart';

class ApplicantDetailsScreen extends StatefulWidget {
  final int applicantId;

  const ApplicantDetailsScreen({super.key, required this.applicantId});

  @override
  State<ApplicantDetailsScreen> createState() => _ApplicantDetailsScreenState();
}

class _ApplicantDetailsScreenState extends State<ApplicantDetailsScreen> {
  Applicant? _applicant;
  bool _isLoading = true;
  late String _status;
  final ApplicationService _applicationService = ApplicationService();


  @override
  void initState() {
    super.initState();
    _fetchApplicantDetails();
  }

  Future<void> _fetchApplicantDetails() async {
    try {
      print('Fetching applicant with id: ${widget.applicantId}');
      final applicant = await _applicationService.getApplicantById(widget.applicantId);
      setState(() {
        _applicant = applicant;
        _status = applicant.status;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
    }
  }


  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    if (_applicant == null) {
      return Scaffold(
        body: Center(child: Text('Failed to load applicant details')),
      );
    }

    final bool isPending = _status.toLowerCase() == 'pending';
    final bool isAccepted = _status.toLowerCase() == 'accepted';
    final bool isRejected = _status.toLowerCase() == 'rejected';
    final bool isShortlisted = _status.toLowerCase() == 'shortlisted';

    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        title: const Text('Applicant Details'),
        backgroundColor: whiteColor,
        foregroundColor: primaryTextColor,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _buildProfileImage(),
            const SizedBox(height: 16),
            Text(
              _applicant!.name,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Text(_applicant!.email, style: TextStyle(color: secondaryTextColor)),
            const SizedBox(height: 4),
            _buildStatusBadge(),
            const SizedBox(height: 28),
            buildSectionTitle('Resume:'),
            Align(
              alignment: Alignment.centerLeft,
              child: FilledButton(
                style: FilledButton.styleFrom(
                  backgroundColor: primaryColor,
                  foregroundColor: whiteColor,
                ),
                onPressed: () {

                },
                child: const Text('View Resume'),
              ),
            ),
            const SizedBox(height: 24),
            buildSectionTitle('Cover Letter:'),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                _applicant!.coverLetter ?? 'No cover letter provided.',
                style: const TextStyle(fontSize: 16),
              ),
            ),
            const SizedBox(height: 28),
            buildSectionTitle('Actions:'),
            const SizedBox(height: 8),
            Row(
              children: [
                if (isPending || isShortlisted) ...[
                  _buildActionButton(
                    label: 'Accept',
                    onPressed: () {
                      setState(() {
                        _status = 'accepted';
                        _applicant!.status = 'accepted';
                      });
                    },
                    backgroundColor: primaryColor,
                    foregroundColor: whiteColor,
                  ),
                  const SizedBox(width: 12),
                  _buildActionButton(
                    label: 'Reject',
                    onPressed: () {
                      setState(() {
                        _status = 'rejected';
                        _applicant!.status = 'rejected';
                      });
                    },
                    backgroundColor: Colors.black12,
                    foregroundColor: primaryTextColor,
                  ),
                ],
                if (isPending) ...[
                  const SizedBox(width: 12),
                  _buildActionButton(
                    label: 'Add to Shortlist',
                    onPressed: () {
                      setState(() {
                        _status = 'shortlisted';
                        _applicant!.status = 'shortlisted';
                      });
                    },
                    backgroundColor: Colors.orange.shade100,
                    foregroundColor: Colors.orange.shade800,
                  ),
                ],
                if (isAccepted) ...[
                  _buildActionButton(
                    label: 'Accepted',
                    onPressed: null,
                    backgroundColor: lightBlueBackgroundColor,
                    foregroundColor: primaryColor,
                    tonal: true,
                  ),
                ],
                if (isRejected) ...[
                  _buildActionButton(
                    label: 'Rejected',
                    onPressed: null,
                    backgroundColor: cardBackgroundColor,
                    foregroundColor: secondaryTextColor,
                    tonal: true,
                  ),
                ],
              ],
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileImage() {
    return CircleAvatar(
      radius: 45,
      backgroundImage: _applicant!.imageUrl != null && _applicant!.imageUrl!.isNotEmpty
          ? NetworkImage(fixUrl(_applicant!.imageUrl!))
          : const AssetImage('assets/Profile_avatar.png'),
    );
  }


  Widget _buildStatusBadge() {
    final statusColor = getStatusColor(_status);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: statusColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        _status.toUpperCase(),
        style: TextStyle(
          color: statusColor,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildActionButton({
    required String label,
    required VoidCallback? onPressed,
    required Color backgroundColor,
    required Color foregroundColor,
    bool tonal = false,
  }) {
    final style = FilledButton.styleFrom(
      backgroundColor: backgroundColor,
      foregroundColor: foregroundColor,
    );
    return Expanded(
      child: tonal
          ? FilledButton.tonal(
        onPressed: onPressed,
        style: style,
        child: Text(label),
      )
          : FilledButton(
        onPressed: onPressed,
        style: style,
        child: Text(label),
      ),
    );
  }

  Color getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'accepted':
        return openColor;
      case 'rejected':
        return closedColor;
      default:
        return pendingColor;
    }
  }

  Widget buildSectionTitle(String text) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(
        text,
        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
      ),
    );
  }
}