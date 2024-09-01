import "package:flutter_mobile_template/src/core/exceptions/exceptions.dart";
import "package:flutter_mobile_template/src/core/types/result_type.dart";

abstract class INetwork {
  void init({
    required String baseUrl,
  });

  Future<Result<T, NetworkException>> get<T>({
    required String path,
    Map<String, String>? queryParameters = const {},
  });

  Future<Result<S, NetworkException>> post<T, S>({
    required String path,
    required T body,
  });

  Future<Result<S, NetworkException>> put<T, S>({
    required String path,
    required T body,
  });

  Future<Result<T, NetworkException>> delete<T>({
    required String path,
  });
}
