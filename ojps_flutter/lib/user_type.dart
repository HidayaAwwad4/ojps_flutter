import 'package:flutter/material.dart';
import 'signup_page.dart';

class ChooseTypePage extends StatefulWidget {
  @override
  _ChooseTypePageState createState() => _ChooseTypePageState();
}

class _ChooseTypePageState extends State<ChooseTypePage> {
  String selectedType = '';
  final Color primaryColor = Color(0xFF0273B1);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Icon(Icons.arrow_back, color: primaryColor),
              ),
            ),
            Text(
              'HIRUZA',
              style: TextStyle(
                fontFamily: 'Carlito',
                fontWeight: FontWeight.bold,
                fontSize: 28,
                letterSpacing: 2,
                color: primaryColor,
              ),
            ),
            SizedBox(height: 16),
            Text(
              'Choose your Type',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 12),
              child: Text(
                'Choose the role that suits you to continue. This will help direct you to the tools and features made for your needs.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 14, color: Colors.black87),
              ),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildRoleOption(
                  icon: Icons.person,
                  title: 'To find an employee',
                  subtitle: 'To find an employee',
                  selected: selectedType == 'employer',
                  onTap: () => setState(() => selectedType = 'employer'),
                ),
                _buildRoleOption(
                  icon: Icons.work,
                  title: 'To find a job',
                  subtitle: 'Find and apply for jobs',
                  selected: selectedType == 'jobseeker',
                  onTap: () => setState(() => selectedType = 'jobseeker'),
                ),
              ],
            ),
            Spacer(),
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
                onPressed: selectedType.isNotEmpty
                    ? () {

                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SignUpPage(selectedType: selectedType),
                    ),
                  );
                }
                    : null,
                child: Text(
                  'Start Now!',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            )
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
        width: 130,
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: selected ? Color(0xFF0273B1).withOpacity(0.1) : Colors.white,
          border: Border.all(
            color: selected ? Color(0xFF0273B1) : Colors.grey.shade400,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          children: [
            Icon(icon, size: 40, color: selected ? Color(0xFF0273B1) : Colors.grey),
            SizedBox(height: 8),
            Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 12,
                color: selected ? Color(0xFF0273B1) : Colors.black,
              ),
            ),
            SizedBox(height: 4),
            Text(
              subtitle,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 10, color: Colors.black54),
            ),
          ],
        ),
      ),
    );
  }
}
