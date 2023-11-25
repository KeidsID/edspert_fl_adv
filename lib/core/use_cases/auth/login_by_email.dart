import 'package:edspert_fl_adv/core/entities/user.dart';
import 'package:edspert_fl_adv/core/services/api/users_service.dart';
import 'package:edspert_fl_adv/core/services/cache/auth_cache.dart';
import 'package:edspert_fl_adv/infrastructures/api/errors/common_response_error.dart';

/// {@template edspert_fl_adv.core.use_cases.auth.login_by_email}
/// Call [execute] to get user from server, and save it to cache.
///
/// Throws [CommonResponseError] if user not found.
/// {@endtemplate}
final class LoginByEmail {
  final UsersService _usersService;
  final AuthCache _authCache;

  /// {@macro edspert_fl_adv.core.use_cases.auth.login_by_email}
  const LoginByEmail({
    required UsersService usersService,
    required AuthCache authCache,
  })  : _usersService = usersService,
        _authCache = authCache;

  /// {@macro edspert_fl_adv.core.use_cases.auth.login_by_email}
  Future<User> execute(String email) async {
    final user = await _usersService.getUserbyEmail(email);

    await _authCache.saveUser(user);

    return user;
  }
}
