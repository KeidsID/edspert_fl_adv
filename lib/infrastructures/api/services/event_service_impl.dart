import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:edspert_fl_adv/core/entities/event/event_banner.dart';

import 'package:edspert_fl_adv/core/services.dart';
import 'package:edspert_fl_adv/infrastructures/api/models/event_banners_response.dart';

final class EventServiceImpl implements EventService {
  EventServiceImpl(Dio client) : _client = client;

  final Dio _client;

  @override
  Future<List<EventBanner>> getEventBanners(int limit) async {
    final rawRes = await _client.get<String>('/event/list', queryParameters: {
      'limit': '$limit',
    });
    final rawResBody = jsonDecode(rawRes.data ?? '');

    final resBody = EventBannersResponse.fromJson(rawResBody);

    return resBody.data.map((e) => e.toEntity()).toList();
  }
}
