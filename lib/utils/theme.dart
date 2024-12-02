import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'constants.dart';

class AppTheme {
  static ThemeData lightTheme = ThemeData(
    // Using ColorScheme for primary, secondary, background, etc.
    colorScheme: ColorScheme.light(
      primary: AppColors.primaryColor,
      secondary: AppColors.accentColor,
      onPrimary: Colors.white,  // Text color on primary
      onSecondary: Colors.white, // Text color on secondary
      background: AppColors.backgroundColor,
      onBackground: Colors.black, // Text color on background
      surface: Colors.white,
      onSurface: Colors.black,
    ),

    // Main Background Color for Scaffold
    scaffoldBackgroundColor: AppColors.backgroundColor,

    // AppBar Theme
    appBarTheme: AppBarTheme(
      color: AppColors.primaryColor,
      elevation: 4,
      iconTheme: IconThemeData(color: Colors.white),
      titleTextStyle: TextStyle(
        fontSize: AppTextStyles.headingFontSize,
        color: Colors.white,
        fontWeight: FontWeight.bold,
      ),
    ),

    // Text Styles (Updated for new Flutter version)
    textTheme: TextTheme(
      bodyLarge: TextStyle(
        fontSize: AppTextStyles.bodyFontSize,
        color: Colors.black,
      ),
      bodyMedium: TextStyle(
        fontSize: AppTextStyles.bodyFontSize,
        color: Colors.black.withOpacity(0.7),
      ),
      titleLarge: TextStyle(
        fontSize: AppTextStyles.subheadingFontSize,
        fontWeight: FontWeight.bold,
        color: AppColors.primaryColor,
      ),
      titleMedium: TextStyle(
        fontSize: AppTextStyles.subheadingFontSize,
        fontWeight: FontWeight.normal,
        color: AppColors.primaryColor,
      ),
      labelLarge: TextStyle(
        fontSize: AppTextStyles.buttonFontSize,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
    ),

    // Button Theme (using ElevatedButton for primary buttons)
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primaryColor, // background color
        textStyle: TextStyle(
          fontSize: AppTextStyles.buttonFontSize,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    ),

    // Card Theme
    cardTheme: CardTheme(
      color: AppColors.cardColor,
      elevation: 4,
      shadowColor: Colors.black.withOpacity(0.1),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
    ),

    // Input Decoration Theme
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: Colors.white,
      border: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.grey),
        borderRadius: BorderRadius.circular(12),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: AppColors.primaryColor),
        borderRadius: BorderRadius.circular(12),
      ),
    ),

    // Bottom Navigation Bar Theme
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      selectedItemColor: AppColors.primaryColor,
      unselectedItemColor: Colors.grey[600],
      backgroundColor: Colors.white,
      elevation: 8,
    ),

    // Floating Action Button Theme
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: AppColors.primaryColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
    ),
  );

  static ThemeData darkTheme = ThemeData.dark().copyWith(
    // Primary and Secondary Colors using colorScheme
    colorScheme: ColorScheme.dark(
      primary: AppColors.primaryColor,
      secondary: AppColors.accentColor,
      onPrimary: Colors.white, // Text color on primary
      onSecondary: Colors.white, // Text color on secondary
      background: Colors.black,
      onBackground: Colors.white, // Text color on background
      surface: Colors.grey,
      onSurface: Colors.white,
    ),

    // Main Background Color for Scaffold
    scaffoldBackgroundColor: Colors.black,
  );
}