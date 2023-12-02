import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:edspert_fl_adv/core/entities/event/event_banner.dart';
import 'package:edspert_fl_adv/core/use_cases.dart';
import 'package:edspert_fl_adv/infrastructures/services.dart' as services;

part 'event_banners_provider.g.dart';

@Riverpod(keepAlive: true)
Future<List<EventBanner>> eventBanners(EventBannersRef ref) {
  return services.locator<GetEventBanners>().execute();
}
