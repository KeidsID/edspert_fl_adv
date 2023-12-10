import 'dart:convert';

import 'package:dio/dio.dart';

import 'package:root_lib/core/entities/course/course.dart';
import 'package:root_lib/core/entities/course/exercise.dart';
import 'package:root_lib/core/services/remote/api/courses_service.dart';
import 'package:root_lib/infrastructures/services/remote/api/models/exercises_response.dart';

import '../models/courses_response.dart';
import 'utils/dio_exception_handler.dart';

final class CoursesServiceImpl implements CoursesService {
  final Dio _client;

  const CoursesServiceImpl(Dio client) : _client = client;

  static const _basePath = '/exercise';

  @override
  Future<List<Course>> getCoursesByMajor(
    String email, {
    SchoolMajor major = SchoolMajor.ipa,
  }) async {
    try {
      final rawRes = await _client.get<String>(
        '$_basePath/data_course',
        queryParameters: {
          'major_name': '$major',
          'user_email': email,
        },
      );

      final rawResBody = jsonDecode(rawRes.data ?? '');

      final resBody = CoursesResponse.fromJson(rawResBody);

      return resBody.data.map((e) => e.toEntity()).toList();
    } catch (e) {
      if (e is DioException) dioExceptionHandler(e);

      rethrow;
    }
  }

  @override
  Future<List<Exercise>> getExercisesFromCourse({
    required String courseId,
    required String email,
  }) async {
    try {
      final rawRes = await _client.get<String>(
        '$_basePath/data_exercise',
        queryParameters: {
          'course_id': courseId,
          'user_email': email,
        },
      );

      final rawResBody = jsonDecode(rawRes.data ?? '');

      final resBody = ExercisesResponse.fromJson(rawResBody);

      return resBody.data.map((e) => e.toEntity()).toList();
    } catch (e) {
      if (e is DioException) dioExceptionHandler(e);

      rethrow;
    }
  }
}
