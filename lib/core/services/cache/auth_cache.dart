import 'package:edspert_fl_adv/core/entities/auth/user.dart';

abstract interface class AuthCache {
  Future<void> save(User user);
  Future<User?> get();
  Future<void> delete();
}
