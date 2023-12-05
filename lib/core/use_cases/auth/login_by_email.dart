import 'package:root_lib/core/entities/auth/user.dart';
import 'package:root_lib/core/services/api/users_service.dart';
import 'package:root_lib/core/services/cache/auth_cache.dart';
import 'package:root_lib/infrastructures/api/errors/common_response_exception.dart';

/// {@template lib.core.use_cases.auth.login_by_email}
/// Call [execute] to get user from server, and save it to cache.
///
/// Throws [CommonResponseException] if user not found.
/// {@endtemplate}
final class LoginByEmail {
  final UsersService _usersService;
  final AuthCache _authCache;

  /// {@macro lib.core.use_cases.auth.login_by_email}
  const LoginByEmail({
    required UsersService usersService,
    required AuthCache authCache,
  })  : _usersService = usersService,
        _authCache = authCache;

  /// {@macro lib.core.use_cases.auth.login_by_email}
  Future<User> execute(String email) async {
    final user = await _usersService.getUserbyEmail(email);

    await _authCache.save(user);

    return user;
  }
}
