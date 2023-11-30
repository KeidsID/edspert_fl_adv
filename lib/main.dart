import 'package:flutter/gestures.dart' as gestures;
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'infrastructures/services.dart' as services;
import 'interfaces/providers/app_theme_mode_provider.dart';
import 'interfaces/providers/user_cache_provider.dart';
import 'interfaces/router/router.dart';
import 'interfaces/themes/app_themes.dart';

void main() async {
  final widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  await services.init();

  runApp(const ProviderScope(child: MainApp()));
}

class MainApp extends ConsumerStatefulWidget {
  const MainApp({super.key});

  @override
  ConsumerState<MainApp> createState() => _MainAppState();
}

class _MainAppState extends ConsumerState<MainApp> {
  bool _isSplashRemoved = false;

  @override
  Widget build(BuildContext context) {
    final userAsync = ref.watch(userCacheProvider);

    if (userAsync.hasValue && !_isSplashRemoved) {
      FlutterNativeSplash.remove();
      setState(() => _isSplashRemoved = true);
    }

    return MaterialApp.router(
      routerConfig: ref.watch(routerProvider),
      debugShowCheckedModeBanner: false,
      theme: AppThemes.light,
      darkTheme: AppThemes.dark,
      themeAnimationCurve: Curves.easeOut,
      themeAnimationDuration: const Duration(milliseconds: 500),
      themeMode: ref.watch(appThemeModeProvider),
      scrollBehavior: ScrollConfiguration.of(context).copyWith(
        dragDevices: {
          gestures.PointerDeviceKind.touch,
          gestures.PointerDeviceKind.mouse,
        },
      ),
    );
  }
}
