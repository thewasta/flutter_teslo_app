import 'package:flutter/material.dart';

class TAppTextFieldTheme {
  TAppTextFieldTheme._();

  static InputDecorationTheme buildDecorationTheme(Brightness brightness) {
    final border = const OutlineInputBorder().copyWith(
      borderRadius: BorderRadius.circular(10),
      borderSide: BorderSide(
        color: brightness == Brightness.light ? Colors.black12 : Colors.white70,
        width: 2,
      ),
    );
    return InputDecorationTheme(
      errorMaxLines: 3,
      isDense: true,
      filled: true,
      labelStyle: const TextStyle().copyWith(fontSize: 14),
      hintStyle: const TextStyle().copyWith(fontSize: 14),
      fillColor:
          brightness == Brightness.light ? Colors.white70 : Colors.black26,
      border: border,
      focusedBorder: border,
      enabledBorder: border,
      contentPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
    );
  }
}
