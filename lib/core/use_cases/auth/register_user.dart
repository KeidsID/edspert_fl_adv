import 'package:edspert_fl_adv/core/entities/school_detail.dart';
import 'package:edspert_fl_adv/core/entities/user.dart';
import 'package:edspert_fl_adv/core/services/api/users_service.dart';
import 'package:edspert_fl_adv/core/services/cache/auth_cache.dart';
import 'package:edspert_fl_adv/infrastructures/api/errors/common_response_error.dart';

/// {@template edspert_fl_adv.core.use_cases.auth.register_user}
/// Call [execute] to regiter new user to the server, and also save it to cache.
///
/// Throws [CommonResponseError] if email already registered or invalid params.
/// {@endtemplate}
final class RegisterUser {
  final UsersService _usersService;
  final AuthCache _authCache;

  /// {@macro edspert_fl_adv.core.use_cases.auth.register_user}
  const RegisterUser({
    required UsersService usersService,
    required AuthCache authCache,
  })  : _usersService = usersService,
        _authCache = authCache;

  /// {@macro edspert_fl_adv.core.use_cases.auth.register_user}
  Future<User> execute({
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

    return user;
  }
}
