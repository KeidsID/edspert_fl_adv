import 'dart:convert';

import 'package:dio/dio.dart';

import 'package:edspert_fl_adv/core/entities/school_detail.dart';
import 'package:edspert_fl_adv/core/entities/user.dart';
import 'package:edspert_fl_adv/core/services/api/users_service.dart';
import 'package:edspert_fl_adv/infrastructures/api/errors/common_response_exception.dart';
import 'package:edspert_fl_adv/infrastructures/api/models/users_service_response.dart';

final class UsersServiceImpl implements UsersService {
  UsersServiceImpl(Dio client) : _client = client;

  final Dio _client;

  void _dioExceptionHandler(DioException e) {
    final response = e.response;

    if (response == null) throw e;

    final rawResponseBody = jsonDecode(response.data ?? '');

    throw CommonResponseException.fromJson(rawResponseBody);
  }

  @override
  Future<User> getUserbyEmail(String email) async {
    try {
      final response = await _client.get<String>('/users', queryParameters: {
        'email': email,
      });
      final rawResponseBody = jsonDecode(response.data ?? '');

      final responseBody = UsersServiceResponse.fromJson(rawResponseBody);

      return responseBody.data.toEntity();
    } catch (e) {
      if (e is DioException) _dioExceptionHandler(e);

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
      final response = await _client.post<String>(
        '/users/registrasi',
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
      final rawResponseBody = jsonDecode(response.data ?? '');

      final responseBody = UsersServiceResponse.fromJson(rawResponseBody);

      return responseBody.data.toEntity();
    } catch (e) {
      if (e is DioException) _dioExceptionHandler(e);

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
      final response = await _client.post<String>(
        '/users/update',
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
      final rawResponseBody = jsonDecode(response.data ?? '');

      final responseBody = UsersServiceResponse.fromJson(rawResponseBody);

      return responseBody.data.toEntity();
    } catch (e) {
      if (e is DioException) _dioExceptionHandler(e);

      rethrow;
    }
  }
}
