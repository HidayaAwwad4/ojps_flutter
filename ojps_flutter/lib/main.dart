import 'package:flutter/material.dart';
import 'package:ojps_flutter/screens/job_applicants_employer.dart';
import 'models/applicant_model.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Job Applicants',
      home: JobApplicantsScreen(applicants: _applicants),
    );
  }

  final List<Applicant> _applicants = [
    Applicant(
      id: '1',
      name: 'Layla Ahmad',
      email: 'layla.ahmad@example.com',
      appliedAt: DateTime(2025, 5, 9),
      status: 'pending',
      imageUrl: 'assets/sara.jpg',
      resume: 'I am a software developer with 5 years of experience...',
    ),
    Applicant(
      id: '2',
      name: 'Omar Khaled',
      email: 'omar.khaled@example.com',
      appliedAt: DateTime(2025, 5, 8),
      status: 'pending',
      resume: 'Looking forward to contributing to your team...',
    ),
    Applicant(
      id: '3',
      name: 'Sara Youssef',
      email: 'sara.youssef@example.com',
      appliedAt: DateTime(2025, 5, 7),
      status: 'accepted',
      imageUrl: 'assets/sara.jpg',
      resume: 'Extensive experience in project management...',
    ),
  ];
}
