import 'package:flutter/material.dart';

class AppTheme {
  // Brand Palette
  static const Color primaryGreen = Color(0xFF10B981);
  static const Color primaryDark = Color(0xFF047857);
  static const Color primaryLight = Color(0xFFD1FAE5);
  static const Color accentGreen = Color(0xFF059669);

  static const Color bgSoft = Color(0xFFF8FAFC);
  static const Color cardBg = Colors.white;
  static const Color textMain = Color(0xFF0F172A);
  static const Color textSub = Color(0xFF64748B);
  static const Color borderSubtle = Color(0xFFE2E8F0);

  // Nutritional Macro Colors
  static const Color calorieColor = Color(0xFFF59E0B); // Amber
  static const Color carbColor = Color(0xFF3B82F6);    // Blue
  static const Color proteinColor = Color(0xFF10B981); // Emerald
  static const Color fatColor = Color(0xFFEF4444);     // Red

  // Gradients
  static const LinearGradient heroGradient = LinearGradient(
    colors: [Color(0xFF059669), Color(0xFF10B981)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient cardGradient = LinearGradient(
    colors: [Color(0xFFFFFFFF), Color(0xFFF8FAFC)],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );

  // Box Decorations
  static BoxDecoration modernCardDecoration({
    Color? color,
    double borderRadius = 20,
    bool hasShadow = true,
  }) {
    return BoxDecoration(
      color: color ?? cardBg,
      borderRadius: BorderRadius.circular(borderRadius),
      border: Border.all(color: borderSubtle, width: 1),
      boxShadow: hasShadow
          ? [
              BoxShadow(
                color: const Color(0x0A000000),
                blurRadius: 16,
                offset: const Offset(0, 6),
              ),
            ]
          : null,
    );
  }

  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      scaffoldBackgroundColor: bgSoft,
      primaryColor: primaryGreen,
      colorScheme: ColorScheme.fromSeed(
        seedColor: primaryGreen,
        primary: primaryGreen,
        secondary: accentGreen,
        surface: cardBg,
      ),
      fontFamily: 'Roboto',
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        iconTheme: IconThemeData(color: textMain),
        titleTextStyle: TextStyle(
          color: textMain,
          fontSize: 18,
          fontWeight: FontWeight.w700,
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: primaryGreen,
          foregroundColor: Colors.white,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
          textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
      ),
    );
  }
}
