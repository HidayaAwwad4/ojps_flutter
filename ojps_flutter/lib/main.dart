import 'package:flutter/material.dart';
import 'screens/Login_page.dart';
import 'package:ojps_flutter/screens/apply_now_screen.dart';
import 'package:ojps_flutter/screens/home_screen.dart';
import 'package:ojps_flutter/screens/job_details_job_seeker_screen.dart';
import 'package:ojps_flutter/screens/main_screen.dart';
import 'package:ojps_flutter/screens/Login_page.dart';
import 'package:ojps_flutter/screens/Forgetpassword.dart';
import 'package:ojps_flutter/screens/user_type.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => LoginPage(),
        '/forgetPassword': (context) => ForgetPasswordPage(),
        '/chooseType': (context) => ChooseType(),
      },

    );
  }
}
