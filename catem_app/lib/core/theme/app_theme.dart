import 'package:flutter/material.dart';

abstract final class AppTheme {
  // Semilla provisional hasta tener los tokens del design system (CATEM-74).
  static const Color _seed = Color(0xFF6750A4);

  static ThemeData get light => ThemeData(
    colorScheme: ColorScheme.fromSeed(seedColor: _seed),
  );

  static ThemeData get dark => ThemeData(
    colorScheme: ColorScheme.fromSeed(
      seedColor: _seed,
      brightness: Brightness.dark,
    ),
  );
}
