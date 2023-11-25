import 'package:edspert_fl_adv/core/entities/school_detail.dart';
import 'package:edspert_fl_adv/core/entities/user.dart';
import 'package:edspert_fl_adv/core/services/api/users_service.dart';
import 'package:edspert_fl_adv/core/services/cache/auth_cache.dart';

class RegisterUser {
  const RegisterUser({
    required UsersService usersService,
    required AuthCache authCache,
  })  : _usersService = usersService,
        _authCache = authCache;

  final UsersService _usersService;
  final AuthCache _authCache;

  Future<void> execute({
    required String email,
    required String fullname,
    required Gender gender,
    required String schoolName,
    required SchoolDetail schoolDetail,
    required String photoUrl,
  }) async {
    final user = await _usersService.registerUser(
      email: email,
      fullname: fullname,
      gender: gender,
      schoolName: schoolName,
      schoolDetail: schoolDetail,
      photoUrl: photoUrl,
    );

    await _authCache.saveUser(user);
  }
}
