import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:root_lib/core/entities/auth/firebase_user.dart';
import 'package:root_lib/interfaces/providers.dart';
import 'package:root_lib/interfaces/providers/utils/future_cubit.dart';
import 'package:root_lib/interfaces/router/routes/utils/auth_cubits_listener.dart';

typedef AuthCubitState = AsyncValueState<AuthValue>;

/// {@template lib.interfaces.providers.auth_cubit}
/// Controls user authentication.
///
/// [AuthValue.isAuth] controlled by [UserCacheCubit] via [BlocListener].
///
/// [AuthValue.isSignedIn] controlled by [FirebaseUserCubit] via [BlocListener].
///
/// So what [AuthValue.isRegistered] do? Its to verify the signed in user via
/// [AuthCubit.verifySignedInUser] on [BlocListener].
///
/// So when both [AuthValue.isSignedIn] and [AuthValue.isRegistered] are true,
/// then [UserCacheCubit.loginByEmail] should be called to trigger
/// [AuthValue.isAuth].
///
/// Check [authCubitsListener] for the detail.
/// {@endtemplate}
final class AuthCubit extends FutureCubit<AuthValue> {
  /// {@macro lib.interfaces.providers.auth_cubit}
  AuthCubit() : super((() async => AuthValue())());

  AuthValue get _currentValue => state.value ?? AuthValue();

  /// If state is not signed in, this method will do nothing.
  ///
  /// Call this after you signed in.
  Future<void> verifySignedInUser(BuildContext context) async {
    final isSignedIn = _currentValue.isSignedIn;
    final isVerifiedOnce = _currentValue.isVerifiedOnce;

    if (!isSignedIn || isVerifiedOnce) return;

    try {
      emitLoading();

      await context
          .read<UserCacheCubit>()
          .loginByEmail(_currentValue.signedInUser?.email ?? '');

      emitValue(_currentValue.copyWith(isRegistered: true));
    } catch (e) {
      // emitError(e);
      emitValue(_currentValue.copyWith(isVerifiedOnce: true));
      rethrow;
    }
  }

  void toInitState() => emitValue(AuthValue());

  /// Set [state.isAuth] and set false for other values.
  void updateAuthorization([bool isAuth = false]) {
    emitValue(_currentValue.copyWith(
      isAuth: isAuth,
      isRegistered: false,
      copySignedInUser: false,
      signedInUser: null,
      isVerifiedOnce: false,
    ));
  }

  /// Update state to signed in.
  void toSignedInState(FirebaseUser signedInUser) {
    emitValue(_currentValue.copyWith(
      copySignedInUser: false,
      signedInUser: signedInUser,
    ));
  }
}

/// {@template lib.interfaces.providers.auth_cubit.auth_value}
/// Value for [AuthCubit] state.
/// {@endtemplate}
class AuthValue {
  /// Init values to false.
  AuthValue()
      : isAuth = false,
        isRegistered = false,
        signedInUser = null,
        isVerifiedOnce = false;

  /// User authorized to use the app.
  final bool isAuth;

  /// User registered to app server.
  final bool isRegistered;

  final FirebaseUser? signedInUser;

  /// User signed in via third party provider (google, etc).
  ///
  /// Check [signedInUser] for the value.
  bool get isSignedIn => signedInUser != null;

  /// Check if [signedInUser] is verified once by calling
  /// [AuthCubit.verifySignedInUser]. Used to prevent register view popped out,
  /// when verifying [signedInUser].
  ///
  /// This set to true when [AuthCubit.verifySignedInUser] is failed.
  final bool isVerifiedOnce;

  AuthValue._({
    required this.isAuth,
    required this.isRegistered,
    required this.signedInUser,
    required this.isVerifiedOnce,
  });

  @protected
  AuthValue copyWith({
    bool? isAuth,
    bool? isRegistered,
    bool copySignedInUser = true,
    FirebaseUser? signedInUser,
    bool? isVerifiedOnce,
  }) {
    return AuthValue._(
      isAuth: isAuth ?? this.isAuth,
      isRegistered: isRegistered ?? this.isRegistered,
      signedInUser:
          copySignedInUser ? (signedInUser ?? this.signedInUser) : signedInUser,
      isVerifiedOnce: isVerifiedOnce ?? this.isVerifiedOnce,
    );
  }
}
