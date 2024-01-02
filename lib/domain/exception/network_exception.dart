class NetworkException implements Exception {
  final int statusCode;
  final String? message;

  NetworkException({required this.statusCode, required this.message});

  @override
  String toString() =>
      "Network Exception: status code: $statusCode, message: $message";
}
