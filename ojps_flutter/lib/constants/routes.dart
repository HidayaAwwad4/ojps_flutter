import 'package:flutter/material.dart';
import 'package:ojps_flutter/screens/splash_screen.dart';
import 'package:ojps_flutter/screens/home_screen.dart';
import 'package:ojps_flutter/screens/job_status_screen.dart';
import 'package:ojps_flutter/screens/saved_jobs_screen.dart';
import 'package:ojps_flutter/screens/job_details_job_seeker_screen.dart';
import 'package:ojps_flutter/screens/job_list_screen.dart';

import '../models/job_model.dart';
import '../screens/applicant_details.dart';
import '../screens/create_job_screen.dart';
import '../screens/edit_job_screen.dart';
import '../screens/employer_home.dart';
import '../screens/job_applicants_employer.dart';
import '../screens/job_details_for_employer.dart';
import '../screens/job_posting_screen.dart';
import '../screens/main_screen.dart';
import '../screens/manage_resume.dart';
import '../screens/notifications.dart';
import '../screens/view&edit_profile_seeker.dart';
import '../screens/view_edit_employer_profile.dart';
import '../screens/view_profile.dart';
import '../screens/view_resume.dart';

final Map<String, WidgetBuilder> appRoutes = {
  '/': (context) => const SplashScreen(),
  '/home': (context) => const HomeScreen(),
  '/job_list': (context) => JobListScreen(categoryLabel: 'Your Category'),
  '/job_details': (context) => const JobDetailsJobSeekerScreen(),
  '/job_status': (context) => const JobStatusScreen(),
  '/saved_jobs': (context) => const SavedJobsScreen(),
  '/view_profile_employer':(context)=> const ViewEditEmployerProfile(),
  '/view_profile_seeker':(context)=> const ViewEditSeekerProfile(),
  '/view_seeker_profile_employer':(context)=> const  ViewProfile(),
  '/view_resume':(context)=> const ViewResumeScreen(),
  '/manage_resume':(context)=> const ManageResumeScreen(),
  '/notifications':(context)=> const Notifications(),
  '/employer/main-screen': (context) {
    final initialIndex = ModalRoute.of(context)!.settings.arguments as int? ?? 0;
    return MainScreen(initialIndex: initialIndex);
  },
  '/employer-home': (context) => const EmployerHome(),
  '/employer/create-job': (context) => const CreateJobScreen(),
  '/employer/edit-job': (context) {
    final job = ModalRoute.of(context)!.settings.arguments as Job;
    return EditJobScreen(job: job);
  },
  '/employer/job-details': (context) {
    final job = ModalRoute.of(context)!.settings.arguments as Job;
    return JobDetailsScreen(job: job);
  },
  '/employer/job-applicants': (context) {
    final jobId = ModalRoute.of(context)!.settings.arguments as int;
    return JobApplicantsScreen(jobId: jobId);
  },
  '/employer/applicant-details': (context) {
    final applicantId = ModalRoute.of(context)!.settings.arguments as int;
    return ApplicantDetailsScreen(applicantId: applicantId);
  },
  '/employer/job-posting': (context) {
    final tabIndex = ModalRoute.of(context)!.settings.arguments as int;
    return JobPostingScreen(tabIndex: tabIndex);
  },
};
