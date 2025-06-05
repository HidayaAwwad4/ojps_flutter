import 'package:flutter/material.dart';
import 'package:ojps_flutter/constants/colors.dart';
import 'package:ojps_flutter/constants/routes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'OJPS',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colorss.primaryColor,
        scaffoldBackgroundColor: Colorss.whiteColor,
        appBarTheme: AppBarTheme(
          backgroundColor: Colorss.primaryColor,
          foregroundColor: Colorss.whiteColor,
        ),
        colorScheme: ColorScheme.fromSwatch().copyWith(
          primary: Colorss.primaryColor,
          secondary: Colorss.customLightPurple,
          background: Colorss.lightBlueBackgroundColor,
          surface: Colorss.cardBackgroundColor,
          error: Colorss.closedColor,
          onPrimary: Colorss.whiteColor,
          onSecondary: Colorss.secondaryTextColor,
        ),
        textTheme: const TextTheme(
          bodyLarge: TextStyle(color: Colorss.primaryTextColor),
          bodyMedium: TextStyle(color: Colorss.secondaryTextColor),
        ),
      ),
      initialRoute: '/',
      routes: appRoutes, 
    );
  }
}