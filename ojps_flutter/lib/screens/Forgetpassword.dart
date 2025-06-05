import 'package:flutter/material.dart';
import 'VerificationCode.dart';

class ForgetPasswordPage extends StatefulWidget {
  const ForgetPasswordPage({super.key});
  @override
  _ForgetPasswordPageState createState() => _ForgetPasswordPageState();
}

class _ForgetPasswordPageState extends State<ForgetPasswordPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final Color primaryColor = Color(0xFF0273B1);

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
                    height: screenHeight * 0.45,
                    width: double.infinity,
                    color: primaryColor.withOpacity(0.9),
                  ),
                ),
                Positioned(
                  top: screenHeight * 0.3,
                  left: 0,
                  right: 0,
                  child: Center(
                    child: Text(
                      'Forgot your password?',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 28,
                      ),
                    ),
                  ),
                ),
              ],
            ),


            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30.0),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    Text(
                      'Enter your email and we will send you a random code to reset your password.',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: primaryColor, fontSize: 18),
                    ),
                    SizedBox(height: 80),
                    TextFormField(
                      controller: emailController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your email';
                        } else if (!value.contains('@')) {
                          return 'Email must contain @';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        hintText: 'Enter your email',
                        contentPadding: EdgeInsets.symmetric(vertical: 16, horizontal: 20),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: BorderSide(color: primaryColor),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: BorderSide(color: primaryColor, width: 2),
                        ),
                      ),
                    ),
                    SizedBox(height: 35),
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: primaryColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => VerificationCodePage(),
                              ),
                            );
                          }
                        },
                        child: Text(
                          'Send',
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: Colors.white),
                        ),
                      ),
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
}


class WaveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(0, size.height - 60);
    path.quadraticBezierTo(
      size.width * 0.25, size.height,
      size.width * 0.5, size.height - 40,
    );
    path.quadraticBezierTo(
      size.width * 0.75, size.height - 80,
      size.width, size.height - 40,
    );
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
