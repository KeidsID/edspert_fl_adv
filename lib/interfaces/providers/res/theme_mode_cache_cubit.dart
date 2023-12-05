import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:root_lib/core/use_cases/others/get_theme_mode.dart';
import 'package:root_lib/core/use_cases/others/set_theme_mode.dart';
import 'package:root_lib/infrastructures/services.dart' as services;

final class ThemeModeCacheCubit extends Cubit<ThemeMode> {
  ThemeModeCacheCubit() : super(ThemeMode.system) {
    _build();
  }

  Future<void> _build() async {
    final themeMode = await services.locator<GetThemeMode>().execute();

    emit(themeMode);
  }

  Future<void> updateMode(ThemeMode mode) async {
    await services.locator<SetThemeMode>().execute(mode);

    emit(mode);
  }
}
