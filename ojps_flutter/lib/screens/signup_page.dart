import 'package:flutter/material.dart';
import 'package:ojps_flutter/constants/colors.dart';
import 'package:ojps_flutter/constants/dimensions.dart';
import '../widgets/sign_up_form.dart';
import '../widgets/Login/SocialIconsWidget.dart';

class SignUpPage extends StatelessWidget {
  final String selectedType;

  const SignUpPage({required this.selectedType, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String type = selectedType.toLowerCase();
    String topImage = type == 'employer'
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
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(AppDimensions.radius20),
                  ),
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: AppDimensions.defaultPadding,
                  vertical: AppDimensions.paddingSmall,
                ),
                child: Column(
                  children: [
                    SignUpForm( selectedType: selectedType),
                    SizedBox(height: AppDimensions.verticalSpacerLarge),
                    const Text(
                      'Or sign up with',
                      style: TextStyle(color: Colors.black54),
                    ),
                    SizedBox(height: AppDimensions.verticalSpacerMedium),
                    SocialIconsWidget(),
                    SizedBox(height: AppDimensions.verticalSpacerMedium),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Have an account?",
                          style: TextStyle(color: Colorss.secondaryTextColor),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.pushNamed(context, '/Login');
                          },
                          child: Text(
                            "Login",
                            style: TextStyle(
                              color: Colorss.primaryColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
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
}
