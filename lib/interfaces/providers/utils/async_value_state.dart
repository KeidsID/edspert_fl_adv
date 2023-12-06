part of 'future_cubit.dart';

/// [FutureCubit] state.
///
/// Inspired by [riverpod](https://pub.dev/packages/riverpod) [AsyncValue].
final class AsyncValueState<T> extends Equatable {
  /// Whether some new value is currently asynchronously loading.
  final bool isLoading;

  /// Indicates that the new value async process is fail.
  ///
  /// This doesn't mean that [value] has changed.
  final bool isError;

  /// Error from failed async process.
  final Object? error;

  /// The value currently exposed.
  ///
  /// Use [requireValue] to ensure that the value is always present.
  final T? value;

  /// Whether [value] is set.
  ///
  /// Even if [hasValue] is true, it is still possible for [isLoading]/[isError]
  /// to also be true.
  final bool hasValue;

  /// Construct state with no value set.
  const AsyncValueState()
      : value = null,
        hasValue = false,
        isLoading = false,
        isError = false,
        error = null;

  const AsyncValueState._({
    this.value,
    required this.hasValue,
    required this.isLoading,
    required this.isError,
    this.error,
  });

  /// Copy state with new values. [value] required to prevent invalid value on
  /// nullable value (`AsyncValueState<T?>`)
  ///
  /// Should only called by [FutureCubit]. Please refer to
  /// [FutureCubit.emitLoading], [FutureCubit.emitError], and
  /// [FutureCubit.emitValue] for safe state update.
  @protected
  AsyncValueState<T> copyWithValue({
    required T? value,
    bool? hasValue,
    bool? isLoading,
    bool? isError,
    Object? error,
  }) {
    return AsyncValueState._(
      value: value,
      hasValue: hasValue ?? this.hasValue,
      isLoading: isLoading ?? this.isLoading,
      isError: isError ?? this.isError,
      error: error ?? this.error,
    );
  }

  @override
  List<Object?> get props {
    return [
      isLoading,
      isError,
      error,
      value,
      hasValue,
    ];
  }
}

extension AsyncValueStateX<T> on AsyncValueState<T> {
  /// If [hasValue] is true, returns the value.
  /// Otherwise throws a [StateError].
  ///
  /// This is typically used for when the UI assumes that [value] is always present.
  T get requireValue {
    if (hasValue) return value as T;

    throw StateError(
      'Tried to call `requireValue` on an `AsyncValueState` that has no value: $this',
    );
  }

  /// Performs an action based on the state of the [AsyncValueState].
  ///
  /// All cases are required, which allows returning a non-nullable value.
  R when<R>({
    bool skipLoading = false,
    bool skipError = false,
    required R Function() loading,
    required R Function(Object error) error,
    required R Function(T data) data,
  }) {
    if (isLoading) {
      if (!skipLoading) return loading();
    }

    if (isError) {
      if (!skipError) return error(this.error!);
    }

    return data(requireValue);
  }
}
