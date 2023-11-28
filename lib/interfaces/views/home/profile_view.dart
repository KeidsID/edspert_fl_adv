import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:edspert_fl_adv/interfaces/providers/user_cache_provider.dart';
import 'package:edspert_fl_adv/interfaces/views/home/home_view.dart';
import 'package:edspert_fl_adv/interfaces/widgets/others/network_image_circle_avatar.dart';
import 'package:edspert_fl_adv/interfaces/widgets/others/theme_mode_dropdown_button.dart';

const _cardMargin = EdgeInsets.symmetric(horizontal: 16.0);
const _cardPadding = EdgeInsets.all(16.0);

class ProfileView extends ConsumerWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const SafeArea(
      child: SizedBox.expand(
        child: CustomScrollView(
          slivers: [
            _ProfileViewAppBar(),
            SliverToBoxAdapter(child: SizedBox(height: 24.0)),
            _ProfileViewIdentityCard(),
            SliverToBoxAdapter(child: SizedBox(height: 16.0)),
            _ProfileViewSettingsCard(),
          ],
        ),
      ),
    );
  }
}

class _ProfileViewAppBar extends ConsumerWidget {
  const _ProfileViewAppBar();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userAsync = ref.watch(userCacheProvider);

    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final foregroundColor = theme.colorScheme.onPrimary;

    return SliverAppBar(
      backgroundColor: theme.colorScheme.primary,
      foregroundColor: foregroundColor,
      pinned: true,
      centerTitle: true,
      title: const Text('Akun Saya'),
      actions: [
        TextButton(
          onPressed: () {},
          child: Text(
            'Edit',
            style: textTheme.labelLarge?.copyWith(
              color: foregroundColor,
            ),
          ),
        ),
      ],
      stretch: true,
      expandedHeight: 200.0,
      flexibleSpace: FlexibleSpaceBar(
        background: SizedBox.expand(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        userAsync.value?.name ?? 'Anonim',
                        style: textTheme.headlineMedium?.copyWith(
                          color: foregroundColor,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        userAsync.value?.schoolName ?? '<Asal Sekolah>',
                        style: textTheme.bodyMedium?.copyWith(
                          color: foregroundColor,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      )
                    ],
                  ),
                ),
                Hero(
                  tag: HomeView.avatarHeroTag,
                  child: NetworkImageCircleAvatar(
                    userAsync.value?.photoUrl ?? '',
                    radius: 32.0,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _ProfileViewCardLayout extends StatelessWidget {
  const _ProfileViewCardLayout({this.child});

  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: SizedBox(
        child: Padding(
          // margin
          padding: _cardMargin,
          child: Card(
            child: Padding(
              // padding
              padding: _cardPadding,
              child: child,
            ),
          ),
        ),
      ),
    );
  }
}

TextStyle? _getCardTitleTextStyle(BuildContext context) {
  return Theme.of(context).textTheme.headlineSmall;
}

TextStyle? _getContentTitleTextStyle(BuildContext context) {
  final theme = Theme.of(context);
  final textTheme = theme.textTheme;
  final textColor = textTheme.bodyMedium?.color;

  return textTheme.bodyMedium?.copyWith(
    color: textColor?.withOpacity(0.6),
  );
}

TextStyle? _getContentTextStyle(BuildContext context) {
  return Theme.of(context).textTheme.bodyLarge;
}

class _ProfileViewIdentityCard extends ConsumerWidget {
  const _ProfileViewIdentityCard();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userAsync = ref.watch(userCacheProvider);

    return _ProfileViewCardLayout(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Identitas Diri', style: _getCardTitleTextStyle(context)),
          //
          const SizedBox(height: 24.0),
          Text('Nama Lengkap', style: _getContentTitleTextStyle(context)),
          Text(
            userAsync.value?.name ?? 'Anonim',
            style: _getContentTextStyle(context),
          ),
          //
          const SizedBox(height: 16.0),
          Text('Email', style: _getContentTitleTextStyle(context)),
          Text(
            userAsync.value?.email ?? 'anonim@example.com',
            style: _getContentTextStyle(context),
          ),
          //
          const SizedBox(height: 16.0),
          Text('Jenis Kelamin', style: _getContentTitleTextStyle(context)),
          Text(
            '${userAsync.value?.gender ?? '<manusia>'}',
            style: _getContentTextStyle(context),
          ),
          //
          const SizedBox(height: 16.0),
          Text('Kelas', style: _getContentTitleTextStyle(context)),
          Text(
            '${userAsync.value?.schoolDetail ?? '<kelas - tingkat>'}',
            style: _getContentTextStyle(context),
          ),
          //
          const SizedBox(height: 16.0),
          Text('Sekolah', style: _getContentTitleTextStyle(context)),
          Text(
            userAsync.value?.schoolName ?? 'SMA Anonim',
            style: _getContentTextStyle(context),
          ),
        ],
      ),
    );
  }
}

class _ProfileViewSettingsCard extends ConsumerWidget {
  const _ProfileViewSettingsCard();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userCacheNotifier = ref.read(userCacheProvider.notifier);

    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return _ProfileViewCardLayout(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Pengaturan', style: _getCardTitleTextStyle(context)),
          //
          const SizedBox(height: 24.0),
          Text('Tema Aplikasi', style: _getContentTitleTextStyle(context)),
          const ThemeModeDropdownButton(),
          //
          const SizedBox(height: 16.0),
          Text('Akun', style: _getContentTitleTextStyle(context)),
          TextButton.icon(
            onPressed: () => userCacheNotifier.logout(),
            icon: Icon(
              Icons.logout_outlined,
              color: colorScheme.error,
            ),
            label: Text(
              'Keluar',
              style: _getContentTextStyle(context)?.copyWith(
                color: colorScheme.error,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
