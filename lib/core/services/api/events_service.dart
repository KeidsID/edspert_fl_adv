import 'package:root_lib/core/entities/event/event_banner.dart';

abstract interface class EventsService {
  Future<List<EventBanner>> getEventBanners(int limit);
}
