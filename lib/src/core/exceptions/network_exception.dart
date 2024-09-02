import "package:flutter_mobile_template/src/core/enums/network_status_enum.dart";

class NetworkException implements Exception {
  final HTTPMethodEnum method;
  final String url;
  final NetworkStatusEnum statusCode;
  final String? message;
  final String? networkProvider;

  NetworkException({
    required this.method,
    required this.url,
    required this.statusCode,
    this.message = "no message provided",
    this.networkProvider,
  });

  bool get isUnknown => statusCode.code == 0;
  bool get isInformational => statusCode.code >= 100 && statusCode.code < 200;
  bool get isSuccess => statusCode.code >= 200 && statusCode.code < 300;
  bool get isRedirection => statusCode.code >= 300 && statusCode.code < 400;
  bool get isClientError => statusCode.code >= 400 && statusCode.code < 500;
  bool get isServerError => statusCode.code >= 500 && statusCode.code < 600;

  @override
  String toString() => """NetworkException: $message.
Status code and message: ${statusCode.code} / ${statusCode.message}.
URL: [${method.name}] $url.
Network provider: $networkProvider.""";
}
