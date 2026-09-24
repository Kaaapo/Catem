import 'package:catem_app/core/errors/exceptions.dart';
import 'package:catem_app/core/errors/failures.dart';
import 'package:catem_app/core/utils/result.dart';
import 'package:catem_app/features/auth/data/models/user_model.dart';
import 'package:catem_app/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:catem_app/features/auth/domain/entities/user_entity.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../helpers/mocks.dart';

void main() {
  late MockAuthRemoteDataSource remote;
  late AuthRepositoryImpl repository;

  const model = UserModel(id: 'user-1', email: 'ana@catem.app');

  setUp(() {
    remote = MockAuthRemoteDataSource();
    repository = AuthRepositoryImpl(remote);
  });

  group('signInWithEmail', () {
    test('devuelve Success cuando el datasource responde', () async {
      when(
        () => remote.signInWithEmail(
          email: any(named: 'email'),
          password: any(named: 'password'),
        ),
      ).thenAnswer((_) async => model);

      final result = await repository.signInWithEmail(
        email: 'ana@catem.app',
        password: 'secreto123',
      );

      expect(result, const Success<UserEntity>(model));
    });

    test('mapea AuthException de Supabase a AuthFailure', () async {
      when(
        () => remote.signInWithEmail(
          email: any(named: 'email'),
          password: any(named: 'password'),
        ),
      ).thenThrow(const AuthException('Invalid login credentials'));

      final result = await repository.signInWithEmail(
        email: 'ana@catem.app',
        password: 'mala',
      );

      expect(
        result,
        const Failed<UserEntity>(AuthFailure('Invalid login credentials')),
      );
    });

    test('mapea ServerException a ServerFailure', () async {
      when(
        () => remote.signInWithEmail(
          email: any(named: 'email'),
          password: any(named: 'password'),
        ),
      ).thenThrow(const ServerException('sin usuario'));

      final result = await repository.signInWithEmail(
        email: 'ana@catem.app',
        password: 'secreto123',
      );

      expect(result, const Failed<UserEntity>(ServerFailure('sin usuario')));
    });
  });

  test('signOut devuelve Success cuando el datasource no falla', () async {
    when(() => remote.signOut()).thenAnswer((_) async {});

    final result = await repository.signOut();

    expect(result, isA<Success<void>>());
  });
}
