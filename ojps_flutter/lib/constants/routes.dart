import 'package:flutter/material.dart';
import 'package:ojps_flutter/screens/Login_page.dart';
import 'package:ojps_flutter/screens/employer_home.dart';
import 'package:ojps_flutter/screens/splash_screen.dart';
import 'package:ojps_flutter/screens/home_screen.dart';
import 'package:ojps_flutter/screens/job_status_screen.dart';
import 'package:ojps_flutter/screens/saved_jobs_screen.dart';
import 'package:ojps_flutter/screens/job_details_job_seeker_screen.dart';
import 'package:ojps_flutter/screens/job_list_screen.dart';
import '../screens/Forgetpassword.dart';
import '../screens/signup_page.dart';
import '../screens/user_type.dart';

final Map<String, WidgetBuilder> appRoutes = {
  '/': (context) => const LoginPage(),
  '/forget_password': (context) =>const  ForgetPasswordPage(),
  '/choose_type': (context) =>const  ChooseType(),
  '/home': (context) => const HomeScreen(),
  '/employer-home': (context) => const EmployerHome(),
  '/job_list': (context) => JobListScreen(categoryLabel: 'Your Category'),
  '/job_details': (context) => const JobDetailsJobSeekerScreen(),
  '/job_status': (context) => const JobStatusScreen(),
  '/saved_jobs': (context) => const SavedJobsScreen(),
  '/sign_up': (context) => const SignUpPage(selectedType: ''),

};
