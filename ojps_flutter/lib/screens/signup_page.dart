import 'package:flutter/material.dart';
import 'Login_page.dart';

class SignUpPage extends StatefulWidget {
  final String selectedType;
  SignUpPage({required this.selectedType});

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final Color primaryColor = Color(0xFF0273B1);
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController companyController = TextEditingController();

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
              offset: Offset(0, -60),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      Image.asset('assets/app_logo.png', height: 70),
                      SizedBox(height: 10),
                      Text(
                        'Sign Up',
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        'Welcome! You are signing up as a ${widget.selectedType == 'employer' ? 'Employer' : 'Job Seeker'}.',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 16, color: Colors.black54),
                      ),
                      SizedBox(height: 20),


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

                      SizedBox(height: 30),
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
                              print("Signed up");
                            }
                          },
                          child: Text('Sign Up', style: TextStyle(color: Colors.white, fontSize: 16)),
                        ),
                      ),
                      SizedBox(height: 16),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Already have an account?"),
                          TextButton(
                            onPressed: () {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(builder: (context) => LoginPage()),
                              );
                            },
                            child: Text("Log in", style: TextStyle(color: primaryColor)),
                          ),
                        ],
                      ),
                      SizedBox(height: 30),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          _buildSocialIcon('assets/google1.png'),
                          SizedBox(width: 30),
                          _buildSocialIcon('assets/Fasebook.png'),
                          SizedBox(width: 30),
                          _buildSocialIcon('assets/linkedin.png'),
                        ],
                      ),
                      SizedBox(height: 30),
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
        validator: (value) => value == null || value.isEmpty ? 'Field required' : null,
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
}
