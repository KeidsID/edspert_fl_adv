part of '../home_view.dart';

class _EventBannersSection extends StatelessWidget {
  const _EventBannersSection();

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: _kHorizPadding,
          child: Text('Terbaru', style: textTheme.headlineSmall),
        ),
        const SizedBox(height: 8.0),
        const _EventBannersListView(),
      ],
    );
  }
}

class _EventBannersListView extends StatelessWidget {
  const _EventBannersListView();

  @override
  Widget build(BuildContext context) {
    final eventBannersCubit = context.watch<EventBannersCubit>();
    final eventBannersAsync = eventBannersCubit.state;

    final mediaQuery = MediaQuery.of(context);
    final maxH = (mediaQuery.orientation == Orientation.portrait)
        ? mediaQuery.size.height * 0.21
        : mediaQuery.size.width * 0.21;

    return eventBannersAsync.when(
      loading: () => SizedCircularIndicator(
        width: double.maxFinite,
        height: maxH,
      ),

      //
      error: (error) => CommonErrorWidget(
        error,
        width: double.maxFinite,
        height: maxH,
        action: ElevatedButton.icon(
          onPressed: () => eventBannersCubit.refresh(),
          icon: const Icon(Icons.refresh_outlined),
          label: const Text('Refresh'),
        ),
      ),

      //
      data: (data) {
        if (data.isEmpty) {
          return SizedBox(
            width: double.maxFinite,
            height: maxH,
            child: const Center(child: Text('Tidak ada event')),
          );
        }

        return SizedBox(
          height: maxH,
          child: ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: kPaddingValue),
            scrollDirection: Axis.horizontal,
            itemCount: data.length,
            itemBuilder: (_, index) => _EventBannerCard(data[index]),
          ),
        );
      },
    );
  }
}

class _EventBannerCard extends StatelessWidget {
  const _EventBannerCard(this.eventBanner);

  final EventBanner eventBanner;

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 2 / 1,
      child: Tooltip(
        message: eventBanner.title,
        child: Card(
          clipBehavior: Clip.hardEdge,
          child: InkWell(
            onTap: () async {
              final url = eventBanner.eventUrl;

              if (url == null) return;

              final isSuccess = await launchUrl(url);

              if (!isSuccess) {
                kLogger.i('Failed to launch $url');
              }
            },
            child: CommonNetworkImage(eventBanner.imageUrl, fit: BoxFit.cover),
          ),
        ),
      ),
    );
  }
}
