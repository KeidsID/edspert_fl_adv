part of '../../use_cases.dart';

/// {@template lib.core.use_cases.auth.get_user_from_cache}
/// Call [execute] to get user from cache.
/// {@endtemplate}
final class GetUserFromCache {
  final AuthCache _authCache;

  /// {@macro lib.core.use_cases.auth.get_user_from_cache}
  const GetUserFromCache({required AuthCache authCache})
      : _authCache = authCache;

  /// {@macro lib.core.use_cases.auth.get_user_from_cache}
  Future<User?> execute() => _authCache.get();
}
