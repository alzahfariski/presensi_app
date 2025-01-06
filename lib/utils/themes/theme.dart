import 'package:flutter/material.dart';
import 'package:presensi_app/utils/constants/color.dart';
import 'package:presensi_app/utils/themes/text_themes.dart';

class AAppTheme {
  AAppTheme._();

  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    fontFamily: 'Poppins',
    brightness: Brightness.light,
    primaryColor: AColors.primary,
    textTheme: ATextTheme.lightTextTheme,
    scaffoldBackgroundColor: Colors.white,
  );
}
