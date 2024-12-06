class Result<T, E> {
  final T? data;
  final E? error;

  Result.ok({this.data}) : error = null;
  Result.error({this.error}) : data = null;

  bool get isOk => error == null;
  bool get hasError => error != null;

  bool get hasData => data != null;
}
