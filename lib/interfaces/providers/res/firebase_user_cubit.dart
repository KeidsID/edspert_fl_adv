import 'package:root_lib/core/entities/auth/firebase_user.dart';
import 'package:root_lib/core/use_cases.dart';
import 'package:root_lib/infrastructures/container/container.dart' as container;
import '../utils/future_cubit.dart';

typedef FirebaseUserCubitState = AsyncValueState<FirebaseUser?>;

/// {@template lib.interfaces.providers.firebase_user_cubit}
/// Fetch user data from [FirebaseAuth]. If no value, call [fetch] than [refresh]
/// instead.
/// {@endtemplate}
final class FirebaseUserCubit extends FutureCubit<FirebaseUser?> {
  /// {@macro lib.interfaces.providers.firebase_user_cubit}
  FirebaseUserCubit()
      : super(Future(() async {
          final isGoogleSignedIn =
              container.locator<CheckFirebaseSignedInUser>().execute();

          if (!isGoogleSignedIn) {
            // delay to show splash screen.
            await Future.delayed(const Duration(seconds: 2));

            return null;
          }

          return container.locator<LoginWithFirebase>().execute();
        }));

  Future<void> fetch() async {
    try {
      emitLoading();

      final user = await container.locator<LoginWithFirebase>().execute();

      emitValue(user);
    } catch (e) {
      emitError(e);
      rethrow;
    }
  }
}
