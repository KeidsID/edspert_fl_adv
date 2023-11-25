import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'common_response_error.freezed.dart';
part 'common_response_error.g.dart';

@freezed
class CommonResponseError with _$CommonResponseError {
  const factory CommonResponseError({
    required int status,
    required String message,
  }) = _CommonResponseError;

  factory CommonResponseError.fromJson(Map<String, dynamic> json) =>
      _$CommonResponseErrorFromJson(json);
}
