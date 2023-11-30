import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:edspert_fl_adv/common/assets_paths.dart';
import 'package:edspert_fl_adv/common/constants.dart';
import 'package:edspert_fl_adv/interfaces/providers/user_cache_provider.dart';
import 'package:edspert_fl_adv/interfaces/router/routes.dart';
import 'package:edspert_fl_adv/interfaces/widgets/others/course_card.dart';
import 'package:edspert_fl_adv/interfaces/widgets/others/home_view_headline_card.dart';
import 'package:edspert_fl_adv/interfaces/widgets/others/network_image_circle_avatar.dart';

class HomeView extends ConsumerWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;

    return SafeArea(
      child: SizedBox.expand(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(kPaddingValue),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const _HomeViewAppBar(),
              const SizedBox(height: 16.0),
              const HomeViewHeadlineCard(),
              const SizedBox(height: 16.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Pilih Pelajaran', style: textTheme.headlineSmall),
                  TextButton(
                      onPressed: () {}, child: const Text('Lihat Semua')),
                ],
              ),
              const SizedBox(height: 8.0),
              Column(
                children: List.generate(
                  3,
                  (index) => const Padding(
                    padding: EdgeInsets.symmetric(vertical: 8.0),
                    child: CourseCard(),
                  ),
                ),
              ),
              const SizedBox(height: 8.0),
              Text('Terbaru', style: textTheme.headlineSmall),
              const SizedBox(height: 16.0),
              SizedBox(
                height: 200.0,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  separatorBuilder: (_, __) => const SizedBox(width: 16.0),
                  itemCount: 3,
                  itemBuilder: (_, __) {
                    return SizedBox(
                      width: 200.0 * 1.7,
                      child: Card(
                        child: Image.asset(
                          AssetsPaths.loginPageHeadline,
                          fit: BoxFit.cover,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _HomeViewAppBar extends ConsumerWidget {
  const _HomeViewAppBar();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final textTheme = Theme.of(context).textTheme;

    final userAsync = ref.watch(userCacheProvider);

    return SizedBox(
      height: kToolbarHeight,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Hai, ${userAsync.value?.name ?? 'Anonim'}',
                style: textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Text('Selamat Datang'),
            ],
          ),
          Flexible(
            child: NetworkImageCircleAvatar(
              userAsync.value?.photoUrl ?? '',
              radius: 24.0,
              onTap: () => const ProfileRoute().go(context),
            ),
          ),
        ],
      ),
    );
  }
}
