class LocalStorageException implements Exception {
  final String message;
  final String? localStorageProvider;

  LocalStorageException({
    this.message = "no message provided",
    this.localStorageProvider,
  });

  @override
  String toString() => """LocalStorageException: $message.
Local storage provider: $localStorageProvider.""";
}
