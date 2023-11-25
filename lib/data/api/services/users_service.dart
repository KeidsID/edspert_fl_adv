import 'dart:convert';

import 'package:dio/dio.dart';

import '../errors/common_error_response.dart';
import '../models/school_detail.dart';
import '../models/user.dart';
import '../models/users_service_response.dart';

final class UsersService {
  UsersService(BaseOptions clientOptions)
      : _client = Dio(clientOptions.copyWith(path: '/users'));

  final Dio _client;

  Future<User> getUserbyEmail(String email) async {
    final response = await _client.get<String>('', queryParameters: {
      'email': email,
    });
    final rawResponseBody = jsonDecode(response.data ?? '');

    try {
      final responseBody = UsersServiceResponse.fromJson(rawResponseBody);

      return responseBody.data.toEntity();
    } catch (e) {
      throw CommonErrorResponse.fromJson(rawResponseBody);
    }
  }

  Future<User> registerUser({
    required String email,
    required String fullname,
    required Gender gender,
    required String schoolName,
    required SchoolDetail schoolDetail,
    required String photoUrl,
  }) async {
    final response = await _client.post<String>(
      '/registrasi',
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

    try {
      final responseBody = UsersServiceResponse.fromJson(rawResponseBody);

      return responseBody.data.toEntity();
    } catch (e) {
      throw CommonErrorResponse.fromJson(rawResponseBody);
    }
  }

  Future<User> updateUserByEmail(
    String email, {
    required String fullname,
    required Gender gender,
    required String schoolName,
    required SchoolDetail schoolDetail,
    required String photoUrl,
  }) async {
    final response = await _client.post<String>(
      '/update',
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

    try {
      final responseBody = UsersServiceResponse.fromJson(rawResponseBody);

      return responseBody.data.toEntity();
    } catch (e) {
      throw CommonErrorResponse.fromJson(rawResponseBody);
    }
  }
}
