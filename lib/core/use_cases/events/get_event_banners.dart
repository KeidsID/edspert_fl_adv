part of '../../use_cases.dart';

/// {@template lib.core.use_cases.event.get_event_banners}
/// Call [execute] to get event banners from server.
/// {@endtemplate}
final class GetEventBanners {
  final EventsService _eventService;

  /// {@macro lib.core.use_cases.event.get_event_banners}
  const GetEventBanners({required EventsService eventService})
      : _eventService = eventService;

  /// {@macro lib.core.use_cases.event.get_event_banners}
  Future<List<EventBanner>> execute({int limit = 5}) =>
      _eventService.getEventBanners(limit);
}
