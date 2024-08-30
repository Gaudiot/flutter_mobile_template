import "package:flutter_mobile_template/src/core/enums/network_status_enum.dart";

class NetworkException implements Exception {
  final String? message;
  final NetworkStatusEnum statusCode;

  NetworkException({
    required this.statusCode,
    this.message = "no message provided",
  });

  bool get isUnknown => statusCode.code == 0;
  bool get isInformational => statusCode.code >= 100 && statusCode.code < 200;
  bool get isSuccess => statusCode.code >= 200 && statusCode.code < 300;
  bool get isRedirection => statusCode.code >= 300 && statusCode.code < 400;
  bool get isClientError => statusCode.code >= 400 && statusCode.code < 500;
  bool get isServerError => statusCode.code >= 500 && statusCode.code < 600;

  @override
  String toString() {
    return "NetworkException: $message. Status code: $statusCode}";
  }
}
