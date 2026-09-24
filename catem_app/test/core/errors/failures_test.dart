import 'package:catem_app/core/errors/exceptions.dart';
import 'package:catem_app/core/errors/failures.dart';
import 'package:catem_app/core/utils/result.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('los Failures se comparan por tipo y mensaje', () {
    expect(const ServerFailure('x'), const ServerFailure('x'));
    expect(const ServerFailure('x'), isNot(const AuthFailure('x')));
    expect(const NetworkFailure().message, 'Sin conexion');
    expect(const PermissionFailure().message, 'Permiso denegado');
    expect(const ValidationFailure().message, 'Datos invalidos');
    expect(const CacheFailure().message, 'Error de cache local');
  });

  test('Result permite pattern matching exhaustivo', () {
    const results = <Result<int>>[Success(1), Failed(ServerFailure('boom'))];

    final described = results
        .map(
          (r) => switch (r) {
            Success(:final value) => 'ok $value',
            Failed(:final failure) => 'error ${failure.message}',
          },
        )
        .toList();

    expect(described, ['ok 1', 'error boom']);
    expect(const Success<int>(1), const Success<int>(1));
  });

  test('las Exceptions tienen mensaje por defecto y toString legible', () {
    expect(const ServerException().message, 'Error del servidor');
    expect(const CacheException('x').toString(), 'CacheException: x');
  });
}
