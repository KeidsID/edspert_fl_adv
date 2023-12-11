import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:root_lib/common/constants.dart';

import 'package:root_lib/infrastructures/services/remote/api/errors/common_response_exception.dart';

Object dioExceptionHandler(Object e) {
  if (e is! DioException) return e;

  final response = e.response;

  kLogger.i('dioExceptionHandler request uri', error: e.requestOptions.uri);

  if (response == null) return e;

  final rawResponseBody = jsonDecode(response.data ?? '');

  kLogger.i('dioExceptionHandler response body', error: rawResponseBody);

  return CommonResponseException.fromJson(rawResponseBody);
}
