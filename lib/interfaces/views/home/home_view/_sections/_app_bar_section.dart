part of '../home_view.dart';

class _AppBarSection extends ConsumerWidget {
  const _AppBarSection();

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
            child: NetworkCircleAvatar(
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
