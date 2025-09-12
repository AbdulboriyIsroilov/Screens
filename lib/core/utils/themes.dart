import 'package:flutter/material.dart';

import 'app_colors.dart';

class AppThemes {
  final lightTheme = ThemeData(
    // scaffoldBackgroundColor: AppColors.white,
    colorScheme: ColorScheme(
      brightness: Brightness.light,
      primary: AppColors.black,
      onPrimary: AppColors.white,
      secondary: AppColors.white,
      onSecondary: AppColors.black,
      error: Colors.red,
      onError: Colors.yellow,
      surface: AppColors.white,
      onSurface: AppColors.black,
    ),

    textTheme: TextTheme(
    ),

    appBarTheme: AppBarTheme(
      backgroundColor: AppColors.white,
      titleTextStyle: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w600,
        color: AppColors.black,
      ),
    ),
  );

  final darkTheme = ThemeData(
    // scaffoldBackgroundColor: AppColors.backgroundColor,
    colorScheme: ColorScheme(
      brightness: Brightness.dark,
      primary: AppColors.white,
      onPrimary: AppColors.black,
      secondary: AppColors.white,
      onSecondary: AppColors.black,
      error: Colors.red,
      onError: Colors.yellow,
      surface: AppColors.black,
      onSurface: AppColors.white,
    ),

    textTheme: TextTheme(
    ),

    appBarTheme: AppBarTheme(
      backgroundColor: AppColors.black,
      titleTextStyle: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w600,
        color: AppColors.white,
      ),
    ),
  );
}
