import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ojps_flutter/services/auth_service.dart';
import 'package:ojps_flutter/constants/dimensions.dart';
import 'package:ojps_flutter/constants/colors.dart';

class SignUpForm extends StatefulWidget {
  final int roleId;

  const SignUpForm({Key? key, required this.roleId}) : super(key: key);

  @override
  _SignUpFormState createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  final _formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final companyController = TextEditingController();
  final authService = AuthService();
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    final bool isEmployer = widget.roleId == 1;

    return Form(
      key: _formKey,
      child: Column(
        children: [
          if (isEmployer) ...[
            _buildTextField(
              label: 'Company Name',
              icon: Icons.business,
              controller: companyController,
            ),
            _buildTextField(
              label: 'Name',
              icon: Icons.person,
              controller: nameController,
            ),
          ] else
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
          SizedBox(height: 20),
          isLoading
              ? CircularProgressIndicator()
              : SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colorss.primaryColor,
                foregroundColor: Colors.white,
                padding: EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onPressed: _handleSignUp,
              child: Text(
                'Sign Up',
                style: TextStyle(fontSize: 16),
              ),
            ),
          ),
        ],
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
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        controller: controller,
        obscureText: isPassword,
        decoration: InputDecoration(
          prefixIcon: Icon(icon, color: Colorss.primaryColor),
          labelText: label,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        ),
        validator: (value) =>
        value == null || value.isEmpty ? 'Field is required' : null,
      ),
    );
  }

  void _handleSignUp() async {
    if (_formKey.currentState!.validate()) {
      setState(() => isLoading = true);

      final Map<String, dynamic> data = {
        'role_id': widget.roleId,
        'email': emailController.text.trim(),
        'password': passwordController.text,
        'password_confirmation': passwordController.text,
      };

      if (widget.roleId == 1) {
        data['company_name'] = companyController.text.trim();
        data['name'] = nameController.text.trim();
      } else {
        data['name'] = nameController.text.trim();
      }

      try {
        final response = await authService.register(data);
        final responseData = jsonDecode(response.body);

        if (response.statusCode == 200 || response.statusCode == 201) {
          if (widget.roleId == 1) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Your registration request has been sent to the admin for approval.')),
            );
            Navigator.pushNamed(context, '/Login');
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Registered successfully, logging in...')),
            );

            final loginResponse = await authService.login({
              'email': emailController.text.trim(),
              'password': passwordController.text,
            });

            if (loginResponse.statusCode == 200 || loginResponse.statusCode == 201) {
              final loginData = jsonDecode(loginResponse.body);
              final token = loginData['access_token'] ?? loginData['token'];
              final userRoleId = loginData['user']['role_id'] ?? widget.roleId;

              if (token != null) {
                final prefs = await SharedPreferences.getInstance();
                await prefs.setString('token', token);
                await prefs.setString('role_id', userRoleId.toString());

                if (!mounted) return;
                Navigator.pushReplacementNamed(context, '/home');
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Token not received')),
                );
              }
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Auto login failed')),
              );
            }
          }
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(responseData['message'] ?? 'Registration error')),
          );
        }
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('An error occurred: $e')),
        );
      } finally {
        setState(() => isLoading = false);
      }
    }
  }
}
