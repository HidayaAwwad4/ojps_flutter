import 'package:flutter/material.dart';
import 'dart:convert';
import '../services/auth_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final Color primaryColor = const Color(0xFF0273B1);
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final AuthService _authService = AuthService();

  bool isLoading = false; // ✅ تم تعريف المتغير

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                ClipPath(
                  clipper: WaveClipper(),
                  child: Container(
                    height: screenHeight * 0.4,
                    width: double.infinity,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/img1.png'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: 20,
                  left: 0,
                  right: 0,
                  child: Center(
                    child: Image.asset(
                      'assets/app_logo.png',
                      height: 70,
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 8.0),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(height: 8),
                    Text(
                      'Log In',
                      style: TextStyle(
                        fontFamily: 'Carlito',
                        fontWeight: FontWeight.bold,
                        fontSize: 28,
                        letterSpacing: 1,
                        color: primaryColor,
                      ),
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      'Welcome back! Please login to your account.',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 16, color: Colors.black54),
                    ),
                    const SizedBox(height: 10),
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
                          Navigator.pushNamed(context, '/forget_password');
                        },
                        child: const Text(
                          'Forget Password?',
                          style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: double.infinity,
                      height: 45,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: primaryColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                        onPressed: isLoading
                            ? null
                            : () async {
                          if (!_formKey.currentState!.validate()) return;
                          setState(() {
                            isLoading = true;
                          });

                          final loginData = {
                            'email': emailController.text.trim(),
                            'password': passwordController.text.trim(),
                          };

                          try {
                            final response = await _authService.login(loginData);

                            if (response.statusCode == 200) {
                              final data = jsonDecode(response.body);
                              final token = data['token'];
                              final roleId = data['user']['role_id'];

                              final prefs = await SharedPreferences.getInstance();
                              await prefs.setString('token', token);
                              await prefs.setInt('role_id', roleId);

                              if (!context.mounted) return;

                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text('Login successful!')),
                              );

                              if (roleId == 1) {
                                Navigator.pushReplacementNamed(context, '/employer-home');
                              } else {
                                Navigator.pushReplacementNamed(context, '/home');
                              }
                            } else {
                              final error = jsonDecode(response.body);
                              final message = error['message'] ?? 'Login failed';

                              if (!context.mounted) return;

                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text(message), backgroundColor: Colors.red),
                              );
                            }
                          } catch (e) {
                            if (!context.mounted) return;

                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('Something went wrong: $e'),
                                backgroundColor: Colors.red,
                              ),
                            );
                          } finally {
                            if (mounted) {
                              setState(() {
                                isLoading = false;
                              });
                            }
                          }
                        },
                        child: isLoading
                            ? const Center(child: CircularProgressIndicator(color: Colors.white))
                            : const Text('Log In', style: TextStyle(color: Colors.white, fontSize: 16)),
                      ),
                    ),
                    const SizedBox(height: 20),
                    const Text("Or sign in with", style: TextStyle(color: Colors.black54)),
                    const SizedBox(height: 5),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _buildSocialIcon('assets/Fasebook.png'),
                        const SizedBox(width: 30),
                        _buildSocialIcon('assets/linkedin.png'),
                        const SizedBox(width: 30),
                        _buildSocialIcon('assets/google1.png'),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("Don't have an account?"),
                        TextButton(
                          onPressed: () {
                            Navigator.pushNamed(context, '/choose_type');
                          },
                          child: Text("Sign Up", style: TextStyle(color: primaryColor)),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
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
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: TextFormField(
        controller: controller,
        obscureText: obscureText,
        validator: validator,
        decoration: InputDecoration(
          prefixIcon: Icon(icon, color: primaryColor),
          labelText: label,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: primaryColor, width: 2.0),
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
    );
  }

  Widget _buildSocialIcon(String assetPath) {
    return GestureDetector(
      onTap: () {
        debugPrint("Tapped on $assetPath");
      },
      child: CircleAvatar(
        backgroundColor: Colors.white,
        radius: 22,
        child: Image.asset(
          assetPath,
          height: 24,
          width: 24,
        ),
      ),
    );
  }
}

class WaveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(0, size.height - 60);
    path.quadraticBezierTo(size.width * 0.25, size.height,
        size.width * 0.5, size.height - 40);
    path.quadraticBezierTo(size.width * 0.75, size.height - 80,
        size.width, size.height - 40);
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
