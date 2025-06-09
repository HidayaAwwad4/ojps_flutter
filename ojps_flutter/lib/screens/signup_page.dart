import 'package:flutter/material.dart';
import 'package:ojps_flutter/constants/colors.dart';
import 'package:ojps_flutter/constants/dimensions.dart';
import '../widgets/sign_up_form.dart';
import '../widgets/Login/SocialIconsWidget.dart';

class SignUpPage extends StatelessWidget {
  final int roleId;

  const SignUpPage({required this.roleId, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String type = roleId == 1 ? 'employer' : 'job-seeker';
    String topImage = type == 'employer' ? 'assets/employer_top.png' : 'assets/job_seeker_top.png';

    return Scaffold(
      backgroundColor: Colorss.whiteColor,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Image.asset(topImage, width: double.infinity, height: 250, fit: BoxFit.cover),
            Transform.translate(
              offset: const Offset(0, -60),
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppDimensions.defaultPadding,
                  vertical: AppDimensions.defaultPadding,
                ),
                decoration: BoxDecoration(
                  color: Colorss.whiteColor,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
                ),
                child: Column(
                  children: [
                    Center(
                      child: Image.asset(
                        'assets/app_logo.png',
                        height: 70,
                      ),
                    ),
                    SizedBox(height: AppDimensions.verticalSpacerLarge),

                    SignUpForm(roleId: roleId),

                    SizedBox(height: AppDimensions.verticalSpacerLarge),
                    Text('Or sign up with', style: TextStyle(color: Colorss.secondaryTextColor)),
                    SizedBox(height: AppDimensions.verticalSpacerSmall),
                    SocialIconsWidget(),

                    SizedBox(height: AppDimensions.verticalSpacerLarge),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Have an account?"),
                        TextButton(
                          onPressed: () => Navigator.pushNamed(context, '/Login'),
                          child: Text("Login", style: TextStyle(fontWeight: FontWeight.bold)),
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


