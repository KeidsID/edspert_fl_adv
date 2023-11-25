import 'package:edspert_fl_adv/core/entities/school_detail.dart';
import 'package:edspert_fl_adv/core/entities/user.dart';

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
