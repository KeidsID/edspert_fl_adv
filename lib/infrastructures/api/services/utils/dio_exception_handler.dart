import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:edspert_fl_adv/common/constants.dart';

import 'package:edspert_fl_adv/infrastructures/api/errors/common_response_exception.dart';

void dioExceptionHandler(DioException e) {
  final response = e.response;

  kLogger.d('dioExceptionHandler request uri', error: e.requestOptions.uri);

  if (response == null) throw e;

  final rawResponseBody = jsonDecode(response.data ?? '');

  throw CommonResponseException.fromJson(rawResponseBody);
}
