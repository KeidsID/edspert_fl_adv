import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:edspert_fl_adv/core/entities/course/course.dart';

part 'courses_response.freezed.dart';
part 'courses_response.g.dart';

@freezed
class CoursesResponse with _$CoursesResponse {
  const factory CoursesResponse({
    required int status,
    required String message,
    required List<RawCourse> data,
  }) = _CoursesResponse;

  factory CoursesResponse.fromJson(Map<String, dynamic> json) =>
      _$CoursesResponseFromJson(json);
}

@freezed
class RawCourse with _$RawCourse {
  const RawCourse._();

  const factory RawCourse({
    @JsonKey(name: 'course_id') required String id,

    /// "IPA" & "IPS".
    @JsonKey(name: 'major_name') required String major,
    @JsonKey(name: 'course_category') required String category,
    @JsonKey(name: 'course_name') required String name,
    @JsonKey(name: 'url_cover') required String coverImageUrl,
    @JsonKey(name: 'jumlah_materi') required int studiesCount,
    @JsonKey(name: 'jumlah_done') required int completedStudiesCount,
    required double progress,
  }) = _RawCourse;

  factory RawCourse.fromJson(Map<String, dynamic> json) =>
      _$RawCourseFromJson(json);

  Course toEntity() {
    return Course(
      id: id,
      major: SchoolMajor.fromString(major),
      category: category,
      name: name,
      coverImageUrl: coverImageUrl,
      studiesCount: studiesCount,
      completedStudiesCount: completedStudiesCount,
      progress: progress,
    );
  }
}
