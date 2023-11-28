import 'package:flutter/material.dart';

abstract interface class ThemeModeCache {
  Future<void> save(ThemeMode mode);
  Future<ThemeMode> get();
}
