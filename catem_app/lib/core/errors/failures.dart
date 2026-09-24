import 'package:equatable/equatable.dart';

sealed class Failure extends Equatable {
  const Failure(this.message);

  final String message;

  @override
  List<Object?> get props => [message];
}

final class ServerFailure extends Failure {
  const ServerFailure([super.message = 'Error del servidor']);
}

final class AuthFailure extends Failure {
  const AuthFailure([super.message = 'Error de autenticacion']);
}

final class NetworkFailure extends Failure {
  const NetworkFailure([super.message = 'Sin conexion']);
}

final class CacheFailure extends Failure {
  const CacheFailure([super.message = 'Error de cache local']);
}
