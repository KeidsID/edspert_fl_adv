import 'package:cached_network_image/cached_network_image.dart';
import 'package:edspert_fl_adv/interfaces/providers/user_cache_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:edspert_fl_adv/common/assets_paths.dart';
import 'package:edspert_fl_adv/interfaces/widgets/others/course_card.dart';
import 'package:edspert_fl_adv/interfaces/widgets/others/home_view_headline_card.dart';

class HomeView extends ConsumerWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;

    return SafeArea(
      child: SizedBox.expand(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
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
    final userCacheNotifier = ref.read(userCacheProvider.notifier);

    final isLoading = userAsync.isLoading || userAsync.isRefreshing;

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
            child: InkWell(
              onTap: isLoading ? null : () => _onAvatarTap(userCacheNotifier),
              child: Material(
                child: CircleAvatar(
                  radius: 24.0,
                  child: CachedNetworkImage(
                    imageUrl: userAsync.value?.photoUrl ?? '',
                    placeholder: (_, __) => const Center(
                      child: CircularProgressIndicator(),
                    ),
                    errorWidget: (_, __, ___) => Image.asset(
                      AssetsPaths.dummyAvatar,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _onAvatarTap(UserCache userCacheNotifier) => userCacheNotifier.logout();
}
