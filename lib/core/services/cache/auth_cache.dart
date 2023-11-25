import 'package:edspert_fl_adv/core/entities/user.dart';

abstract interface class AuthCache {
  Future<void> saveUser(User user);
  Future<User?> getUser();
  Future<void> deleteUser();
}
