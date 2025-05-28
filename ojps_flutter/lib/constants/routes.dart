import 'package:flutter/material.dart';
import 'package:ojps_flutter/screens/splash_screen.dart';
import 'package:ojps_flutter/screens/home_screen.dart';
import 'package:ojps_flutter/screens/job_status_screen.dart';
import 'package:ojps_flutter/screens/saved_jobs_screen.dart';
import 'package:ojps_flutter/screens/job_details_job_seeker_screen.dart';
import 'package:ojps_flutter/screens/job_list_screen.dart';

final Map<String, WidgetBuilder> appRoutes = {
  '/': (context) => const SplashScreen(),
  '/home': (context) => const HomeScreen(),
  '/job_list': (context) => JobListScreen(categoryLabel: 'Your Category'),
  '/job_details': (context) => const JobDetailsJobSeekerScreen(),
  '/job_status': (context) => const JobStatusScreen(),
  '/saved_jobs': (context) => const SavedJobsScreen(),
};
