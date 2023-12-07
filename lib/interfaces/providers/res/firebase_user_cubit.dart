import 'package:root_lib/core/entities/auth/firebase_user.dart';
import 'package:root_lib/core/use_cases.dart';
import 'package:root_lib/infrastructures/container.dart' as container;
import '../utils/future_cubit.dart';

typedef FirebaseUserCubitState = AsyncValueState<FirebaseUser?>;

/// {@template lib.interfaces.providers.firebase_user_cubit}
/// Its build [Future.value] with null value. So [refresh] will set value to null.
/// Call [fetch] to fetch the [FirebaseUser].
/// {@endtemplate}
final class FirebaseUserCubit extends FutureCubit<FirebaseUser?> {
  /// {@macro lib.interfaces.providers.firebase_user_cubit}
  FirebaseUserCubit()
      : super(Future(() async {
          final isGoogleSignedIn =
              container.locator<CheckFirebaseSignedInUser>().execute();

          if (!isGoogleSignedIn) return null;

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
