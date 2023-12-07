import 'package:root_lib/core/entities/auth/user.dart';

abstract interface class UserCache {
  Future<void> save(User user);
  Future<User?> get();
  Future<void> delete();
}
