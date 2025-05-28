import 'package:flutter/material.dart';
import '../constants/colors.dart';
import '../constants/dimensions.dart';
import '../models/application_model.dart';
import '../services/application_service.dart';
import '../utils/network_utils.dart';

class ApplicantDetailsScreen extends StatefulWidget {
  final int applicantId;

  const ApplicantDetailsScreen({super.key, required this.applicantId});

  @override
  State<ApplicantDetailsScreen> createState() => _ApplicantDetailsScreenState();
}

class _ApplicantDetailsScreenState extends State<ApplicantDetailsScreen> {
  Application? _applicant;
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
  Future<void> _updateStatus(String newStatus) async {
    setState(() {
      _isLoading = true;
    });

    try {
      final updated = await _applicationService.updateApplicantStatus(
        _applicant!.id,
        newStatus,
      );
      setState(() {
        _status = updated.status;
        _applicant = updated;
        _isLoading = false;
      });

      Navigator.pop(context, updated);
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to update status: $e')),
      );
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
      backgroundColor: Colorss.whiteColor,
      appBar: AppBar(
        title: const Text('Applicant Details'),
        backgroundColor: Colorss.whiteColor,
        foregroundColor: Colorss.primaryTextColor,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppDimensions.defaultPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _buildProfileImage(),
            const SizedBox(height: AppDimensions.verticalSpacerLarge),
            Text(
              _applicant!.name,
              style: const TextStyle(fontSize: AppDimensions.fontSizeLarge, fontWeight: FontWeight.bold),
            ),
            Text(_applicant!.email, style: TextStyle(color: Colorss.secondaryTextColor)),
            const SizedBox(height: AppDimensions.height5),
            _buildStatusBadge(),
            const SizedBox(height: AppDimensions.sectionSpacingLarge),
            buildSectionTitle('Resume:'),
            Align(
              alignment: Alignment.centerLeft,
              child: FilledButton(
                style: FilledButton.styleFrom(
                  backgroundColor: Colorss.primaryColor,
                  foregroundColor: Colorss.whiteColor,
                ),
                onPressed: () {
                  // open resume
                },
                child: const Text('View Resume'),
              ),
            ),
            const SizedBox(height: AppDimensions.height20),
            buildSectionTitle('Cover Letter:'),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                _applicant!.coverLetter ?? 'No cover letter provided.',
                style: const TextStyle(fontSize: AppDimensions.fontSizeNormal),
              ),
            ),
            const SizedBox(height: AppDimensions.sectionSpacingLarge),
            buildSectionTitle('Actions:'),
            const SizedBox(height: AppDimensions.height10),
            Row(
              children: [
                if (isPending) ...[
                  const SizedBox(width: AppDimensions.horizontalSpacerMedium),
                  _buildActionButton(
                    label: 'Shortlist',
                    onPressed: () => _updateStatus('shortlisted'),
                    backgroundColor: Colorss.cardBackgroundColor,
                    foregroundColor: Colorss.primaryColor,
                  ),
                ],
                if (isPending || isShortlisted) ...[
                  _buildActionButton(
                    label: 'Accept',
                    onPressed: () => _updateStatus('accepted'),
                    backgroundColor: Colorss.openColor,
                    foregroundColor: Colorss.whiteColor,
                  ),
                  const SizedBox(width: AppDimensions.horizontalSpacerMedium),
                  _buildActionButton(
                    label: 'Reject',
                    onPressed: () => _updateStatus('rejected'),
                    backgroundColor: Colors.black12,
                    foregroundColor: Colorss.primaryTextColor,
                  ),
                ],

                if (isAccepted) ...[
                  _buildActionButton(
                    label: 'Accepted',
                    onPressed: null,
                    backgroundColor: Colorss.lightBlueBackgroundColor,
                    foregroundColor: Colorss.primaryColor,
                    tonal: true,
                  ),
                ],
                if (isRejected) ...[
                  _buildActionButton(
                    label: 'Rejected',
                    onPressed: null,
                    backgroundColor: Colorss.cardBackgroundColor,
                    foregroundColor: Colorss.secondaryTextColor,
                    tonal: true,
                  ),
                ],
              ],
            ),
            const SizedBox(height: AppDimensions.height20),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileImage() {
    return CircleAvatar(
      radius: AppDimensions.profileImageRadiusMedium,
      backgroundImage: _applicant!.imageUrl != null && _applicant!.imageUrl!.isNotEmpty
          ? NetworkImage(fixUrl(_applicant!.imageUrl!))
          : const AssetImage('assets/Profile_avatar.png') as ImageProvider,
    );
  }

  Widget _buildStatusBadge() {
    final statusColor = getStatusColor(_status);
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppDimensions.badgePaddingHorizontal,
        vertical: AppDimensions.badgePaddingVertical,
      ),
      decoration: BoxDecoration(
        color: statusColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(AppDimensions.radius20),
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
        return Colorss.openColor;
      case 'rejected':
        return Colorss.closedColor;
      case 'pending':
        return Colorss.pendingColor;
      default:
        return Colorss.primaryColor;
    }
  }

  Widget buildSectionTitle(String text) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(
        text,
        style: const TextStyle(fontSize: AppDimensions.fontSizeNormal, fontWeight: FontWeight.bold),
      ),
    );
  }
}
