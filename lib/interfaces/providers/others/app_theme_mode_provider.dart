import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:edspert_fl_adv/core/use_cases/others/get_theme_mode.dart';
import 'package:edspert_fl_adv/core/use_cases/others/set_theme_mode.dart';
import 'package:edspert_fl_adv/infrastructures/services.dart' as services;

part 'app_theme_mode_provider.g.dart';

@riverpod
class AppThemeMode extends _$AppThemeMode {
  @override
  ThemeMode build() {
    _init();

    return ThemeMode.system;
  }

  Future<void> _init() async {
    final themeMode = await services.locator<GetThemeMode>().execute();

    state = themeMode;
  }

  Future<void> updateMode(ThemeMode mode) async {
    await services.locator<SetThemeMode>().execute(mode);
    state = mode;
  }
}
