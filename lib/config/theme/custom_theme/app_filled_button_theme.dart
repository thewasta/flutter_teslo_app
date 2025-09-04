import 'package:flutter/material.dart';

class TAppFilledButtonTheme {
  TAppFilledButtonTheme._();

  static ButtonStyle buildTheme(ColorScheme cs) {
    return ButtonStyle(
      foregroundColor: WidgetStateProperty.resolveWith<Color?>((states) {
        if (states.contains(WidgetState.disabled)) {
          return cs.onSurface.withValues(alpha: 0.38);
        }
        return cs.onPrimary;
      }),
      backgroundColor: WidgetStateProperty.resolveWith<Color?>((states) {
        if (states.contains(WidgetState.disabled)) {
          return cs.onSurface.withValues(alpha: 0.12);
        }
        return cs.primary;
      }),
      overlayColor: WidgetStateProperty.resolveWith<Color?>((states) {
        if (states.contains(WidgetState.pressed)) {
          return cs.onPrimary.withValues(alpha: 0.12);
        }
        if (states.contains(WidgetState.hovered)) {
          return cs.onPrimary.withValues(alpha: 0.08);
        }
        if (states.contains(WidgetState.focused)) {
          return cs.onPrimary.withValues(alpha: 0.12);
        }
        return null;
      }),
      shape: WidgetStateProperty.all(
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
      padding: WidgetStateProperty.all(
        const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      ),
      minimumSize: WidgetStateProperty.all(const Size(64, 48)),
      textStyle: WidgetStateProperty.all(
        const TextStyle(fontWeight: FontWeight.w600, color: Colors.red),
      ),
      elevation: WidgetStateProperty.all(1),
    );
  }
}
