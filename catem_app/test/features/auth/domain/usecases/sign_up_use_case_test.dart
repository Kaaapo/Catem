import 'package:catem_app/core/errors/failures.dart';
import 'package:catem_app/core/utils/result.dart';
import 'package:catem_app/features/auth/domain/entities/user_entity.dart';
import 'package:catem_app/features/auth/domain/usecases/sign_up_use_case.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../helpers/mocks.dart';

void main() {
  late MockAuthRepository repository;
  late SignUpUseCase useCase;

  const user = UserEntity(id: 'user-1', email: 'ana@catem.app');

  setUp(() {
    repository = MockAuthRepository();
    useCase = SignUpUseCase(repository);
  });

  test('retorna Success con el usuario cuando el repositorio responde', () async {
    when(
      () => repository.signUpWithEmail(
        email: any(named: 'email'),
        password: any(named: 'password'),
      ),
    ).thenAnswer((_) async => const Success(user));

    final result = await useCase(email: 'ana@catem.app', password: 'secreto123');

    expect(result, const Success<UserEntity>(user));
    verify(
      () => repository.signUpWithEmail(
        email: 'ana@catem.app',
        password: 'secreto123',
      ),
    ).called(1);
  });

  test('propaga el Failure del repositorio', () async {
    when(
      () => repository.signUpWithEmail(
        email: any(named: 'email'),
        password: any(named: 'password'),
      ),
    ).thenAnswer((_) async => const Failed(AuthFailure('Email ya registrado')));

    final result = await useCase(email: 'ana@catem.app', password: 'secreto123');

    expect(result, const Failed<UserEntity>(AuthFailure('Email ya registrado')));
  });
}
