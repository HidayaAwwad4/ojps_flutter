/*import 'package:flutter/material.dart';
import 'package:ojps_flutter/screens/job_applicants_employer.dart';
import 'models/applicant_model.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Job Applicants',
      //home: JobApplicantsScreen(applicants: applicants),
    );
  }

}

*/

import 'package:flutter/material.dart';
import 'package:ojps_flutter/screens/job_details_job_seeker_screen.dart';
import 'package:ojps_flutter/screens/job_list_screen.dart';
import 'package:ojps_flutter/screens/main_screen.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MainScreen(),
      //home: JobListScreen(),
      //home: JobDetailsJopSeekerScreen(),
    );
  }
}