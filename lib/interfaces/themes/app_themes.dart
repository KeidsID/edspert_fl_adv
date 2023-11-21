import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

abstract final class AppThemes {
  static final ThemeData light = ThemeData.from(
    colorScheme: ColorScheme.fromSeed(
      seedColor: _primaryColor,
      brightness: Brightness.light,
    ),
    useMaterial3: true,
    textTheme: _textTheme,
  );

  static final ThemeData dark = ThemeData.from(
    colorScheme: ColorScheme.fromSeed(
      seedColor: _primaryColor,
      brightness: Brightness.dark,
    ),
    useMaterial3: true,
    textTheme: _textTheme,
  );

  static const _primaryColor = Color(0xff3a7fd5);

  static final _poppinsBold = GoogleFonts.poppins(fontWeight: FontWeight.bold);

  // SF Pro Display alt.
  static final _robotoSemiBold =
      GoogleFonts.roboto(fontWeight: FontWeight.w600);
  static final _robotoMedium = GoogleFonts.roboto(fontWeight: FontWeight.w500);

  static final _textTheme = TextTheme(
    displayLarge: _poppinsBold.copyWith(fontSize: 30),
    displayMedium: _poppinsBold.copyWith(fontSize: 24),
    displaySmall: _poppinsBold.copyWith(fontSize: 20),
    headlineLarge: _robotoSemiBold.copyWith(fontSize: 20),
    headlineMedium: _robotoSemiBold.copyWith(fontSize: 18),
    headlineSmall: _robotoSemiBold.copyWith(fontSize: 16),
    titleLarge: _robotoMedium.copyWith(fontSize: 16),
    titleMedium: _robotoMedium.copyWith(fontSize: 14),
    titleSmall: _robotoMedium.copyWith(fontSize: 12),
    bodyLarge: _robotoSemiBold.copyWith(fontSize: 14),
    bodyMedium: _robotoSemiBold.copyWith(fontSize: 12),
    bodySmall: _robotoSemiBold.copyWith(fontSize: 10),
    labelLarge: _robotoMedium.copyWith(fontSize: 10),
    labelMedium: _robotoSemiBold.copyWith(fontSize: 8),
    labelSmall: _robotoMedium.copyWith(fontSize: 8),
  );
}
