import 'package:root_lib/core/entities/auth/school_detail.dart';
import 'package:root_lib/core/entities/auth/user.dart';

abstract interface class UsersService {
  Future<User> getUserbyEmail(String email);

  Future<User> registerUser({
    required String email,
    required String fullname,
    required Gender gender,
    required String schoolName,
    required SchoolDetail schoolDetail,
    required String photoUrl,
  });

  Future<User> updateUserByEmail(
    String email, {
    required String fullname,
    required Gender gender,
    required String schoolName,
    required SchoolDetail schoolDetail,
    required String photoUrl,
  });
}
