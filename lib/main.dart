import 'package:flutter/gestures.dart' as gestures;
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'core/entities/user.dart';
import 'infrastructures/services.dart' as services;
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

  late final ProviderSubscription<AsyncValue<User?>> _userCacheListener;

  @override
  void initState() {
    _userCacheListener = ref.listenManual(userCacheProvider, (previous, next) {
      if (!next.isLoading) {
        FlutterNativeSplash.remove();
        setState(() => _isSplashRemoved = true);
        return;
      }
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final router = ref.watch(routerProvider);

    if (_isSplashRemoved) _userCacheListener.close();

    return MaterialApp.router(
      routerConfig: router,
      debugShowCheckedModeBanner: false,
      theme: AppThemes.light,
      darkTheme: AppThemes.dark,
      themeAnimationCurve: Curves.easeOut,
      themeAnimationDuration: const Duration(milliseconds: 500),
      themeMode: ThemeMode.system,
      scrollBehavior: ScrollConfiguration.of(context).copyWith(
        dragDevices: {
          gestures.PointerDeviceKind.touch,
          gestures.PointerDeviceKind.mouse,
        },
      ),
    );
  }
}
