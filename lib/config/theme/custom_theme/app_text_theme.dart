import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TAppTextTheme {
  TAppTextTheme._();

  static TextTheme buildTextTheme(Brightness brightness) {
    final color = brightness == Brightness.light ? Colors.black : Colors.white;
    return TextTheme(
      titleLarge: GoogleFonts.poppins().copyWith(
        color: color,
        fontSize: 40,
        fontWeight: FontWeight.bold,
      ),
      titleMedium: GoogleFonts.poppins().copyWith(
        color: color,
        fontSize: 30,
        fontWeight: FontWeight.bold,
      ),
      titleSmall: GoogleFonts.poppins().copyWith(color: color, fontSize: 20),
    );
  }
}
