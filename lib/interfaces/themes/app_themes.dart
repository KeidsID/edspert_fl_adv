import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

abstract final class AppThemes {
  static final ThemeData light = ThemeData.from(
    colorScheme: ColorScheme.fromSeed(
      seedColor: _primaryColor,
      brightness: Brightness.light,
    ),
    useMaterial3: _useMaterial3,
    textTheme: _textTheme,
  );

  static final ThemeData dark = ThemeData.from(
    colorScheme: ColorScheme.fromSeed(
      seedColor: _primaryColor,
      brightness: Brightness.dark,
    ),
    useMaterial3: _useMaterial3,
    textTheme: _textTheme,
  );

  static const _useMaterial3 = true;

  static const _primaryColor = Color(0xff3a7fd5);

  static final _poppinsBold = GoogleFonts.poppins(fontWeight: FontWeight.bold);

  // SF Pro Display alt.
  static final _robotoSemiBold =
      GoogleFonts.roboto(fontWeight: FontWeight.w600);
  static final _robotoMedium = GoogleFonts.roboto(fontWeight: FontWeight.w500);

  static const _textScale = 1.3; // text looks small on button without this

  static final _textTheme = TextTheme(
    displayLarge: _poppinsBold.copyWith(fontSize: 30 * _textScale),
    displayMedium: _poppinsBold.copyWith(fontSize: 24 * _textScale),
    displaySmall: _poppinsBold.copyWith(fontSize: 20 * _textScale),
    headlineLarge: _robotoSemiBold.copyWith(fontSize: 20 * _textScale),
    headlineMedium: _robotoSemiBold.copyWith(fontSize: 18 * _textScale),
    headlineSmall: _robotoSemiBold.copyWith(fontSize: 16 * _textScale),
    titleLarge: _robotoMedium.copyWith(fontSize: 16 * _textScale),
    titleMedium: _robotoMedium.copyWith(fontSize: 14 * _textScale),
    titleSmall: _robotoMedium.copyWith(fontSize: 12 * _textScale),
    bodyLarge: _robotoSemiBold.copyWith(fontSize: 14 * _textScale),
    bodyMedium: _robotoSemiBold.copyWith(fontSize: 12 * _textScale),
    bodySmall: _robotoSemiBold.copyWith(fontSize: 10 * _textScale),
    labelLarge: _robotoMedium.copyWith(fontSize: 10 * _textScale),
    labelMedium: _robotoSemiBold.copyWith(fontSize: 8 * _textScale),
    labelSmall: _robotoMedium.copyWith(fontSize: 8 * _textScale),
  );
}
