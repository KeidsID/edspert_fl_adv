import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:edspert_fl_adv/core/entities/event/event_banner.dart';

part 'event_banners_response.freezed.dart';
part 'event_banners_response.g.dart';

@freezed
class EventBannersResponse with _$EventBannersResponse {
  const factory EventBannersResponse({
    required int status,
    required String message,
    required List<RawEventBanner> data,
  }) = _EventBannersResponse;

  factory EventBannersResponse.fromJson(Map<String, dynamic> json) =>
      _$EventBannersResponseFromJson(json);
}

@freezed
class RawEventBanner with _$RawEventBanner {
  const RawEventBanner._();

  const factory RawEventBanner({
    @JsonKey(name: 'event_id') required String id,
    @JsonKey(name: 'event_title') required String title,
    @JsonKey(name: 'event_description') required String description,
    @JsonKey(name: 'event_image') required String imageUrl,
    @JsonKey(name: 'event_url') required String eventUrl,
  }) = _RawEventBanner;

  factory RawEventBanner.fromJson(Map<String, dynamic> json) =>
      _$RawEventBannerFromJson(json);

  EventBanner toEntity() {
    return EventBanner(
      id: id,
      title: title,
      description: description,
      eventUrl: Uri.tryParse(eventUrl),
      imageUrl: imageUrl,
    );
  }
}
