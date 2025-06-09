import 'dart:convert';
import 'package:flutter/material.dart';
import 'New Password.dart';
import '../../Services/auth_service.dart';
import 'package:ojps_flutter/constants/colors.dart';
import 'package:ojps_flutter/constants/dimensions.dart';
import 'package:ojps_flutter/constants/routes.dart';
class VerificationCodePage extends StatefulWidget {
  final String email;

  VerificationCodePage({required this.email});

  @override
  _VerificationCodePageState createState() => _VerificationCodePageState();
}

class _VerificationCodePageState extends State<VerificationCodePage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final List<TextEditingController> _controllers =
  List.generate(6, (_) => TextEditingController());

  final AuthService authService = AuthService();
  bool isLoading = false;

  @override
  void dispose() {
    for (var controller in _controllers) {
      controller.dispose();
    }
    super.dispose();
  }

  void _submit() async {
    if (!_formKey.currentState!.validate()) return;

    String code = _controllers.map((c) => c.text).join();

    setState(() => isLoading = true);

    try {
      final response = await authService.verifyForgotCode(widget.email, code);

      setState(() => isLoading = false);

      if (response.statusCode == 200) {
        // Assuming API returns success on valid code
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => NewPasswordPage(email: widget.email),
          ),
        );
      } else {
        String errorMsg = 'Invalid verification code.';
        if (response.body.isNotEmpty) {
          final jsonBody = jsonDecode(response.body);
          if (jsonBody['message'] != null) {
            errorMsg = jsonBody['message'];
          }
        }
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(errorMsg)),
        );
      }
    } catch (e) {
      setState(() => isLoading = false);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Connection error. Please try again later.')),
      );
    }
  }

  Widget _buildCodeField(int index) {
    return SizedBox(
      width: 45,
      child: TextFormField(
        controller: _controllers[index],
        keyboardType: TextInputType.number,
        textAlign: TextAlign.center,
        maxLength: 1,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return '';
          }
          return null;
        },
        decoration: InputDecoration(
          counterText: '',
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.blue),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.blue, width: 2),
          ),
        ),
        onChanged: (value) {
          if (value.length == 1 && index < 5) {
            FocusScope.of(context).nextFocus();
          } else if (value.isEmpty && index > 0) {
            FocusScope.of(context).previousFocus();
          }
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final Color primaryColor = Color(0xFF0273B1);

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          reverse: true,
          padding: EdgeInsets.only(
            left: 24,
            right: 24,
            top: 100,
            bottom: MediaQuery.of(context).viewInsets.bottom + 20,
          ),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Text(
                  'Enter the verification code',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 30,
                    color: primaryColor,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 20),
                Text(
                  'sent to your email',
                  style: TextStyle(color: primaryColor),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children:
                  List.generate(6, (index) => _buildCodeField(index)),
                ),
                SizedBox(height: 25),
                isLoading
                    ? CircularProgressIndicator(color: primaryColor)
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
                    onPressed: _submit,
                    child: Text(
                      'Send',
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

