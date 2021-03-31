
/// I would use a package (freezed specifically) to generate this,
/// but doing it manually for the sake of demonstration.
class CubitState<TData, TError> {
  final bool isLoading;
  final TError? error;
  final TData? data;

  CubitState({
    this.isLoading = false,
    required this.error,
    required this.data,
  });

  factory CubitState.initialState([bool isLoading = false]) {
    return CubitState(
        isLoading: isLoading,
        error: null,
        data: null,
    );
  }

  CubitState<TData, TError> copyWith({bool? isLoading, TData? data, TError? error}) {
    return CubitState<TData, TError>(
      isLoading: isLoading ?? this.isLoading,
      data: data ?? this.data,
      error: error ?? this.error,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CubitState &&
          runtimeType == other.runtimeType &&
          isLoading == other.isLoading &&
          error == other.error &&
          data == other.data;

  @override
  int get hashCode => isLoading.hashCode ^ error.hashCode ^ data.hashCode;
}
