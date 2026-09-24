import 'package:catem_app/core/errors/exceptions.dart';
import 'package:catem_app/core/errors/failures.dart';
import 'package:catem_app/core/utils/result.dart';
import 'package:catem_app/features/auth/data/datasources/apple_auth_data_source.dart';
import 'package:catem_app/features/auth/data/models/user_model.dart';
import 'package:catem_app/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:catem_app/features/auth/domain/entities/user_entity.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:mocktail/mocktail.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../helpers/mocks.dart';

void main() {
  late MockAuthRemoteDataSource remote;
  late MockGoogleAuthDataSource google;
  late MockAppleAuthDataSource apple;
  late AuthRepositoryImpl repository;
  var cacheCleared = 0;

  const model = UserModel(id: 'user-1', email: 'ana@catem.app');

  setUpAll(() => registerFallbackValue(OAuthProvider.google));

  setUp(() {
    remote = MockAuthRemoteDataSource();
    google = MockGoogleAuthDataSource();
    apple = MockAppleAuthDataSource();
    cacheCleared = 0;
    repository = AuthRepositoryImpl(remote, google, apple, () async {
      cacheCleared++;
    });
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

  group('signInWithGoogle', () {
    test('intercambia el idToken de Google en Supabase', () async {
      when(() => google.signIn()).thenAnswer((_) async => 'google-token');
      when(
        () => remote.signInWithIdToken(
          provider: OAuthProvider.google,
          idToken: 'google-token',
        ),
      ).thenAnswer((_) async => model);

      final result = await repository.signInWithGoogle();

      expect(result, const Success<UserEntity>(model));
    });

    test('devuelve AuthFailure si el usuario cancela', () async {
      when(() => google.signIn()).thenThrow(
        const GoogleSignInException(code: GoogleSignInExceptionCode.canceled),
      );

      final result = await repository.signInWithGoogle();

      expect(result, isA<Failed<UserEntity>>());
      expect((result as Failed<UserEntity>).failure, isA<AuthFailure>());
    });
  });

  group('signInWithApple', () {
    test('usa el nonce crudo de Supabase y el identityToken de Apple', () async {
      when(() => remote.generateRawNonce()).thenReturn('nonce-1');
      when(() => apple.signIn(rawNonce: 'nonce-1')).thenAnswer(
        (_) async => const AppleCredential(
          identityToken: 'apple-token',
          rawNonce: 'nonce-1',
        ),
      );
      when(
        () => remote.signInWithIdToken(
          provider: OAuthProvider.apple,
          idToken: 'apple-token',
          nonce: 'nonce-1',
        ),
      ).thenAnswer((_) async => model);

      final result = await repository.signInWithApple();

      expect(result, const Success<UserEntity>(model));
    });
  });

  group('phone OTP', () {
    test('requestPhoneOtp delega al datasource', () async {
      when(() => remote.requestPhoneOtp(phone: '+573001234567'))
          .thenAnswer((_) async {});

      final result = await repository.requestPhoneOtp(phone: '+573001234567');

      expect(result, isA<Success<void>>());
    });

    test('verifyPhoneOtp devuelve el usuario verificado', () async {
      when(
        () => remote.verifyPhoneOtp(phone: '+573001234567', code: '123456'),
      ).thenAnswer((_) async => model);

      final result = await repository.verifyPhoneOtp(
        phone: '+573001234567',
        code: '123456',
      );

      expect(result, const Success<UserEntity>(model));
    });
  });

  group('password', () {
    test('sendPasswordReset delega al datasource', () async {
      when(() => remote.sendPasswordReset(email: 'ana@catem.app'))
          .thenAnswer((_) async {});

      expect(
        await repository.sendPasswordReset(email: 'ana@catem.app'),
        isA<Success<void>>(),
      );
    });

    test('updatePassword devuelve el usuario actualizado', () async {
      when(() => remote.updatePassword(newPassword: 'nueva12345'))
          .thenAnswer((_) async => model);

      expect(
        await repository.updatePassword(newPassword: 'nueva12345'),
        const Success<UserEntity>(model),
      );
    });
  });

  test('signOut cierra Supabase y Google y limpia la cache local', () async {
    when(() => remote.signOut()).thenAnswer((_) async {});
    when(() => google.signOut()).thenAnswer((_) async {});

    final result = await repository.signOut();

    expect(result, isA<Success<void>>());
    verify(() => google.signOut()).called(1);
    expect(cacheCleared, 1);
  });

  test('refreshCurrentUser devuelve null sin sesion', () async {
    when(() => remote.refreshCurrentUser()).thenAnswer((_) async => null);

    expect(await repository.refreshCurrentUser(), const Success<UserEntity?>(null));
  });
}
