import 'package:flutter/material.dart';

// Color Constants
class AppColors {
  static const Color primaryColor = Color(0xFF6200EE); // Purple
  static const Color accentColor = Color(0xFF03DAC6);  // Teal
  static const Color backgroundColor = Color(0xFFF5F5F5); // Light Gray
  static const Color cardColor = Color(0xFFFFFFFF); // White for cards
  static const Color errorColor = Color(0xFFB00020); // Red

  // Gradients
  static const Gradient primaryGradient = LinearGradient(
    colors: [Color(0xFF6200EE), Color(0xFF3700B3)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const Gradient secondaryGradient = LinearGradient(
    colors: [Color(0xFF03DAC6), Color(0xFF018786)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
}

// Font Size Constants
class AppTextStyles {
  static const double headingFontSize = 32.0;
  static const double subheadingFontSize = 24.0;
  static const double bodyFontSize = 16.0;
  static const double buttonFontSize = 18.0;
  static const double captionFontSize = 12.0;
}

// Spacing Constants
class AppSpacing {
  static const double smallSpacing = 8.0;
  static const double mediumSpacing = 16.0;
  static const double largeSpacing = 32.0;
  static const double extraLargeSpacing = 64.0;
}
