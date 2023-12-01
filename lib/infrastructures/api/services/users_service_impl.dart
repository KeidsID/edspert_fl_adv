import 'dart:convert';

import 'package:dio/dio.dart';

import 'package:edspert_fl_adv/core/entities/auth/school_detail.dart';
import 'package:edspert_fl_adv/core/entities/auth/user.dart';
import 'package:edspert_fl_adv/core/services/api/users_service.dart';
import 'package:edspert_fl_adv/infrastructures/api/models/users_service_response.dart';
import 'utils/dio_exception_handler.dart';

final class UsersServiceImpl implements UsersService {
  UsersServiceImpl(Dio client) : _client = client;

  final Dio _client;

  static const _basePath = '/users';

  @override
  Future<User> getUserbyEmail(String email) async {
    try {
      final rawRes = await _client.get<String>(_basePath, queryParameters: {
        'email': email,
      });
      final rawResBody = jsonDecode(rawRes.data ?? '');

      final resBody = UsersServiceResponse.fromJson(rawResBody);

      return resBody.data.toEntity();
    } catch (e) {
      if (e is DioException) dioExceptionHandler(e);

      rethrow;
    }
  }

  @override
  Future<User> registerUser({
    required String email,
    required String fullname,
    required Gender gender,
    required String schoolName,
    required SchoolDetail schoolDetail,
    required String photoUrl,
  }) async {
    try {
      final rawRes = await _client.post<String>(
        '$_basePath/registrasi',
        options: Options(contentType: Headers.multipartFormDataContentType),
        data: FormData.fromMap({
          'email': email,
          'nama_lengkap': fullname,
          'gender': '$gender',
          'nama_sekolah': schoolName,
          'kelas': '${schoolDetail.grade}',
          'jenjang': '${schoolDetail.schoolLevel}',
          'foto': photoUrl,
        }),
      );
      final rawResBody = jsonDecode(rawRes.data ?? '');

      final resBody = UsersServiceResponse.fromJson(rawResBody);

      return resBody.data.toEntity();
    } catch (e) {
      if (e is DioException) dioExceptionHandler(e);

      rethrow;
    }
  }

  @override
  Future<User> updateUserByEmail(
    String email, {
    required String fullname,
    required Gender gender,
    required String schoolName,
    required SchoolDetail schoolDetail,
    required String photoUrl,
  }) async {
    try {
      final rawRes = await _client.post<String>(
        '$_basePath/update',
        options: Options(contentType: Headers.multipartFormDataContentType),
        data: FormData.fromMap({
          'email': email,
          'nama_lengkap': fullname,
          'gender': '$gender',
          'nama_sekolah': schoolName,
          'kelas': '${schoolDetail.grade}',
          'jenjang': '${schoolDetail.schoolLevel}',
          'foto': photoUrl,
        }),
      );
      final rawResBody = jsonDecode(rawRes.data ?? '');

      final resBody = UsersServiceResponse.fromJson(rawResBody);

      return resBody.data.toEntity();
    } catch (e) {
      if (e is DioException) dioExceptionHandler(e);

      rethrow;
    }
  }
}
