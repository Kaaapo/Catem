class ServerException implements Exception {
  const ServerException([this.message = 'Error del servidor']);

  final String message;

  @override
  String toString() => 'ServerException: $message';
}

class CacheException implements Exception {
  const CacheException([this.message = 'Error de cache local']);

  final String message;

  @override
  String toString() => 'CacheException: $message';
}
