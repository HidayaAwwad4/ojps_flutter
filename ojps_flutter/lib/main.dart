import 'package:flutter/material.dart';
import 'package:ojps_flutter/screens/manage_resume.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Job Seeker App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const ManageResumeScreen(), // Change to employer screen if needed
    );
  }
}
