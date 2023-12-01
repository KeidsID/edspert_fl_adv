import 'dart:convert';

import 'package:dio/dio.dart';

import 'package:edspert_fl_adv/core/entities/course/course.dart';
import 'package:edspert_fl_adv/core/services/api/courses_service.dart';

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
          'user_email;': email,
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
}
