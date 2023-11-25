import 'package:edspert_fl_adv/core/entities/user.dart';
import 'package:edspert_fl_adv/core/services/cache/auth_cache.dart';

class GetUserFromCache {
  const GetUserFromCache({required AuthCache authCache})
      : _authCache = authCache;

  final AuthCache _authCache;

  Future<User?> execute() => _authCache.getUser();
}
