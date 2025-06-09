import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../services/admin_service.dart';

class AdminDashboardScreen extends StatelessWidget {
  const AdminDashboardScreen({super.key});

  void _toggleLanguage(BuildContext context) {
    final currentLocale = EasyLocalization.of(context)!.locale;
    final newLocale =
    currentLocale.languageCode == 'en' ? const Locale('ar') : const Locale('en');
    EasyLocalization.of(context)!.setLocale(newLocale);
  }

  void _logout(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    Navigator.pushNamedAndRemoveUntil(
      context,
      '/Login',
          (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    final adminService = AdminService();
    return Scaffold(
      appBar: AppBar(
        title: Text('admin_dashboard'.tr()),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 1,
        actions: [
          IconButton(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            onPressed: () => _toggleLanguage(context),
            icon: const Icon(Icons.language, color: Colors.black),
            iconSize: 28,
            tooltip: tr('changeLanguage'),
          ),
        ],
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 24),
            const Icon(Icons.admin_panel_settings, size: 72, color: Color(0xFF0273B1)),
            const SizedBox(height: 16),
            Center(
              child: Text(
                tr('welcome_admin'),
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
            ),
            const SizedBox(height: 40),
            _DashboardButton(
              title: 'manage_employers'.tr(),
              onTap: () {
                Navigator.pushNamed(
                  context,
                  '/admin/pending-employers',
                  arguments: adminService,
                );
              },
            ),
            const SizedBox(height: 16),
            _DashboardButton(
              title: 'view_all_users'.tr(),
              onTap: () {
                Navigator.pushNamed(
                  context,
                  '/admin/all-users',
                  arguments: adminService,
                );
              },
            ),
            const SizedBox(height: 16),
            _DashboardButton(
              title: 'view_all_jobs'.tr(),
              onTap: () {
                Navigator.pushNamed(
                  context,
                  '/admin/job-listings',
                  arguments: adminService,
                );
              },
            ),
            const Spacer(),
            TextButton(
              onPressed: () => _logout(context),
              child: Text(
                tr('logout'),
                style: const TextStyle(
                  color: Colors.redAccent,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _DashboardButton extends StatelessWidget {
  final String title;
  final VoidCallback onTap;

  const _DashboardButton({required this.title, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onTap,
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFF0273B1),
        padding: const EdgeInsets.symmetric(vertical: 18),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 16,
          color: Colors.white,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
