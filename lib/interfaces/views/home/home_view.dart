import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:edspert_fl_adv/common/constants.dart';
import 'package:edspert_fl_adv/interfaces/providers/auth/user_cache_provider.dart';
import 'package:edspert_fl_adv/interfaces/providers/events/event_banners_provider.dart';
import 'package:edspert_fl_adv/interfaces/router/routes.dart';
import 'package:edspert_fl_adv/interfaces/widgets/others/course_card.dart';
import 'package:edspert_fl_adv/interfaces/widgets/others/event_banner_card.dart';
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
          padding: const EdgeInsets.symmetric(vertical: kPaddingValue),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ...[
                const _HomeViewAppBar(),

                //
                const SizedBox(height: kSpacerValue),
                const HomeViewHeadlineCard(),

                // study materials
                const SizedBox(height: kSpacerValue),
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

                // events
                const SizedBox(height: kSpacerValue),
                Text('Terbaru', style: textTheme.headlineSmall),
              ].map((e) {
                return Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: kPaddingValue,
                  ),
                  child: e,
                );
              }),
              const SizedBox(height: 8.0),
              const _EventBannersListView(),
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

class _EventBannersListView extends ConsumerWidget {
  const _EventBannersListView();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final eventBannersAsync = ref.watch(eventBannersProvider);

    final mediaQuery = MediaQuery.of(context);
    final maxH = (mediaQuery.orientation == Orientation.portrait)
        ? mediaQuery.size.height * 0.21
        : mediaQuery.size.width * 0.21;

    return eventBannersAsync.when(
      skipLoadingOnRefresh: false,
      loading: () => SizedBox(
        width: double.maxFinite,
        height: maxH,
        child: const Center(
          child: CircularProgressIndicator(),
        ),
      ),
      error: (error, stackTrace) => SizedBox(
        height: maxH,
        child: const Text('Error'),
      ),
      data: (data) => SizedBox(
        height: maxH,
        child: ListView.builder(
          padding: const EdgeInsets.symmetric(horizontal: kPaddingValue),
          scrollDirection: Axis.horizontal,
          itemCount: data.length,
          itemBuilder: (_, index) => EventBannerCard(data[index]),
        ),
      ),
    );
  }
}
