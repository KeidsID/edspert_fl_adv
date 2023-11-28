import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'package:edspert_fl_adv/common/assets_paths.dart';

class NetworkImageCircleAvatar extends StatelessWidget {
  const NetworkImageCircleAvatar(
    this.imageUrl, {
    super.key,
    this.radius,
    this.onTap,
  });

  final String imageUrl;

  final double? radius;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: CircleAvatar(
        radius: radius,
        child: CachedNetworkImage(
          imageUrl: imageUrl,
          imageBuilder: (_, imgProv) => Ink.image(image: imgProv),
          placeholder: (_, __) => const Center(
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: CircularProgressIndicator(),
            ),
          ),
          errorWidget: (_, __, ___) => Image.asset(AssetsPaths.dummyAvatar),
        ),
      ),
    );
  }
}
