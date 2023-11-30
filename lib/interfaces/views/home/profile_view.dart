import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:edspert_fl_adv/common/constants.dart';
import 'package:edspert_fl_adv/interfaces/providers/user_cache_provider.dart';
import 'package:edspert_fl_adv/interfaces/router/routes.dart';
import 'package:edspert_fl_adv/interfaces/widgets/others/network_image_circle_avatar.dart';
import 'package:edspert_fl_adv/interfaces/widgets/others/theme_mode_dropdown_button.dart';

const _cardMargin = EdgeInsets.symmetric(horizontal: kPaddingValue);
const _cardPadding = EdgeInsets.all(kPaddingValue);

class ProfileView extends ConsumerWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const SafeArea(
      child: SizedBox.expand(
        child: CustomScrollView(
          slivers: [
            _AppBar(),
            SliverToBoxAdapter(child: SizedBox(height: kLargeSpacerValue)),
            _IdentityCard(),
            SliverToBoxAdapter(child: SizedBox(height: kSpacerValue)),
            _SettingsCard(),
          ],
        ),
      ),
    );
  }
}

class _AppBar extends ConsumerWidget {
  const _AppBar();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userAsync = ref.watch(userCacheProvider);
    final user = userAsync.valueOrNull;

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
          onPressed: (user == null)
              ? null
              : () {
                  EditProfileDialogRoute(
                    email: user.email,
                    oldName: user.name,
                    oldGender: user.gender.toString(),
                    oldSchoolGrade: user.schoolDetail.toString(),
                    oldSchoolName: user.schoolName,
                  ).go(context);
                },
          child: Text(
            'Edit',
            style: textTheme.labelLarge?.copyWith(color: foregroundColor),
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
                NetworkImageCircleAvatar(
                  userAsync.value?.photoUrl ?? '',
                  radius: 32.0,
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

TextStyle? kPVCardTitleStyle(BuildContext context) {
  return Theme.of(context).textTheme.headlineSmall;
}

TextStyle? kPVContentTitleStyle(BuildContext context) {
  final theme = Theme.of(context);
  final textTheme = theme.textTheme;
  final textColor = textTheme.bodyMedium?.color;

  return textTheme.bodyMedium?.copyWith(
    color: textColor?.withOpacity(0.6),
  );
}

TextStyle? kPVContentValueStyle(BuildContext context) {
  return Theme.of(context).textTheme.bodyLarge;
}

class _IdentityCard extends ConsumerWidget {
  const _IdentityCard();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userAsync = ref.watch(userCacheProvider);

    final user = userAsync.valueOrNull;

    return _ProfileViewCardLayout(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Identitas Diri', style: kPVCardTitleStyle(context)),
          //
          const SizedBox(height: kLargeSpacerValue),
          Text('Nama Lengkap', style: kPVContentTitleStyle(context)),
          Text(
            user?.name ?? 'Anonim',
            style: kPVContentValueStyle(context),
          ),
          //
          const SizedBox(height: kSpacerValue),
          Text('Email', style: kPVContentTitleStyle(context)),
          Text(
            user?.email ?? 'anonim@example.com',
            style: kPVContentValueStyle(context),
          ),
          //
          const SizedBox(height: kSpacerValue),
          Text('Jenis Kelamin', style: kPVContentTitleStyle(context)),
          Text(
            '${user?.gender ?? '<manusia>'}',
            style: kPVContentValueStyle(context),
          ),
          //
          const SizedBox(height: kSpacerValue),
          Text('Kelas', style: kPVContentTitleStyle(context)),
          Text(
            '${user?.schoolDetail ?? '<kelas - tingkat>'}',
            style: kPVContentValueStyle(context),
          ),
          //
          const SizedBox(height: kSpacerValue),
          Text('Sekolah', style: kPVContentTitleStyle(context)),
          Text(
            user?.schoolName ?? 'SMA Anonim',
            style: kPVContentValueStyle(context),
          ),
        ],
      ),
    );
  }
}

class _SettingsCard extends ConsumerWidget {
  const _SettingsCard();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userCacheNotifier = ref.read(userCacheProvider.notifier);

    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return _ProfileViewCardLayout(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Pengaturan', style: kPVCardTitleStyle(context)),
          //
          const SizedBox(height: kLargeSpacerValue),
          Text(
            'Tema Aplikasi',
            style: kPVContentTitleStyle(context),
          ),
          const ThemeModeDropdownButton(),
          //
          const SizedBox(height: kSpacerValue),
          Text('Akun', style: kPVContentTitleStyle(context)),
          TextButton.icon(
            onPressed: () => userCacheNotifier.logout(),
            icon: Icon(
              Icons.logout_outlined,
              color: colorScheme.error,
            ),
            label: Text(
              'Keluar',
              style: theme.textTheme.bodyMedium?.copyWith(
                color: colorScheme.error,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
