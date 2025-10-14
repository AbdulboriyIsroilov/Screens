import 'package:flutter/material.dart';
import 'package:screens/core/utils/app_style.dart';

import 'app_colors.dart';

class AppThemes {
  final lightTheme = ThemeData(
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
      primaryFixed: AppColors.white,
      onPrimaryFixed: AppColors.black,
      inversePrimary: AppColors.grey,
      onInverseSurface: AppColors.black,
    ),

    textTheme: TextTheme(
      displayMedium: AppStyles.w500s32,
      displaySmall: AppStyles.w500s12,
      labelMedium: AppStyles.w600s25,
      labelLarge: AppStyles.w600s20,
      bodyMedium: AppStyles.w600s16,
      bodyLarge: AppStyles.w500s16,
      bodySmall: AppStyles.w400s16,
    ),

    appBarTheme: AppBarTheme(
      backgroundColor: AppColors.white,
      titleTextStyle: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w600,
        color: AppColors.black,
      ),
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: AppColors.white,           // fon rangi
      selectedItemColor: AppColors.black,          // tanlangan icon yoki text rangi
      unselectedItemColor: AppColors.grey,         // tanlanmagan icon yoki text rangi
      showUnselectedLabels: true,                  // pastdagi label ko‘rinsin
      type: BottomNavigationBarType.fixed,         // bar elementlari harakatlanmasin
      elevation: 8,                                // soyasi
      selectedLabelStyle: AppStyles.w600s16,
      unselectedLabelStyle: AppStyles.w400s16,
    ),
  );

  final darkTheme = ThemeData(
    colorScheme: ColorScheme(
      brightness: Brightness.dark,
      primary: AppColors.white,
      onPrimary: AppColors.dark,
      secondary: AppColors.white,
      onSecondary: AppColors.dark,
      error: Colors.red,
      onError: Colors.yellow,
      surface: AppColors.dark,
      onSurface: AppColors.white,
      primaryFixed: AppColors.dark,
      onPrimaryFixed: AppColors.white,
      inversePrimary: AppColors.darkBorder,
      onInverseSurface: AppColors.darkBorder,
    ),

    textTheme: TextTheme(
      displayMedium: AppStyles.w500s32w,
      displaySmall: AppStyles.w500s12w,
      labelMedium: AppStyles.w600s25w,
      labelLarge: AppStyles.w600s20w,
      bodyMedium: AppStyles.w600s16w,
      bodyLarge: AppStyles.w500s16w,
      bodySmall: AppStyles.w400s16w,
    ),

    appBarTheme: AppBarTheme(
      backgroundColor: AppColors.dark,
      titleTextStyle: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w600,
        color: AppColors.white,
      ),
    ),

    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: AppColors.dark,           // fon rangi
      selectedItemColor: AppColors.black,          // tanlangan icon yoki text rangi
      unselectedItemColor: AppColors.darkBorder,   // tanlanmagan icon yoki text rangi
      showUnselectedLabels: true,                  // pastdagi label ko‘rinsin
      type: BottomNavigationBarType.fixed,         // bar elementlari harakatlanmasin
      elevation: 8,                                // soyasi
      selectedLabelStyle: AppStyles.w600s16w,
      unselectedLabelStyle: AppStyles.w400s16w,
    ),
  );
}
