import 'dart:convert';

import 'package:dio/dio.dart';

import 'package:edspert_fl_adv/core/entities/school_detail.dart';
import 'package:edspert_fl_adv/core/entities/user.dart';
import 'package:edspert_fl_adv/core/services/api/users_service.dart';
import 'package:edspert_fl_adv/infrastructures/api/errors/common_response_error.dart';
import 'package:edspert_fl_adv/infrastructures/api/models/users_service_response.dart';

final class UsersServiceImpl implements UsersService {
  UsersServiceImpl(BaseOptions clientOptions)
      : _client = Dio(clientOptions.copyWith(path: '/users'));

  final Dio _client;

  @override
  Future<User> getUserbyEmail(String email) async {
    final response = await _client.get<String>('', queryParameters: {
      'email': email,
    });
    final rawResponseBody = jsonDecode(response.data ?? '');

    try {
      final responseBody = UsersServiceResponse.fromJson(rawResponseBody);

      return responseBody.data.toEntity();
    } catch (e) {
      throw CommonResponseError.fromJson(rawResponseBody);
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
      throw CommonResponseError.fromJson(rawResponseBody);
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
      throw CommonResponseError.fromJson(rawResponseBody);
    }
  }
}
