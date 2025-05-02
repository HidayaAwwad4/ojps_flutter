import 'package:flutter/material.dart';

class SignUpPage extends StatefulWidget {
  final String selectedType;

  SignUpPage({required this.selectedType});

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final Color primaryColor = Color(0xFF0273B1);


  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController companyController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Sign Up',
                style: TextStyle(
                  fontFamily: 'Carlito',
                  fontWeight: FontWeight.bold,
                  fontSize: 28,
                  letterSpacing: 2,
                  color: primaryColor,
                ),
              ),
              SizedBox(height: 20),

              Text(
                'Welcome, ${nameController.text.isNotEmpty ? nameController.text : 'User'}! You are signing up as a ${widget.selectedType == 'employer' ? 'Employer' : 'Job Seeker'}.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black54,
                ),
              ),
              SizedBox(height: 20),

              if (widget.selectedType == 'employer') ...[
                _buildTextField('Company Name', companyController),
              ],
              _buildTextField('Name', nameController),
              _buildTextField('Email', emailController),
              _buildTextField('Password', passwordController, obscureText: true),
              SizedBox(height: 20),
              // زر التسجيل
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(double.infinity, 50),
                  backgroundColor: primaryColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                onPressed: () {
                  // إضافة منطق التسجيل بناءً على البيانات المدخلة
                  print('Name: ${nameController.text}');
                  print('Email: ${emailController.text}');
                  print('Password: ${passwordController.text}');
                  if (widget.selectedType == 'employer') {
                    print('Company: ${companyController.text}');
                  }
                },
                child: Text(
                  'Sign Up',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }


  Widget _buildTextField(
      String label,
      TextEditingController controller, {
        bool obscureText = false,
      }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextField(
        controller: controller,
        obscureText: obscureText,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
    );
  }
}
