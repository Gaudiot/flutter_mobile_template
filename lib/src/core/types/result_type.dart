class Result<T, E> {
  final T? data;
  final E? error;

  Result.ok({this.data}) : error = null;
  Result.error({this.error}) : data = null;

  bool get isOk => data != null;
  bool get hasError => error != null;
}
