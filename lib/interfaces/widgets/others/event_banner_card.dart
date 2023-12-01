import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:edspert_fl_adv/common/constants.dart';
import 'package:edspert_fl_adv/core/entities/event/event_banner.dart';

class EventBannerCard extends StatelessWidget {
  const EventBannerCard(this.eventBanner, {super.key});

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
            child: CachedNetworkImage(
              imageUrl: eventBanner.imageUrl,
              fit: BoxFit.cover,
              imageBuilder: (_, image) => Ink.image(image: image),
              placeholder: (_, __) => const Center(
                child: CircularProgressIndicator(),
              ),
              errorWidget: (_, __, ___) => const Center(
                child: Icon(Icons.broken_image_outlined),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
