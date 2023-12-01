import 'package:edspert_fl_adv/core/entities/event/event_banner.dart';
import 'package:edspert_fl_adv/core/services/api/event_service.dart';

/// {@template lib.core.use_cases.event.get_event_banners}
/// Call [execute] to get event banners from server.
/// {@endtemplate}
final class GetEventBanners {
  final EventService _eventService;

  /// {@macro lib.core.use_cases.event.get_event_banners}
  const GetEventBanners({required EventService eventService})
      : _eventService = eventService;

  /// {@macro lib.core.use_cases.event.get_event_banners}
  Future<List<EventBanner>> execute({int limit = 5}) =>
      _eventService.getEventBanners(limit);
}
