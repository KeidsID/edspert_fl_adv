part of '../../use_cases.dart';

/// {@template lib.core.use_cases.auth.login_by_email}
/// Call [execute] to get user from server, and save it to cache.
///
/// Throws [CommonResponseException] if user not found.
/// {@endtemplate}
final class LoginByEmail {
  final UsersService _usersService;
  final UserCache _authCache;

  /// {@macro lib.core.use_cases.auth.login_by_email}
  const LoginByEmail({
    required UsersService usersService,
    required UserCache authCache,
  })  : _usersService = usersService,
        _authCache = authCache;

  /// {@macro lib.core.use_cases.auth.login_by_email}
  Future<User> execute(String email) async {
    final user = await _usersService.getUserbyEmail(email);

    await _authCache.save(user);

    return user;
  }
}
