import 'dart:convert';

import 'package:dio/dio.dart';

import 'package:edspert_fl_adv/common/env.dart';

import 'adapter/adapter.dart' show clientAdapter;

final client = Dio(_clientOptions)
  ..interceptors.add(_clientInterceptor)
  ..httpClientAdapter = clientAdapter;

final _clientOptions = BaseOptions(
  baseUrl: 'https://edspert.widyaedu.com',
  headers: {'x-api-key': Env.apiKey},
);

final _clientInterceptor = InterceptorsWrapper(
  onResponse: (res, handler) {
    final rawResponseBody = jsonDecode(res.data ?? '');

    if (rawResponseBody is! Map<String, dynamic>) return handler.next(res);

    /// status from server response body.
    final status = rawResponseBody['status'];

    if (status == null) return handler.next(res);

    if (status == 0) {
      return handler.reject(DioException.badResponse(
        statusCode: 500,
        requestOptions: res.requestOptions,
        response: res,
      ));
    }

    return handler.next(res);
  },
);
