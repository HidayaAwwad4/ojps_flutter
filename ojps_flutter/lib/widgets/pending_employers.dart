import 'package:flutter/material.dart';
import '../services/admin_service.dart';

class PendingEmployersScreen extends StatefulWidget {
  final AdminService adminService;

  const PendingEmployersScreen({Key? key, required this.adminService}) : super(key: key);

  @override
  _PendingEmployersScreenState createState() => _PendingEmployersScreenState();
}

class _PendingEmployersScreenState extends State<PendingEmployersScreen> {
  late Future<List<dynamic>> _pendingEmployersFuture;

  @override
  void initState() {
    super.initState();
    _loadPendingEmployers();
  }

  void _loadPendingEmployers() {
    setState(() {
      _pendingEmployersFuture = widget.adminService.getPendingEmployers();
    });
  }

  Future<bool?> _showConfirmationDialog(String action) {
    return showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('$action Confirmation'),
        content: Text('Are you sure you want to $action this employer?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: const Text('Confirm'),
          ),
        ],
      ),
    );
  }

  void _approveEmployer(int id) async {
    final confirmed = await _showConfirmationDialog('Approve');
    if (confirmed != true) return;

    try {
      await widget.adminService.approveEmployer(id);
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Employer approved')));
      setState(() {
        _pendingEmployersFuture = widget.adminService.getPendingEmployers();
      });
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error approving employer: $e')));
    }
  }

  void _rejectEmployer(int id) async {
    final confirmed = await _showConfirmationDialog('Reject');
    if (confirmed != true) return;

    try {
      await widget.adminService.rejectEmployer(id);
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Employer rejected')));
      setState(() {
        _pendingEmployersFuture = widget.adminService.getPendingEmployers();
      });
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error rejecting employer: $e')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pending Employers'),
      ),
      body: FutureBuilder<List<dynamic>>(
        future: _pendingEmployersFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          final employers = snapshot.data ?? [];
          if (employers.isEmpty) {
            return const Center(child: Text('No pending employers'));
          }
          return ListView.builder(
            itemCount: employers.length,
            itemBuilder: (context, index) {
              final employer = employers[index];
              final profilePic = employer['profile_picture'];
              final name = employer['name'] ?? 'No Name';
              final email = employer['email'] ?? '';
              final id = employer['id'];

              return Card(
                margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                child: ListTile(
                  leading: (profilePic != null && profilePic.isNotEmpty)
                      ? CircleAvatar(
                    backgroundImage: NetworkImage(profilePic),
                  )
                      : const CircleAvatar(child: Icon(Icons.person)),
                  title: Text(name),
                  subtitle: Text(email),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.check, color: Colors.green),
                        onPressed: id != null ? () => _approveEmployer(id) : null,
                        tooltip: 'Approve',
                      ),
                      IconButton(
                        icon: const Icon(Icons.close, color: Colors.red),
                        onPressed: id != null ? () => _rejectEmployer(id) : null,
                        tooltip: 'Reject',
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
