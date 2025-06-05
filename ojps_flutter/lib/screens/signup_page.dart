import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:ojps_flutter/Services/auth_service.dart';
import 'login_page.dart';

class SignUpPage extends StatefulWidget {
  final String selectedType;
  const SignUpPage({Key? key, required this.selectedType}) : super(key: key);

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final Color primaryColor = const Color(0xFF0273B1);
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController companyController = TextEditingController();

  final AuthService authService = AuthService();

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    String topImage = widget.selectedType == 'employer'
        ? 'assets/employer_top.png'
        : 'assets/job_seeker_top.png';

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                Image.asset(
                  topImage,
                  width: double.infinity,
                  height: 250,
                  fit: BoxFit.cover,
                ),
              ],
            ),
            Transform.translate(
              offset: const Offset(0, -60),
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
                ),
                padding:
                const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      Image.asset('assets/app_logo.png', height: 70),
                      const SizedBox(height: 10),
                      Text(
                        'Sign Up',
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        'Welcome! You are signing up as a ${widget.selectedType == 'employer' ? 'Employer' : 'Job Seeker'}.',
                        textAlign: TextAlign.center,
                        style:
                        const TextStyle(fontSize: 16, color: Colors.black54),
                      ),
                      const SizedBox(height: 20),

                      if (widget.selectedType == 'employer')
                        _buildTextField(
                          label: 'Company Name',
                          icon: Icons.business,
                          controller: companyController,
                        ),
                      if (widget.selectedType != 'employer')
                        _buildTextField(
                          label: 'Name',
                          icon: Icons.person,
                          controller: nameController,
                        ),
                      _buildTextField(
                        label: 'Email',
                        icon: Icons.email,
                        controller: emailController,
                      ),
                      _buildTextField(
                        label: 'Password',
                        icon: Icons.lock,
                        controller: passwordController,
                        isPassword: true,
                      ),
                      const SizedBox(height: 30),

                      isLoading
                          ? const CircularProgressIndicator()
                          : SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: primaryColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                          ),
                          onPressed: _submitSignUp,
                          child: const Text('Sign Up',
                              style: TextStyle(
                                  color: Colors.white, fontSize: 16)),
                        ),
                      ),

                      const SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text("Already have an account?"),
                          TextButton(
                            onPressed: () {
                              Navigator.pushReplacementNamed(context, '/');
                            },
                            child: Text("Log in", style: TextStyle(color: primaryColor)),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          _buildSocialIcon('assets/google1.png'),
                          const SizedBox(width: 30),
                          _buildSocialIcon('assets/Fasebook.png'),
                          const SizedBox(width: 30),
                          _buildSocialIcon('assets/linkedin.png'),
                        ],
                      ),
                      const SizedBox(height: 30),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField({
    required String label,
    required IconData icon,
    required TextEditingController controller,
    bool isPassword = false,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: TextFormField(
        controller: controller,
        obscureText: isPassword,
        decoration: InputDecoration(
          prefixIcon: Icon(icon, color: primaryColor),
          labelText: label,
          filled: true,
          fillColor: Colors.grey[100],
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide.none,
          ),
        ),
        validator: (value) =>
        value == null || value.isEmpty ? 'Field required' : null,
      ),
    );
  }

  Widget _buildSocialIcon(String assetPath) {
    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.grey[200],
      ),
      child: IconButton(
        icon: Image.asset(assetPath),
        onPressed: () {},
      ),
    );
  }

  void _submitSignUp() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      isLoading = true;
    });

    Map<String, dynamic> data = {
      'email': emailController.text.trim(),
      'password': passwordController.text.trim(),
      'password_confirmation': passwordController.text.trim(),
      'role_id': widget.selectedType == 'employer' ? 1 : 2,
    };

    if (widget.selectedType == 'employer') {
      data['company_name'] = companyController.text.trim();
    } else {
      data['name'] = nameController.text.trim();
    }

    try {
      final response = await authService.register(data);

      if (response.statusCode == 201 || response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Registration successful!')),
        );

        // نقل حسب النوع باستخدام Named Routes
        if (widget.selectedType == 'employer') {
          Navigator.pushReplacementNamed(context, '/employer-home');
        } else {
          Navigator.pushReplacementNamed(context, '/home');
        }
      } else {
        final errorData = jsonDecode(response.body);
        String message = errorData['message'] ?? 'Registration failed';
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(message)),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    } finally {
      if (mounted) {
        setState(() {
          isLoading = false;
        });
      }
    }
  }
}
