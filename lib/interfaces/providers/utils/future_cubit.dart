import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'async_value_state.dart';

typedef FutureCubitBuilder<T> = Future<T> Function();

/// {@template lib.interfaces.providers.utils.future_cubit}
/// Cubit for [Future] value.
///
/// So the value will be build to update the state. Once the value is resolved,
/// the state will contain the value from the [Future]. Refer [AsyncValueState]
/// for the state details.
///
/// To update [FutureCubit] state, use [emitLoading], [emitError], and
/// [emitValue] for safe [emit].
///
/// In case you need to rebuild the cubit, just call [refresh].
///
/// Inspired by [riverpod](https://pub.dev/packages/riverpod) [FutureProvider].
/// {@endtemplate}
abstract base class FutureCubit<T> extends Cubit<AsyncValueState<T>> {
  /// {@macro lib.interfaces.providers.utils.future_cubit}
  FutureCubit(FutureCubitBuilder<T> builder)
      : _futureBuilder = builder,
        super(AsyncValueState<T>()) {
    _build();
  }

  final FutureCubitBuilder<T> _futureBuilder;

  Future<void> _build() async {
    try {
      emitLoading();

      final value = await _futureBuilder();

      emitValue(value);
    } catch (e) {
      emitError(e);
    }
  }

  /// Rebuild the cubit.
  Future<void> refresh() => _build();

  /// Update the state into loading state.
  @protected
  @visibleForTesting
  void emitLoading() => emit(state.copyWith(isLoading: true, isError: false));

  /// Update the state into error state.
  @protected
  @visibleForTesting
  void emitError(Object error) {
    emit(state.copyWith(isLoading: false, isError: true, error: error));
  }

  /// Update the state with a new value.
  @protected
  @visibleForTesting
  void emitValue(T value) {
    emit(state.copyWith(
      copyValue: false,
      value: value,
      hasValue: true,
      isLoading: false,
      isError: false,
    ));
  }
}
