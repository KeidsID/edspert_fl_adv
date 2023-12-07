part of '../../use_cases.dart';

/// {@template lib.core.use_cases.auth.register_user}
/// Call [execute] to regiter new user to the server, and also save it to cache.
///
/// Throws [CommonResponseException] if email already registered or invalid params.
/// {@endtemplate}
final class RegisterUser {
  final UsersService _usersService;
  final UserCache _authCache;

  /// {@macro lib.core.use_cases.auth.register_user}
  const RegisterUser({
    required UsersService usersService,
    required UserCache authCache,
  })  : _usersService = usersService,
        _authCache = authCache;

  /// {@macro lib.core.use_cases.auth.register_user}
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

    await _authCache.save(user);

    return user;
  }
}
