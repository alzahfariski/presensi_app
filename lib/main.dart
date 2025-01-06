import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:presensi_app/screens/welcome_screen.dart';
import 'package:presensi_app/utils/themes/theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'presensi_app',
      themeMode: ThemeMode.light,
      theme: AAppTheme.lightTheme,
      debugShowCheckedModeBanner: false,
      home: const WelcomeScreen(),
    );
  }
}
