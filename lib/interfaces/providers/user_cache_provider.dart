import 'package:edspert_fl_adv/core/use_cases/auth/login_by_email.dart';
import 'package:edspert_fl_adv/core/use_cases/auth/logout_user.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:edspert_fl_adv/core/entities/school_detail.dart';
import 'package:edspert_fl_adv/core/entities/user.dart';
import 'package:edspert_fl_adv/core/use_cases/auth/get_user_from_cache.dart';
import 'package:edspert_fl_adv/core/use_cases/auth/register_user.dart';
import 'package:edspert_fl_adv/infrastructures/services.dart' as services;

part 'user_cache_provider.g.dart';

@Riverpod(dependencies: [])
class UserCache extends _$UserCache {
  @override
  Future<User?> build() {
    return services.locator<GetUserFromCache>().execute();
  }

  Future<void> loginByEmail(String email) async {
    final previousState = state;
    state = const AsyncLoading();

    try {
      final user = await services.locator<LoginByEmail>().execute(email);

      state = AsyncData(user);
    } catch (e) {
      state = previousState;
      rethrow;
    }
  }

  Future<void> registerUser({
    required String email,
    required String fullname,
    required Gender gender,
    required String schoolName,
    required SchoolDetail schoolDetail,
    required String photoUrl,
  }) async {
    final previousState = state;
    state = const AsyncLoading();

    try {
      final user = await services.locator<RegisterUser>().execute(
            email: email,
            fullname: fullname,
            gender: gender,
            schoolName: schoolName,
            schoolDetail: schoolDetail,
            photoUrl: photoUrl,
          );

      state = AsyncData(user);
    } catch (e) {
      state = previousState;
      rethrow;
    }
  }

  Future<void> logout() async {
    final previousState = state;
    state = const AsyncLoading();

    try {
      await services.locator<LogoutUser>().execute();

      state = const AsyncData(null);
    } catch (e) {
      state = previousState;
      rethrow;
    }
  }
}
