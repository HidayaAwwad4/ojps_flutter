import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../constants/colors.dart';
import '../models/applicant_model.dart';

class ApplicantDetailsScreen extends StatefulWidget {
  final Applicant applicant;

  const ApplicantDetailsScreen({super.key, required this.applicant});

  @override
  State<ApplicantDetailsScreen> createState() => _ApplicantDetailsScreenState();
}

class _ApplicantDetailsScreenState extends State<ApplicantDetailsScreen> {
  late String _status;

  @override
  void initState() {
    super.initState();
    _status = widget.applicant.status;
  }

  @override
  Widget build(BuildContext context) {
    final formattedDate = DateFormat.yMMMMd().format(widget.applicant.appliedAt);

    final bool isPending = _status == 'pending';
    final bool isAccepted = _status == 'accepted';
    final bool isRejected = _status == 'rejected';

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
              widget.applicant.name,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Text(widget.applicant.email, style: TextStyle(color: secondaryTextColor)),
            const SizedBox(height: 4),
            Text(
              'Applied on: $formattedDate',
              style: TextStyle(color: secondaryTextColor.withOpacity(0.7)),
            ),
            const SizedBox(height: 12),
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
                onPressed: () {},
                child: const Text('View Resume'),
              ),
            ),
            const SizedBox(height: 24),
            buildSectionTitle('Cover Letter:'),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                widget.applicant.coverLetter ?? 'No cover letter provided.',
                style: const TextStyle(fontSize: 16),
              ),
            ),
            const SizedBox(height: 28),
            buildSectionTitle('Actions:'),
            const SizedBox(height: 8),
            Row(
              children: [
                if (isPending) ...[
                  _buildActionButton(
                    label: 'Accept',
                    onPressed: () {
                      setState(() {
                        _status = 'accepted';
                        widget.applicant.status = 'accepted';
                      });
                    },
                    backgroundColor: primaryColor,
                    foregroundColor: whiteColor,
                  ),
                  const SizedBox(width: 16),
                  _buildActionButton(
                    label: 'Reject',
                    onPressed: () {
                      setState(() {
                        _status = 'rejected';
                        widget.applicant.status = 'rejected';
                      });
                    },
                    backgroundColor: Colors.black12,
                    foregroundColor: primaryTextColor,
                  ),
                ] else if (isAccepted) ...[
                  _buildActionButton(
                    label: 'Accepted',
                    onPressed: null,
                    backgroundColor: lightBlueBackgroundColor,
                    foregroundColor: primaryColor,
                    tonal: true,
                  ),
                ] else if (isRejected) ...[
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
      backgroundImage: AssetImage(
        widget.applicant.imageUrl ?? 'assets/default_profile.png',
      ),
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
