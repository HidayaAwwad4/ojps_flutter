import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:ojps_flutter/constants/colors.dart';
import 'package:ojps_flutter/constants/routes.dart';
import 'package:ojps_flutter/providers/employer_jobs_provider.dart';
import 'package:ojps_flutter/services/job_service.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => EmployerJobsProvider(jobService: JobService()),
      child: const MyApp(),
    ),
  );
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
          onSecondary: Colorss.blackColor,
        ),
        textTheme: const TextTheme(
          bodyLarge: TextStyle(color: Colorss.primaryTextColor),
          bodyMedium: TextStyle(color: Colorss.secondaryTextColor),
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: Colorss.whiteColor,
          labelStyle: TextStyle(color: Colorss.secondaryTextColor),
          floatingLabelStyle: TextStyle(color: Colorss.secondaryTextColor),
          hintStyle: TextStyle(color: Colorss.secondaryTextColor),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey.shade300),
            borderRadius: const BorderRadius.all(Radius.circular(8)),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colorss.primaryColor),
            borderRadius: const BorderRadius.all(Radius.circular(8)),
          ),
          border: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey.shade300),
            borderRadius: const BorderRadius.all(Radius.circular(8)),
          ),
        ),
      ),
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('en', ''),
        Locale('ar', ''),
      ],
      locale: const Locale('en'),
      localeResolutionCallback: (locale, supportedLocales) {
        if (locale == null) return supportedLocales.first;

        for (var supportedLocale in supportedLocales) {
          if (supportedLocale.languageCode == locale.languageCode) {
            return supportedLocale;
          }
        }
        return supportedLocales.first;
      },
      initialRoute: '/',
      routes: appRoutes,
    );
  }
}
