part of 'main.dart';

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  bool _isSplashRemoved = false;

  @override
  Widget build(BuildContext context) {
    final userCacheCubit = context.watch<UserCacheCubit>();
    final userCache = userCacheCubit.state;

    if (!userCache.isLoading && !_isSplashRemoved) {
      FlutterNativeSplash.remove();
      setState(() => _isSplashRemoved = true);
    }

    return MaterialApp.router(
      routerConfig: router,
      debugShowCheckedModeBanner: false,
      theme: AppThemes.light,
      darkTheme: AppThemes.dark,
      themeAnimationCurve: Curves.easeOut,
      themeAnimationDuration: const Duration(milliseconds: 500),
      themeMode: context.watch<ThemeModeCacheCubit>().state,
      scrollBehavior: ScrollConfiguration.of(context).copyWith(
        dragDevices: {
          gestures.PointerDeviceKind.touch,
          gestures.PointerDeviceKind.mouse,
        },
      ),
    );
  }
}
