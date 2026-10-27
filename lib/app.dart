import 'package:flutter/material.dart';
import 'screens/home_screen.dart';
import 'theme/app_theme.dart';

class BmiCalorieApp extends StatelessWidget {
  const BmiCalorieApp({super.key});

  @override
  Widget build(BuildContext context) => MaterialApp(
    title: 'BMI & Daily Calorie Calculator',
    debugShowCheckedModeBanner: false,
    theme: AppTheme.light,
    darkTheme: AppTheme.dark,
    themeMode: ThemeMode.system,
    home: const HomeScreen(),
  );
}
