part of '../home_view.dart';

class _HeadlineSection extends StatelessWidget {
  const _HeadlineSection();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;

    return AspectRatio(
      aspectRatio: 1 / 0.6,
      child: Card(
        color: colorScheme.primary,
        child: Padding(
          padding: const EdgeInsets.only(left: 16.0),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Flexible(
                child: Text(
                  'Mau kerjain latihan soal apa hari ini?',
                  style: textTheme.headlineMedium?.copyWith(
                    color: colorScheme.onPrimary,
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Image.asset(
                    AssetsPaths.homePageHeadline,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
