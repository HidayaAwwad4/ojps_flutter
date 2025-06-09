import 'package:flutter/material.dart';
import 'signup_page.dart';

class ChooseType extends StatefulWidget {
  @override
  _ChooseTypeState createState() => _ChooseTypeState();
}

class _ChooseTypeState extends State<ChooseType> {
  int? roleId;
  final Color primaryColor = Color(0xFF0273B1);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            SizedBox(height: 100),
            Image.asset('assets/app_logo.png', height: 70),
            SizedBox(height: 50),
            Text(
              'Choose your Type',
              style: TextStyle(
                fontSize: 36,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 12),
              child: Text(
                'Choose the role that suits you to continue.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 15, color: Colors.black87),
              ),
            ),
            SizedBox(height: 50),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildRoleOption(
                  icon: Icons.person,
                  title: 'To find an employee',
                  subtitle: 'Employer',
                  selected: roleId == 1,
                  onTap: () => setState(() => roleId = 1),
                ),
                _buildRoleOption(
                  icon: Icons.work,
                  title: 'To find a job',
                  subtitle: 'Job Seeker',
                  selected: roleId == 2,
                  onTap: () => setState(() => roleId = 2),
                ),
              ],
            ),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(double.infinity, 50),
                  backgroundColor: primaryColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                onPressed: roleId != null
                    ? () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SignUpPage(roleId: roleId!),
                    ),
                  );
                }
                    : null,
                child: Text('Start Now!', style: TextStyle(color: Colors.white)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRoleOption({
    required IconData icon,
    required String title,
    required String subtitle,
    required bool selected,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 150,
        height: 200,
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: selected ? primaryColor.withOpacity(0.1) : Colors.white,
          border: Border.all(
            color: selected ? primaryColor : Colors.grey.shade400,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 40, color: selected ? primaryColor : Colors.grey),
            SizedBox(height: 10),
            Text(title,
                textAlign: TextAlign.center,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: selected ? primaryColor : Colors.black)),
            SizedBox(height: 8),
            Text(subtitle,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 15, color: Colors.black54)),
          ],
        ),
      ),
    );
  }
}
