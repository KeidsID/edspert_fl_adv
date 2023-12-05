import 'package:root_lib/core/entities/event/event_banner.dart';
import 'package:root_lib/core/use_cases/events/get_event_banners.dart';
import 'package:root_lib/infrastructures/services.dart' as services;
import '../utils/future_cubit.dart';

final class EventBannersCubit extends FutureCubit<List<EventBanner>> {
  EventBannersCubit() : super(services.locator<GetEventBanners>().execute());
}
