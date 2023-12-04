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

  /// Copy state with new values.
  ///
  /// Should only called by [FutureCubit].
  @protected
  AsyncValueState<T> copyWith({
    T? value,
    bool? hasValue,
    bool? isLoading,
    bool? isError,
    Object? error,
  }) {
    return AsyncValueState._(
      value: value ?? this.value,
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
