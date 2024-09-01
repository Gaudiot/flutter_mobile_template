import "package:dio/dio.dart";
import "package:flutter_mobile_template/src/base/network/inetwork.dart";
import "package:flutter_mobile_template/src/core/enums/network_status_enum.dart";
import "package:flutter_mobile_template/src/core/exceptions/network_exception.dart";
import "package:flutter_mobile_template/src/core/types/json_mapper.dart";
import "package:flutter_mobile_template/src/core/types/result_type.dart";

class DioNetworkException extends NetworkException {
  DioNetworkException({
    required super.method,
    required super.url,
    required super.statusCode,
    super.message,
  }) : super(
          networkProvider: "Dio",
        );
}

class DioNetwork implements INetwork {
  late final Dio _dio;

  @override
  void init({required String baseUrl}) {
    _dio = Dio(
      BaseOptions(
        baseUrl: baseUrl,
        connectTimeout: const Duration(seconds: 5),
        receiveTimeout: const Duration(seconds: 3),
      ),
    );
  }

  Future<Result<T, NetworkException>> _handleDioRequest<T>({
    required HTTPMethodEnum method,
    required String path,
    required Future<Response<Map<String, dynamic>>> Function() requestFunction,
  }) async {
    final fullPath = _dio.options.baseUrl + path;
    try {
      final response = await requestFunction();

      final mapper = MapperRegistry.get<T>();
      if (mapper == null) {
        throw Exception("Mapper for type $T not found");
      }

      final data = mapper.fromJson(response.data!);
      return Result.ok(data: data);
    } on DioException catch (dioError) {
      return Result.error(
        error: DioNetworkException(
          method: method,
          url: fullPath,
          statusCode: NetworkStatusEnum.fromCode(dioError.response?.statusCode),
          message: dioError.message,
        ),
      );
    } catch (error) {
      return Result.error(
        error: DioNetworkException(
          method: method,
          url: fullPath,
          statusCode: NetworkStatusEnum.unknown,
          message: error.toString(),
        ),
      );
    }
  }

  @override
  Future<Result<T, NetworkException>> get<T>({
    required String path,
    Map<String, String>? queryParameters = const {},
  }) async {
    return _handleDioRequest<T>(
      method: HTTPMethodEnum.get_,
      path: path,
      requestFunction: () async {
        return _dio.get<Map<String, dynamic>>(
          path,
          queryParameters: queryParameters,
        );
      },
    );
  }

  @override
  Future<Result<S, NetworkException>> post<T, S>({
    required String path,
    required T body,
  }) async {
    final mapper = MapperRegistry.get<T>();

    if (mapper == null) {
      return Result.error(
        error: DioNetworkException(
          method: HTTPMethodEnum.post,
          url: _dio.options.baseUrl + path,
          statusCode: NetworkStatusEnum.unknown,
          message: "Mapper for type $T not found",
        ),
      );
    }

    final data = mapper.toJson(body);

    return _handleDioRequest<S>(
      method: HTTPMethodEnum.post,
      path: path,
      requestFunction: () async {
        return _dio.post(
          path,
          data: data,
        );
      },
    );
  }

  @override
  Future<Result<T, NetworkException>> delete<T>({
    required String path,
  }) async {
    return _handleDioRequest<T>(
      method: HTTPMethodEnum.delete,
      path: path,
      requestFunction: () async {
        return _dio.delete(
          path,
        );
      },
    );
  }

  @override
  Future<Result<S, NetworkException>> put<T, S>({
    required String path,
    required T body,
  }) async {
    final mapper = MapperRegistry.get<T>();

    if (mapper == null) {
      return Result.error(
        error: DioNetworkException(
          method: HTTPMethodEnum.put,
          url: _dio.options.baseUrl + path,
          statusCode: NetworkStatusEnum.unknown,
          message: "Mapper for type $T not found",
        ),
      );
    }

    final data = mapper.toJson(body);

    return _handleDioRequest<S>(
      method: HTTPMethodEnum.put,
      path: path,
      requestFunction: () async {
        return _dio.put(
          path,
          data: data,
        );
      },
    );
  }
}
