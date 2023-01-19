// in - refers to inputs
// out - refers to return type
class Result<T> {
  final T? data;
  final String? error;
  final bool success;

  Result({
    this.data,
    this.error,
  }) : success = error ==
            null; // success = error == null is initialized based on values passed to constructor
}

abstract class BaseUseCase<In, Out> {
  Future<Out> execute(In input);
}
