import 'package:flutter/material.dart';
import 'features/employer/screens/create_job_screen.dart';
import 'features/employer/screens/employer_home.dart';
import 'features/employer/screens/job_posting_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const EmployerHome(),
    );
  }
}
