import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'async_value_state.dart';

/// {@template lib.interfaces.providers.utils.future_cubit}
/// Cubit for [Future] value.
///
/// So the value will be build to update the state. Once the value is resolved,
/// the state will contain the value from the [Future]. Refer [AsyncValueState]
/// for the state details.
///
/// In case you need to rebuild the cubit, just call [refresh].
///
/// Delayed counter cubit example:
/// ```dart
/// final class FutureCounterCubit extends FutureCubit<int> {
///   FutureCounterCubit(int initialValue)
///       : super(Future.delayed(_delay, () => initialValue));
///
///   static const _delay = Duration(seconds: 1);
///
///   Future<void> increment() async {
///     emitLoading();
///
///     await Future.delayed(_delay);
///
///     emitValue((state.value ?? 0) + 1);
///   }
///
///   Future<void> decrement() async {
///     emitLoading();
///
///     await Future.delayed(_delay);
///
///     emitValue((state.value ?? 0) - 1);
///   }
/// }
/// ```
///
/// Inspired by [riverpod](https://pub.dev/packages/riverpod) [FutureProvider].
/// {@endtemplate}
abstract base class FutureCubit<T> extends Cubit<AsyncValueState<T>> {
  /// {@macro lib.interfaces.providers.utils.future_cubit}
  FutureCubit(Future<T> value)
      : _future = value,
        super(AsyncValueState<T>()) {
    _build();
  }

  /// Future value to build.
  final Future<T> _future;

  Future<void> _build() async {
    try {
      emitLoading();

      final value = await _future;

      emitValue(value);
    } catch (e) {
      emitError(e);
    }
  }

  /// Rebuild the cubit.
  Future<void> refresh() => _build();

  /// Update the state into loading state.
  void emitLoading() => emit(state.copyWith(isLoading: true, isError: false));

  /// Update the state into error state.
  void emitError(Object error) {
    emit(state.copyWith(isLoading: false, isError: true, error: error));
  }

  /// Update the state with a new value.
  void emitValue(T value) {
    emit(state.copyWith(
      isLoading: false,
      isError: false,
      value: value,
      hasValue: true,
    ));
  }
}
