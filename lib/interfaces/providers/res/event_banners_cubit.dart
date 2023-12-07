import 'package:root_lib/core/entities/event/event_banner.dart';
import 'package:root_lib/core/use_cases.dart';
import 'package:root_lib/infrastructures/container.dart' as container;
import '../utils/future_cubit.dart';

final class EventBannersCubit extends FutureCubit<List<EventBanner>> {
  EventBannersCubit() : super(container.locator<GetEventBanners>().execute());
}
