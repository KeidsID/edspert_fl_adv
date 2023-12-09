import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'package:root_lib/interfaces/providers.dart';
import 'package:root_lib/interfaces/router/routes/routes.dart';

const _navs = <_NavDelegate>[
  _NavDelegate(
    icon: Icon(Icons.home_outlined),
    activeIcon: Icon(Icons.home),
    label: 'Home',
    tooltip: 'Home',
  ),
  _NavDelegate(
    icon: Icon(Icons.person_outlined),
    activeIcon: Icon(Icons.person),
    label: 'Profile',
    tooltip: 'Profile',
  ),
];

/// {@template interfaces.views.home.home_layout}
/// A navigation bar layout for home page.
/// {@endtemplate}
class HomeLayout extends StatelessWidget {
  /// [HomeLayout] content.
  final Widget child;

  /// {@macro interfaces.views.home.home_layout}
  const HomeLayout({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => IpaCoursesCubit(context)),
          BlocProvider(create: (context) => IpsCoursesCubit(context)),
          BlocProvider.value(value: EventBannersCubit()),
        ],
        child: child,
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: _navs.map((e) {
          return BottomNavigationBarItem(
            icon: e.icon,
            activeIcon: e.activeIcon,
            label: e.label,
            tooltip: e.tooltip,
          );
        }).toList(),
        currentIndex: _currentIndex(context),
        onTap: (value) {
          if (value == 1) return const ProfileRoute().go(context);

          return const HomeRoute().go(context);
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        tooltip: 'Diskusi Soal',
        onPressed: () {},
        child: const Icon(Icons.chat_outlined),
      ),
    );
  }

  int _currentIndex(BuildContext context) {
    final currentRoute = GoRouterState.of(context).uri.path;

    if (currentRoute.startsWith(const ProfileRoute().location)) return 1;

    return 0;
  }
}

class _NavDelegate {
  final Widget icon;
  final Widget? activeIcon;
  final String? label;
  final String? tooltip;

  const _NavDelegate({
    required this.icon,
    this.activeIcon,
    this.label,
    this.tooltip,
  });
}
