import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:root_lib/common/constants.dart';

import 'package:root_lib/infrastructures/api/errors/common_response_exception.dart';

void dioExceptionHandler(DioException e) {
  final response = e.response;

  kLogger.d('dioExceptionHandler request uri', error: e.requestOptions.uri);

  if (response == null) throw e;

  final rawResponseBody = jsonDecode(response.data ?? '');

  throw CommonResponseException.fromJson(rawResponseBody);
}
