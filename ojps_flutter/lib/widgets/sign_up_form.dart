import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ojps_flutter/services/auth_service.dart';
import 'package:ojps_flutter/constants/dimensions.dart';
import 'package:ojps_flutter/constants/colors.dart';

class SignUpForm extends StatefulWidget {
  final String selectedType;

  const SignUpForm({Key? key, required this.selectedType}) : super(key: key);

  @override
  _SignUpFormState createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController companyController = TextEditingController();
  final AuthService authService = AuthService();

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          Image.asset('assets/app_logo.png', height: AppDimensions.iconSizeLarge),
          const SizedBox(height: AppDimensions.verticalSpacerSmall),
          Text(
            'Sign Up',
            style: TextStyle(
              fontSize: AppDimensions.fontSizeLarge,
              fontWeight: FontWeight.bold,
              color: Colorss.primaryColor,
            ),
          ),
          const SizedBox(height: AppDimensions.verticalSpacerSmall),
          Text(
            'Welcome! You are signing up as a ${widget.selectedType == 'employer' ? 'Employer' : 'Job Seeker'}.',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: AppDimensions.fontSizeNormal,
              color: Colors.black54,
            ),
          ),
          const SizedBox(height: AppDimensions.verticalSpacerLarge),

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

          const SizedBox(height: AppDimensions.verticalSpacerLarge),

          isLoading
              ? const CircularProgressIndicator()
              : SizedBox(
            width: double.infinity,
            height: AppDimensions.containerHeight,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colorss.primaryColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(AppDimensions.borderRadius),
                ),
              ),
              onPressed: _handleSignUp,
              child: Text(
                'Sign Up',
                style: TextStyle(
                  color: Colorss.whiteColor,
                  fontSize: AppDimensions.fontSizeNormal,
                ),
              ),
            ),
          ),
          const SizedBox(height: AppDimensions.verticalSpacerMedium),
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
      padding: const EdgeInsets.symmetric(
        vertical: AppDimensions.verticalSpacerSmall,
      ),
      child: TextFormField(
        controller: controller,
        obscureText: isPassword,
        decoration: InputDecoration(
          prefixIcon: Icon(icon, color: Colorss.primaryColor),
          labelText: label,
          filled: true,
          fillColor: Colors.grey[100],
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(AppDimensions.borderRadius),
            borderSide: BorderSide.none,
          ),
        ),
        validator: (value) => value == null || value.isEmpty ? 'Field required' : null,
      ),
    );
  }

  void _handleSignUp() async {
    if (_formKey.currentState!.validate()) {
      setState(() => isLoading = true);

      final String type = widget.selectedType;
      final int roleId = type == 'job-seeker' ? 1 : 2;

      Map<String, dynamic> data = {
        'type': type,
        'role_id': roleId,
        'email': emailController.text.trim(),
        'password': passwordController.text,
        'password_confirmation': passwordController.text,
      };

      if (type == 'employer') {
        data['company_name'] = companyController.text.trim();
      } else {
        data['name'] = nameController.text.trim();
      }

      try {
        final response = await authService.register(data);

        if (response.statusCode == 200 || response.statusCode == 201) {
          final responseData = jsonDecode(response.body);
          final token = responseData['access_token'];


          final prefs = await SharedPreferences.getInstance();
          await prefs.setString('token', token);
          await prefs.setString('role', type);

          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Registration successful!')),
          );

          if (type == 'job-seeker') {
            Navigator.pushReplacementNamed(context, '/home');
          } else {
            Navigator.pushReplacementNamed(context, '/employer/main-screen');
          }
        } else {
          final error = jsonDecode(response.body);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(error['message'] ?? 'Registration failed')),
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
