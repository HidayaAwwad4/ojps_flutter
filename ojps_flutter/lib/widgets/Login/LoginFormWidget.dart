import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '../../Services/auth_service.dart';
import '../../screens/Forgetpassword.dart';
import 'package:ojps_flutter/constants/colors.dart';
import 'package:ojps_flutter/constants/dimensions.dart';
import 'package:ojps_flutter/constants/routes.dart';
import 'dart:io';

import '../../screens/home_screen.dart';
import '../../screens/main_screen.dart';
class LoginFormWidget extends StatefulWidget {
  const LoginFormWidget({Key? key}) : super(key: key);

  @override
  _LoginFormWidgetState createState() => _LoginFormWidgetState();
}

class _LoginFormWidgetState extends State<LoginFormWidget> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final AuthService _authService = AuthService();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Padding(
        padding: EdgeInsets.all(AppDimensions.defaultPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: AppDimensions.verticalSpacerSmall),
            Text(
              'Log In',
              style: TextStyle(
                fontFamily: 'Carlito',
                fontWeight: FontWeight.bold,
                fontSize: 28,
                letterSpacing: 1,
                color: Colorss.primaryColor,
              ),
            ),
            SizedBox(height: AppDimensions.verticalSpacerSmall),
            Text(
              'Welcome back! Please login to your account.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: AppDimensions.fontSizeNormal,
                color: Colorss.secondaryTextColor,
              ),
            ),
            SizedBox(height: AppDimensions.verticalSpacerMedium),
            _buildTextFormField(
              label: 'Email',
              icon: Icons.email,
              controller: emailController,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your email';
                } else if (!value.contains('@')) {
                  return 'Email must contain @';
                }
                return null;
              },
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildTextFormField(
                  label: 'Password',
                  icon: Icons.lock,
                  controller: passwordController,
                  obscureText: true,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your password';
                    } else if (value.length < 6) {
                      return 'Password must be at least 6 characters';
                    }
                    return null;
                  },
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => ForgetPasswordPage()),
                      );
                    },
                    child: Text(
                      'Forget Password?',
                      style: TextStyle(
                        color: Colorss.closedColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              width: double.infinity,
              height: AppDimensions.minimumSizeButton,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colorss.primaryColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(AppDimensions.borderRadiusLarge),
                  ),
                ),
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    try {
                      final response = await _authService.login({
                        'email': emailController.text,
                        'password': passwordController.text,
                      });
                      print('statusCode: ${response.statusCode}');
                      print('body: ${response.body}');
                      if (response.statusCode == 200) {
                        final data = jsonDecode(response.body);
                        final token = data['access_token'];

                        final prefs = await SharedPreferences.getInstance();
                        await prefs.setString('token', token);

                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Login successful')),
                        );
                        if (!mounted) return;
                        Navigator.pushReplacementNamed(context, '/employer/main-screen');





                      } else {
                        final error = jsonDecode(response.body);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text(error['message'] ?? 'Login failed')),
                        );
                      }
                    } on SocketException {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("No internet connection. Please check your network.")),
                      );
                    } on HttpException catch (e) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("HTTP error: ${e.message}")),
                      );
                    } on FormatException {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("Invalid response format. Unable to parse data.")),
                      );
                    } catch (e) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("An unexpected error occurred: $e")),
                      );
                    }
                  }
                },
                child: Text(
                  'Log In',
                  style: TextStyle(
                    color: Colorss.whiteColor,
                    fontSize: AppDimensions.fontSizeNormal,
                  ),
                ),
              ),
            ),
            SizedBox(height: AppDimensions.verticalSpacerLarge),
          ],
        ),
      ),
    );
  }

  Widget _buildTextFormField({
    required String label,
    required IconData icon,
    required TextEditingController controller,
    required String? Function(String?) validator,
    bool obscureText = false,
  }) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: AppDimensions.verticalSpacerSmall),
      child: TextFormField(
        controller: controller,
        obscureText: obscureText,
        validator: validator,
        decoration: InputDecoration(
          prefixIcon: Icon(icon, color: Colorss.primaryColor),
          labelText: label,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(AppDimensions.borderRadius),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colorss.primaryColor, width: 2.0),
            borderRadius: BorderRadius.circular(AppDimensions.borderRadius),
          ),
        ),
      ),
    );
  }
}
