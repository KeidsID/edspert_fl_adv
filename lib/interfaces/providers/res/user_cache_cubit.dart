import 'package:edspert_fl_adv/core/entities/auth/school_detail.dart';
import 'package:edspert_fl_adv/core/entities/auth/user.dart';
import 'package:edspert_fl_adv/core/use_cases.dart';
import 'package:edspert_fl_adv/infrastructures/services.dart' as services;
import '../utils/future_cubit.dart';

final class UserCacheCubit extends FutureCubit<User?> {
  UserCacheCubit() : super(services.locator<GetUserFromCache>().execute());

  Future<void> loginByEmail(String email) async {
    emitLoading();

    try {
      final user = await services.locator<LoginByEmail>().execute(email);

      emitValue(user);
    } catch (e) {
      emitError(e);
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
    emitLoading();

    try {
      final user = await services.locator<RegisterUser>().execute(
            email: email,
            fullname: fullname,
            gender: gender,
            schoolName: schoolName,
            schoolDetail: schoolDetail,
            photoUrl: photoUrl,
          );

      emitValue(user);
    } catch (e) {
      emitError(e);
      rethrow;
    }
  }

  Future<void> logout() async {
    emitLoading();

    try {
      await services.locator<LogoutUser>().execute();

      emitValue(null);
    } catch (e) {
      emitError(e);
      rethrow;
    }
  }

  /// Email already provided by previous login state. So make sure [state] value
  /// are not null.
  Future<void> updateUserByEmail({
    required String fullname,
    required Gender gender,
    required String schoolName,
    required SchoolDetail schoolDetail,
    required String photoUrl,
  }) async {
    emitLoading();

    try {
      final updatedUser = await services.locator<UpdateUserByEmail>().execute(
            state.value!.email,
            fullname: fullname,
            gender: gender,
            schoolName: schoolName,
            schoolDetail: schoolDetail,
            photoUrl: photoUrl,
          );

      emitValue(updatedUser);
    } catch (e) {
      emitError(e);
      rethrow;
    }
  }
}
