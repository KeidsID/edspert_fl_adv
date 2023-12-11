import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:root_lib/core/entities/auth/school_detail.dart';
import 'package:root_lib/core/entities/auth/user.dart';
import 'package:root_lib/core/use_cases.dart';
import 'package:root_lib/infrastructures/container/container.dart' as container;
import 'package:root_lib/interfaces/providers.dart';
import '../../utils/future_cubit.dart';

typedef UserCacheCubitState = AsyncValueState<User?>;

final class UserCacheCubit extends FutureCubit<User?> {
  UserCacheCubit()
      : super(() => container.locator<GetUserFromCache>().execute());

  Future<void> loginByEmail(String email) async {
    emitLoading();

    try {
      final user = await container.locator<LoginByEmail>().execute(email);

      emitValue(user);
    } catch (e) {
      emitError(e);
      rethrow;
    }
  }

  Future<void> registerUser(
    BuildContext context, {
    required String email,
    required String fullname,
    required Gender gender,
    required String schoolName,
    required SchoolDetail schoolDetail,
    required String photoUrl,
  }) async {
    emitLoading();

    try {
      final authCubit = context.read<AuthCubit>();

      final user = await container.locator<RegisterUser>().execute(
            email: email,
            fullname: fullname,
            gender: gender,
            schoolName: schoolName,
            schoolDetail: schoolDetail,
            photoUrl: photoUrl,
          );

      emitValue(user);
      authCubit.updateAuthorization(true);
    } catch (e) {
      emitError(e);
      rethrow;
    }
  }

  Future<void> logout(BuildContext context) async {
    emitLoading();

    try {
      final authCubit = context.read<AuthCubit>();

      await container.locator<LogoutUser>().execute();
      authCubit.refresh();

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
      final updatedUser = await container.locator<UpdateUserByEmail>().execute(
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
