import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:edspert_fl_adv/core/entities/school_detail.dart';
import 'package:edspert_fl_adv/core/entities/user.dart';

part 'users_service_response.freezed.dart';
part 'users_service_response.g.dart';

@freezed
class UsersServiceResponse with _$UsersServiceResponse {
  const factory UsersServiceResponse({
    required int status,
    required String message,
    required RawUser data,
  }) = _UsersServiceResponse;

  factory UsersServiceResponse.fromJson(Map<String, dynamic> json) =>
      _$UsersServiceResponseFromJson(json);
}

@freezed
class RawUser with _$RawUser {
  const RawUser._();

  const factory RawUser({
    @JsonKey(name: 'iduser') required String id,
    @JsonKey(name: 'user_name') required String name,
    @JsonKey(name: 'user_email') required String email,
    @JsonKey(name: 'user_foto') required String photoUrl,
    @JsonKey(name: 'user_asal_sekolah') required String schoolName,
    @JsonKey(name: 'date_create') required DateTime createDate,
    @JsonKey(name: 'user_gender') required String gender,
    @JsonKey(name: 'user_status') required String status,

    /// 10, 11, 12, dkk.
    @JsonKey(name: 'kelas') required String schoolGrade,
  }) = _RawUser;

  factory RawUser.fromJson(Map<String, dynamic> json) =>
      _$RawUserFromJson(json);

  User toEntity() {
    return User(
      id: id,
      name: name,
      email: email,
      photoUrl: photoUrl,
      schoolName: schoolName,
      schoolDetail: SchoolDetail(
        num.parse(schoolGrade).toInt(),
        isSpecializedSchool: schoolName.startsWith('SMK'),
      ),
      createDate: createDate,
      gender: Gender.fromString(gender),
      status: status,
    );
  }
}
