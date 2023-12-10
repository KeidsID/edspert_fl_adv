import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:root_lib/core/entities/course/exercise.dart';

part 'exercises_response.freezed.dart';
part 'exercises_response.g.dart';

@freezed
class ExercisesResponse with _$ExercisesResponse {
  const factory ExercisesResponse({
    required int status,
    required String message,
    required List<RawExercise> data,
  }) = _ExercisesResponse;

  factory ExercisesResponse.fromJson(Map<String, dynamic> json) =>
      _$ExercisesResponseFromJson(json);
}

@freezed
class RawExercise with _$RawExercise {
  const RawExercise._();

  const factory RawExercise({
    @JsonKey(name: 'exercise_id') required String id,
    @JsonKey(name: 'exercise_title') required String title,
    @JsonKey(name: 'access_type') required String accessType,
    @JsonKey(name: 'icon') required String iconUrl,
    @JsonKey(name: 'exercise_user_status') required String status,

    /// Int string.
    @JsonKey(name: 'jumlah_soal') required String count,
    @JsonKey(name: 'jumlah_done') required int completedCount,
  }) = _RawExercise;

  factory RawExercise.fromJson(Map<String, dynamic> json) =>
      _$RawExerciseFromJson(json);

  Exercise toEntity() {
    return Exercise(
      id: id,
      title: title,
      isFree: accessType == 'free',
      iconUrl: iconUrl,
      count: int.parse(count),
      completedCount: completedCount,
    );
  }
}
