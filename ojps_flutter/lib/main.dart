import 'package:flutter/material.dart';
import 'package:ojps_flutter/constants/colors.dart';
import 'package:ojps_flutter/constants/routes.dart';
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
      debugShowCheckedModeBanner: false,
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
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: whiteColor,
          labelStyle: TextStyle(color: secondaryTextColor),
          floatingLabelStyle: TextStyle(color: secondaryTextColor),
          hintStyle: TextStyle(color: secondaryTextColor),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey.shade300),
            borderRadius: BorderRadius.all(Radius.circular(8)),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: primaryColor),
            borderRadius: BorderRadius.all(Radius.circular(8)),
          ),
          border: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey.shade300),
            borderRadius: BorderRadius.all(Radius.circular(8)),
          ),
        ),
      ),
      //initialRoute: '/',
      //routes: appRoutes,
      home: MainScreen()
    );
  }
}