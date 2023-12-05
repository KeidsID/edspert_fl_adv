import 'package:flutter/gestures.dart' as gestures;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

import 'package:root_lib/interfaces/providers/res/theme_mode_cache_cubit.dart';
import 'package:root_lib/interfaces/providers/res/user_cache_cubit.dart';

import 'infrastructures/services.dart' as services;
import 'interfaces/router/router.dart';
import 'interfaces/themes/app_themes.dart';

part 'app.dart';

void main() async {
  final widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  await services.init();

  runApp(MultiBlocProvider(
    providers: [
      BlocProvider.value(value: UserCacheCubit()),
      BlocProvider.value(value: ThemeModeCacheCubit()),
    ],
    child: const MainApp(),
  ));
}
