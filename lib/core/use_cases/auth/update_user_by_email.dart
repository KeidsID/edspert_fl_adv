part of '../../use_cases.dart';

/// {@template lib.core.use_cases.auth.update_user}
/// Call [execute] to update user in the server, and also save it to cache.
/// {@endtemplate}
final class UpdateUserByEmail {
  final UsersService _usersService;
  final AuthCache _authCache;

  /// {@macro lib.core.use_cases.auth.update_user}
  const UpdateUserByEmail({
    required UsersService usersService,
    required AuthCache authCache,
  })  : _usersService = usersService,
        _authCache = authCache;

  /// {@macro lib.core.use_cases.auth.update_user}
  Future<User> execute(
    String email, {
    required String fullname,
    required Gender gender,
    required String schoolName,
    required SchoolDetail schoolDetail,
    required String photoUrl,
  }) async {
    final updatedUser = await _usersService.updateUserByEmail(
      email,
      fullname: fullname,
      gender: gender,
      schoolName: schoolName,
      schoolDetail: schoolDetail,
      photoUrl: photoUrl,
    );

    await _authCache.save(updatedUser);

    return updatedUser;
  }
}
