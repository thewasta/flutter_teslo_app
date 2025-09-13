import 'package:flutter/material.dart';
import 'package:teslo_app/config/theme/custom_theme/app_filled_button_theme.dart';
import 'package:teslo_app/config/theme/custom_theme/app_text_field_theme.dart';
import 'package:teslo_app/config/theme/custom_theme/app_text_theme.dart';

class TAppTheme {
  TAppTheme._();

  static ThemeData lightTheme = _buildTheme(Brightness.light);

  static ThemeData darkTheme = _buildTheme(Brightness.dark);

  static const Color primaryColor = Color(0xFF363A69);

  static ThemeData _buildTheme(Brightness brightness) {
    final isLight = brightness == Brightness.light;
    final colorScheme = ColorScheme.fromSeed(
      seedColor: primaryColor,
      brightness: brightness,
    );
    return ThemeData(
      useMaterial3: true,
      fontFamily: 'Poppins',
      brightness: brightness,
      colorScheme: colorScheme,
      scaffoldBackgroundColor: isLight ? Colors.white : Colors.black,
      textTheme: TAppTextTheme.buildTextTheme(brightness),
      inputDecorationTheme: TAppTextFieldTheme.buildDecorationTheme(brightness),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
          shape: WidgetStateProperty.all(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          ),
          padding: WidgetStateProperty.all(
            const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
          ),
          minimumSize: WidgetStateProperty.all(const Size(64, 48)),
          textStyle: WidgetStateProperty.all(
            const TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
          ),
          elevation: WidgetStateProperty.all(1),
          backgroundColor: WidgetStateProperty.all(primaryColor),
          foregroundColor: WidgetStateProperty.all(Colors.white),
        ),
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          backgroundColor: primaryColor,
          foregroundColor: Colors.white,
          textStyle: const TextStyle(fontWeight: FontWeight.w600),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: primaryColor,
        foregroundColor: Colors.white,
      ),

      // filledButtonTheme: FilledButtonThemeData(
      //   style: TAppFilledButtonTheme.buildTheme(colorScheme),
      // ),
      // textButtonTheme: TextButtonThemeData(
      //   style: ButtonStyle(
      //     foregroundColor: WidgetStateProperty.resolveWith((states) {
      //       return Colors.white;
      //     }),
      //     overlayColor: WidgetStateProperty.all(
      //       colorScheme.primary.withValues(alpha: 0.08),
      //     ),
      //     shape: WidgetStateProperty.all(
      //       RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      //     ),
      //     padding: WidgetStateProperty.all(
      //       const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      //     ),
      //   ),
      // ),
    );
  }
}
