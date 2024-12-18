enum HTTPMethodEnum {
  unknown,
  get_,
  post,
  put,
  patch,
  delete,
  head,
  connect,
  options,
  trace;
}

enum NetworkStatusEnum {
  // Custom status to handle unknown status codes
  unknown(message: "Unknown", code: 0),

  // Informational
  continue_(message: "Continue", code: 100),
  switchingProtocols(message: "Switching Protocols", code: 101),
  processing(message: "Processing", code: 102),
  earlyHints(message: "Early Hints", code: 103),

  // Success
  ok(message: "OK", code: 200),
  created(message: "Created", code: 201),
  accepted(message: "Accepted", code: 202),
  nonAuthoritativeInformation(
    message: "Non-Authoritative Information",
    code: 203,
  ),
  noContent(message: "No Content", code: 204),
  resetContent(message: "Reset Content", code: 205),
  partialContent(message: "Partial Content", code: 206),
  multiStatus(message: "Multi-Status", code: 207),
  alreadyReported(message: "Already Reported", code: 208),
  imUsed(message: "IM Used", code: 226),

  // Redirection
  multipleChoices(message: "Multiple Choices", code: 300),
  movedPermanently(message: "Moved Permanently", code: 301),
  found(message: "Found", code: 302),
  seeOther(message: "See Other", code: 303),
  notModified(message: "Not Modified", code: 304),
  useProxy(message: "Use Proxy", code: 305),
  switchProxy(message: "Switch Proxy", code: 306),
  temporaryRedirect(message: "Temporary Redirect", code: 307),
  permanentRedirect(message: "Permanent Redirect", code: 308),

  // Client Error
  badRequest(message: "Bad Request", code: 400),
  unauthorized(message: "Unauthorized", code: 401),
  paymentRequired(message: "Payment Required", code: 402),
  forbidden(message: "Forbidden", code: 403),
  notFound(message: "Not Found", code: 404),
  methodNotAllowed(message: "Method Not Allowed", code: 405),
  notAcceptable(message: "Not Acceptable", code: 406),
  proxyAuthenticationRequired(
    message: "Proxy Authentication Required",
    code: 407,
  ),
  requestTimeout(message: "Request Timeout", code: 408),
  conflict(message: "Conflict", code: 409),
  gone(message: "Gone", code: 410),
  lengthRequired(message: "Length Required", code: 411),
  preconditionFailed(message: "Precondition Failed", code: 412),
  payloadTooLarge(message: "Payload Too Large", code: 413),
  uriTooLong(message: "URI Too Long", code: 414),
  unsupportedMediaType(message: "Unsupported Media Type", code: 415),
  rangeNotSatisfiable(message: "Range Not Satisfiable", code: 416),
  expectationFailed(message: "Expectation Failed", code: 417),
  imATeapot(message: "I'm a teapot", code: 418),
  misdirectedRequest(message: "Misdirected Request", code: 421),
  unprocessableEntity(message: "Unprocessable Entity", code: 422),
  locked(message: "Locked", code: 423),
  failedDependency(message: "Failed Dependency", code: 424),
  tooEarly(message: "Too Early", code: 425),
  upgradeRequired(message: "Upgrade Required", code: 426),
  preconditionRequired(message: "Precondition Required", code: 428),
  tooManyRequests(message: "Too Many Requests", code: 429),
  requestHeaderFieldsTooLarge(
    message: "Request Header Fields Too Large",
    code: 431,
  ),
  unavailableForLegalReasons(
    message: "Unavailable For Legal Reasons",
    code: 451,
  ),

  // Server Error
  internalServerError(message: "Internal Server Error", code: 500),
  notImplemented(message: "Not Implemented", code: 501),
  badGateway(message: "Bad Gateway", code: 502),
  serviceUnavailable(message: "Service Unavailable", code: 503),
  gatewayTimeout(message: "Gateway Timeout", code: 504),
  httpVersionNotSupported(
    message: "HTTP Version Not Supported",
    code: 505,
  ),
  variantAlsoNegotiates(message: "Variant Also Negotiates", code: 506),
  insufficientStorage(message: "Insufficient Storage", code: 507),
  loopDetected(message: "Loop Detected", code: 508),
  notExtended(message: "Not Extended", code: 510),
  networkAuthenticationRequired(
    message: "Network Authentication Required",
    code: 511,
  );

  const NetworkStatusEnum({required this.message, required this.code});

  final String message;
  final int code;

  static NetworkStatusEnum fromCode(int? statusCode) {
    if (statusCode == null) {
      return NetworkStatusEnum.unknown;
    }

    return NetworkStatusEnum.values.firstWhere(
      (networkStatus) => statusCode == networkStatus.code,
      orElse: () => NetworkStatusEnum.unknown,
    );
  }
}
