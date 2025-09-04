import 'package:flutter/material.dart';
import 'package:teslo_app/config/theme/custom_theme/app_filled_button_theme.dart';
import 'package:teslo_app/config/theme/custom_theme/app_text_field_theme.dart';
import 'package:teslo_app/config/theme/custom_theme/app_text_theme.dart';

class TAppTheme {
  TAppTheme._();

  static ThemeData lightTheme = _buildTheme(Brightness.light);

  /*static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    fontFamily: 'Poppins',
    brightness: Brightness.light,
    scaffoldBackgroundColor: Colors.white,
    primaryColor: Colors.blue,
    inputDecorationTheme: TAppTextFieldTheme.inputDecorationLightTheme,
  );*/
  static ThemeData darkTheme = _buildTheme(Brightness.dark);

  /*static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    fontFamily: 'Poppins',
    brightness: Brightness.dark,
    primaryColor: Colors.blue,
    scaffoldBackgroundColor: Colors.black,
    textTheme: TAppTextTheme.textTheme,
    inputDecorationTheme: TAppTextFieldTheme.inputDecorationDarkTheme,
    textButtonTheme: TextButtonThemeData(style: ButtonStyle().copyWith()),
  );*/

  static ThemeData _buildTheme(Brightness brightness) {
    final colorScheme = ColorScheme.fromSeed(
      seedColor: Colors.blue,
      brightness: brightness,
    );
    return ThemeData(
      useMaterial3: true,
      fontFamily: 'Poppins',
      brightness: brightness,
      colorScheme: colorScheme,
      scaffoldBackgroundColor:
          brightness == Brightness.light ? Colors.white : Colors.black,
      textTheme: TAppTextTheme.buildTextTheme(brightness),
      inputDecorationTheme: TAppTextFieldTheme.buildDecorationTheme(brightness),
      filledButtonTheme: FilledButtonThemeData(
        style: TAppFilledButtonTheme.buildTheme(colorScheme),
      ),
      textButtonTheme: TextButtonThemeData(
        style: ButtonStyle(
          foregroundColor: WidgetStateProperty.resolveWith((states) {
            return Colors.white;
          }),
          overlayColor: WidgetStateProperty.all(
            colorScheme.primary.withValues(alpha: 0.08),
          ),
          shape: WidgetStateProperty.all(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          ),
          padding: WidgetStateProperty.all(
            const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          ),
        ),
      ),
    );
  }
}
