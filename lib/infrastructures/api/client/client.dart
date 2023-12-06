import 'dart:convert';

import 'package:dio/dio.dart';

import 'package:root_lib/common/env.dart';

final client = Dio(_clientOptions)..interceptors.add(_clientInterceptor);

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
