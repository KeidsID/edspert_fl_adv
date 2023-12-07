import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:root_lib/core/use_cases.dart';
import 'package:root_lib/infrastructures/container.dart' as container;

final class ThemeModeCacheCubit extends Cubit<ThemeMode> {
  ThemeModeCacheCubit() : super(ThemeMode.system) {
    _build();
  }

  Future<void> _build() async {
    final themeMode = await container.locator<GetThemeMode>().execute();

    emit(themeMode);
  }

  Future<void> updateMode(ThemeMode mode) async {
    await container.locator<SetThemeMode>().execute(mode);

    emit(mode);
  }
}
