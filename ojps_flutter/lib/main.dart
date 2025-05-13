import 'package:flutter/material.dart';
import 'package:ojps_flutter/constants/colors.dart';
import 'package:ojps_flutter/screens/splash_screen.dart';
import 'package:ojps_flutter/screens/home_screen.dart';
import 'screens/Login_page.dart';
import 'package:ojps_flutter/screens/apply_now_screen.dart';
import 'package:ojps_flutter/screens/home_screen.dart';
import 'package:ojps_flutter/screens/job_details_job_seeker_screen.dart';
import 'package:ojps_flutter/screens/main_screen.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'OJPS',
      theme: ThemeData(
        primaryColor: primaryColor,
        scaffoldBackgroundColor: whiteColor,
        appBarTheme: AppBarTheme(
          backgroundColor: primaryColor,
          foregroundColor: whiteColor,
        ),
        colorScheme: ColorScheme.fromSwatch().copyWith(
          primary: primaryColor,
          secondary: customLightPurple,
          background: lightBlueBackgroundColor,
          surface: cardBackgroundColor,
          error: closedColor,
          onPrimary: whiteColor,
          onSecondary: secondaryTextColor,
        ),
        textTheme: const TextTheme(
          bodyLarge: TextStyle(color: primaryTextColor),
          bodyMedium: TextStyle(color: secondaryTextColor),
        ),
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const SplashScreen(),
        '/home': (context) => const HomeScreen(),
      },

    );
  }
}
