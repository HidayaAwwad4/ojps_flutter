import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import '../constants/colors.dart';
import '../constants/dimensions.dart';
import '../constants/spaces.dart';
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
        SnackBar(content: Text(tr('failed_update_status', args: [e.toString()]))),
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
        body: Center(child: Text(tr('failed_load_applicant_details'))),
      );
    }

    final bool isPending = _status.toLowerCase() == 'pending';
    final bool isAccepted = _status.toLowerCase() == 'accepted';
    final bool isRejected = _status.toLowerCase() == 'rejected';
    final bool isShortlisted = _status.toLowerCase() == 'shortlisted';

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        title: Text(tr('applicant_details')),
        backgroundColor: Theme.of(context).colorScheme.onPrimary,
        foregroundColor: Theme.of(context).colorScheme.onSecondary,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppDimensions.defaultPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _buildProfileImage(),
            Spaces.vertical(AppDimensions.verticalSpacerLarge),
            Text(
              _applicant!.name,
              style: const TextStyle(fontSize: AppDimensions.fontSizeLarge, fontWeight: FontWeight.bold),
            ),
            Text(_applicant!.email, style: Theme.of(context).textTheme.bodyMedium),
            Spaces.vertical(AppDimensions.height5),
            _buildStatusBadge(),
            Spaces.vertical(AppDimensions.sectionSpacingLarge),
            buildSectionTitle(tr('resume')),
            Align(
              alignment: Alignment.centerLeft,
              child: FilledButton(
                style: FilledButton.styleFrom(
                  backgroundColor: Colorss.primaryColor,
                  foregroundColor: Colorss.whiteColor,
                ),
                onPressed: () {
                  // open resume logic here
                },
                child: Text(tr('view_resume')),
              ),
            ),
            Spaces.vertical(AppDimensions.height20),
            buildSectionTitle(tr('cover_letter')),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                _applicant!.coverLetter ?? tr('no_cover_letter'),
                style: const TextStyle(fontSize: AppDimensions.fontSizeNormal),
              ),
            ),
            Spaces.vertical(AppDimensions.sectionSpacingLarge),
            buildSectionTitle(tr('actions')),
            Spaces.vertical(AppDimensions.height10),
            Row(
              children: [
                if (isPending) ...[
                  Spaces.horizontal(AppDimensions.horizontalSpacerMedium),
                  _buildActionButton(
                    label: tr('shortlist'),
                    onPressed: () => _updateStatus('shortlisted'),
                    backgroundColor: Colorss.cardBackgroundColor,
                    foregroundColor: Colorss.primaryColor,
                  ),
                ],
                if (isPending || isShortlisted) ...[
                  _buildActionButton(
                    label: tr('accept'),
                    onPressed: () => _updateStatus('accepted'),
                    backgroundColor: Colorss.openColor,
                    foregroundColor: Colorss.whiteColor,
                  ),
                  Spaces.horizontal(AppDimensions.horizontalSpacerMedium),
                  _buildActionButton(
                    label: tr('reject'),
                    onPressed: () => _updateStatus('rejected'),
                    backgroundColor: Colors.black12,
                    foregroundColor: Colorss.primaryTextColor,
                  ),
                ],
                if (isAccepted) ...[
                  _buildActionButton(
                    label: tr('accepted'),
                    onPressed: null,
                    backgroundColor: Colorss.lightBlueBackgroundColor,
                    foregroundColor: Colorss.primaryColor,
                    tonal: true,
                  ),
                ],
                if (isRejected) ...[
                  _buildActionButton(
                    label: tr('rejected'),
                    onPressed: null,
                    backgroundColor: Colorss.cardBackgroundColor,
                    foregroundColor: Colorss.secondaryTextColor,
                    tonal: true,
                  ),
                ],
              ],
            ),
            Spaces.vertical(AppDimensions.height20),
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
