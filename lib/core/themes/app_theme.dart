import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nasmobile/core/constants/app_dimension.dart';
import 'package:nasmobile/core/themes/app_colors.dart';

class AppTheme {
  AppTheme._();

  static final ThemeData themeData = ThemeData(
    useMaterial3: false,
    fontFamily: GoogleFonts.openSans().fontFamily,
    scaffoldBackgroundColor: Colors.white,
    primaryColor: AppColors.pink600,
    primarySwatch: const MaterialColor(
      0xffFF0092,
      <int, Color>{
        50: AppColors.pink600,
        100: AppColors.pink600,
        200: AppColors.pink600,
        300: AppColors.pink600,
        400: AppColors.pink600,
        500: AppColors.pink600,
        600: AppColors.pink600,
        700: AppColors.pink600,
        800: AppColors.pink600,
        900: AppColors.pink600,
      },
    ),
    brightness: Brightness.light,
    inputDecorationTheme: const InputDecorationTheme(
      errorStyle: TextStyle(
        fontSize: AppDimension.mediumFontSize,
        fontWeight: FontWeight.w400,
        color: AppColors.errorColor,
      ),
    ),
  );
}
