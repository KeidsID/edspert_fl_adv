import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'common_error_response.freezed.dart';
part 'common_error_response.g.dart';

@freezed
class CommonErrorResponse extends Error with _$CommonErrorResponse {
  const factory CommonErrorResponse({
    required int status,
    required String message,
  }) = _CommonErrorResponse;

  factory CommonErrorResponse.fromJson(Map<String, dynamic> json) =>
      _$CommonErrorResponseFromJson(json);
}
