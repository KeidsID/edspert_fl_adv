import 'package:edspert_fl_adv/interfaces/widgets.dart';
import 'package:flutter/material.dart';

import 'package:edspert_fl_adv/common/assets_paths.dart';

class NetworkCircleAvatar extends CircleAvatar {
  NetworkCircleAvatar(
    String imageUrl, {
    super.key,
    super.radius,
    VoidCallback? onTap,
  }) : super(
          child: GestureDetector(
            onTap: onTap,
            child: CommonNetworkImage(
              imageUrl,
              errorBuilder: (_, __, ___) =>
                  Image.asset(AssetsPaths.dummyAvatar),
            ),
          ),
        );
}
