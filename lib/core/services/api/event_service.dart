import 'package:edspert_fl_adv/core/entities/event/event_banner.dart';

abstract interface class EventService {
  Future<List<EventBanner>> getEventBanners(int limit);
}
