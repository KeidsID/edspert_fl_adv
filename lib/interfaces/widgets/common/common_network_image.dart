import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

/// {@template lib.interfaces.widgets.common.common_network_image}
/// Its just [CachedNetworkImage] with custom builders.
///
/// The [placeholder] and [errorWidget] are still customizable on constructor,
/// but changed to [loadingBuilder] and [errorBuilder].
/// {@endtemplate}
class CommonNetworkImage extends CachedNetworkImage {
  /// {@macro lib.interfaces.widgets.common.common_network_image}
  CommonNetworkImage(
    String imageUrl, {
    super.key,
    super.width,
    super.height,
    super.alignment,
    super.fit,
    super.repeat,
    super.color,
    super.colorBlendMode,
    PlaceholderWidgetBuilder? loadingBuilder,
    LoadingErrorWidgetBuilder? errorBuilder,
  }) : super(
          imageUrl: imageUrl,
          imageBuilder: (_, image) => Ink.image(image: image),
          placeholder: loadingBuilder ??
              (_, __) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              },
          errorWidget: errorBuilder ??
              (_, __, ___) {
                return const Center(
                  child: Icon(Icons.broken_image_outlined),
                );
              },
        );
}
