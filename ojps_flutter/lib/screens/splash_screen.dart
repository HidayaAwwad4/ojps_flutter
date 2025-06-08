import 'dart:async';
import 'package:flutter/material.dart';
import 'package:ojps_flutter/screens/home_screen.dart';
import 'package:ojps_flutter/constants/colors.dart';
import 'package:ojps_flutter/constants/text_styles.dart';
import 'package:ojps_flutter/screens/view&edit_profile_seeker.dart';

import 'employer_home.dart';
import 'main_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late AnimationController _logoController;
  late Animation<double> _scaleAnimation;
  late Animation<double> _fadeAnimation;

  late AnimationController _textController;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _textFadeAnimation;

  @override
  void initState() {
    super.initState();

    _logoController = AnimationController(
      duration: AppValues.logoAnimationDuration,
      vsync: this,
    );

    _scaleAnimation = Tween<double>(
      begin: AppValues.logoScaleBegin,
      end: AppValues.logoScaleEnd,
    ).animate(
      CurvedAnimation(parent: _logoController, curve: Curves.easeOutBack),
    );

    _fadeAnimation = Tween<double>(
      begin: AppValues.fadeBegin,
      end: AppValues.fadeEnd,
    ).animate(
      CurvedAnimation(parent: _logoController, curve: Curves.easeIn),
    );

    _textController = AnimationController(
      duration: AppValues.textAnimationDuration,
      vsync: this,
    );

    _slideAnimation = Tween<Offset>(
      begin: Offset(0, AppValues.textSlideBeginY),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(parent: _textController, curve: Curves.easeOut),
    );

    _textFadeAnimation = Tween<double>(
      begin: AppValues.fadeBegin,
      end: AppValues.fadeEnd,
    ).animate(
      CurvedAnimation(parent: _textController, curve: Curves.easeIn),
    );

    _logoController.forward().whenComplete(() => _textController.forward());

    Timer(AppValues.splashScreenDuration, () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const ViewEditSeekerProfile()),
      );
    });
  }

  @override
  void dispose() {
    _logoController.dispose();
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colorss.lightBlueBackgroundColor,
              Colorss.customLightPurple,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FadeTransition(
                opacity: _fadeAnimation,
                child: ScaleTransition(
                  scale: _scaleAnimation,
                  child: Container(
                    width: AppValues.logoSize,
                    height: AppValues.logoSize,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colorss.whiteColor.withOpacity(AppValues.logoShadowOpacity),
                          blurRadius: AppValues.logoShadowBlurRadius,
                          spreadRadius: AppValues.logoShadowSpreadRadius,
                        ),
                      ],
                    ),
                    child: Image.asset(
                      'assets/app_logo.png',
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              ),
              SizedBox(height: AppValues.spaceBetweenLogoAndText),
              FadeTransition(
                opacity: _textFadeAnimation,
                child: SlideTransition(
                  position: _slideAnimation,
                  child: Text(
                    "Find Your Dream Job",
                    style: TextStyle(
                      fontSize: AppValues.splashTextFontSize,
                      color: Colorss.primaryColor,
                      fontWeight: FontWeight.bold,
                      letterSpacing: AppValues.splashTextLetterSpacing,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

