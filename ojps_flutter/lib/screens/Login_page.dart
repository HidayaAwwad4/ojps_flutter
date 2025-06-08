import 'package:flutter/material.dart';
import 'package:ojps_flutter/constants/colors.dart';
import 'package:ojps_flutter/constants/dimensions.dart';
import '../widgets/Login/LoginFormWidget.dart';
import '../widgets/Login/SocialIconsWidget.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

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

            const LoginFormWidget(),
            const SizedBox(height: AppDimensions.verticalSpacerMedium),
            const SocialIconsWidget(),
            const SizedBox(height: AppDimensions.verticalSpacerMedium),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Don't have an account?",
                  style: TextStyle(color: Colorss.secondaryTextColor),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/usertype');
                  },
                  child: Text(
                    "Sign Up",
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
