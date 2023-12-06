import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:root_lib/common/constants.dart';
import 'package:root_lib/interfaces/providers.dart';
import 'package:root_lib/interfaces/router/routes/routes.dart';
import 'package:root_lib/interfaces/widgets/common/network_circle_avatar.dart';

const _cardMargin = EdgeInsets.symmetric(horizontal: kPaddingValue);
const _cardPadding = EdgeInsets.all(kPaddingValue);

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child: SizedBox.expand(
        child: CustomScrollView(
          slivers: [
            _AppBar(),
            SliverToBoxAdapter(child: SizedBox(height: kLargeSpacerValue)),
            _IdentityCard(),
            SliverToBoxAdapter(child: SizedBox(height: kSpacerValue)),
            _SettingsCard(),
            SliverToBoxAdapter(child: SizedBox(height: kLargeSpacerValue)),
          ],
        ),
      ),
    );
  }
}

class _AppBar extends StatelessWidget {
  const _AppBar();

  @override
  Widget build(BuildContext context) {
    final userAsync = context.watch<UserCacheCubit>().state;
    final user = userAsync.value;

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
            padding: const EdgeInsets.all(16.0).copyWith(
              top: kToolbarHeight + 16.0,
            ),
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
                NetworkCircleAvatar(
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

class _IdentityCard extends StatelessWidget {
  const _IdentityCard();

  @override
  Widget build(BuildContext context) {
    final userAsync = context.watch<UserCacheCubit>().state;
    final user = userAsync.value;

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

class _SettingsCard extends StatelessWidget {
  const _SettingsCard();

  @override
  Widget build(BuildContext context) {
    final userCacheCubit = context.read<UserCacheCubit>();

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
          const _ThemeModeDropdownButton(),
          //
          const SizedBox(height: kSpacerValue),
          Text('Akun', style: kPVContentTitleStyle(context)),
          Builder(builder: (context) {
            return TextButton.icon(
              onPressed: () => userCacheCubit.logout(),
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
            );
          }),
        ],
      ),
    );
  }
}

class _ThemeModeDropdownButton extends StatelessWidget {
  const _ThemeModeDropdownButton();

  @override
  Widget build(BuildContext context) {
    final themeModeCacheCubit = context.watch<ThemeModeCacheCubit>();
    final themeMode = themeModeCacheCubit.state;

    return DropdownButton<ThemeMode>(
      value: themeMode,
      onChanged: (value) => themeModeCacheCubit.updateMode(value!),
      items: ThemeMode.values.map((e) {
        final filteredName = e.name == 'system' ? 'system default' : e.name;
        final icons = {
          'system': Icons.color_lens_outlined,
          'light': Icons.light_mode_outlined,
          'dark': Icons.dark_mode_outlined,
        };

        return DropdownMenuItem(
          key: Key('item-${e.name}'),
          value: e,
          child: Row(
            children: [
              Icon(icons[e.name]),
              const SizedBox(width: 8),
              Text(filteredName),
            ],
          ),
        );
      }).toList(),
    );
  }
}
