import 'package:catem_app/core/errors/failures.dart';
import 'package:catem_app/core/utils/result.dart';
import 'package:catem_app/features/auth/domain/entities/user_entity.dart';
import 'package:catem_app/features/auth/domain/usecases/request_phone_otp_use_case.dart';
import 'package:catem_app/features/auth/domain/usecases/resend_email_confirmation_use_case.dart';
import 'package:catem_app/features/auth/domain/usecases/send_password_reset_use_case.dart';
import 'package:catem_app/features/auth/domain/usecases/sign_in_use_case.dart';
import 'package:catem_app/features/auth/domain/usecases/sign_in_with_apple_use_case.dart';
import 'package:catem_app/features/auth/domain/usecases/sign_in_with_google_use_case.dart';
import 'package:catem_app/features/auth/domain/usecases/sign_out_use_case.dart';
import 'package:catem_app/features/auth/domain/usecases/update_password_use_case.dart';
import 'package:catem_app/features/auth/domain/usecases/validate_minimum_age_use_case.dart';
import 'package:catem_app/features/auth/domain/usecases/verify_phone_otp_use_case.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../helpers/mocks.dart';

void main() {
  late MockAuthRepository repository;

  const user = UserEntity(id: 'u1', email: 'ana@catem.app');

  setUp(() => repository = MockAuthRepository());

  test('SignInUseCase delega al repositorio', () async {
    when(
      () => repository.signInWithEmail(email: 'ana@catem.app', password: 'x'),
    ).thenAnswer((_) async => const Success(user));

    final result = await SignInUseCase(repository)(
      email: 'ana@catem.app',
      password: 'x',
    );

    expect(result, const Success<UserEntity>(user));
  });

  test('SignOutUseCase delega al repositorio', () async {
    when(() => repository.signOut()).thenAnswer((_) async => const Success(null));

    expect(await SignOutUseCase(repository)(), isA<Success<void>>());
  });

  test('SignInWithGoogle/Apple delegan al repositorio', () async {
    when(() => repository.signInWithGoogle())
        .thenAnswer((_) async => const Success(user));
    when(() => repository.signInWithApple())
        .thenAnswer((_) async => const Success(user));

    expect(await SignInWithGoogleUseCase(repository)(), const Success<UserEntity>(user));
    expect(await SignInWithAppleUseCase(repository)(), const Success<UserEntity>(user));
  });

  group('RequestPhoneOtpUseCase', () {
    test('rechaza telefonos que no estan en formato E.164', () async {
      final result = await RequestPhoneOtpUseCase(repository)(phone: '3001234567');

      expect(result, isA<Failed<void>>());
      expect((result as Failed<void>).failure, isA<ValidationFailure>());
      verifyNever(() => repository.requestPhoneOtp(phone: any(named: 'phone')));
    });

    test('envia el OTP con un telefono valido', () async {
      when(() => repository.requestPhoneOtp(phone: '+573001234567'))
          .thenAnswer((_) async => const Success(null));

      final result = await RequestPhoneOtpUseCase(repository)(phone: '+573001234567');

      expect(result, isA<Success<void>>());
    });
  });

  group('VerifyPhoneOtpUseCase', () {
    test('rechaza codigos que no son de 6 digitos', () async {
      final result = await VerifyPhoneOtpUseCase(repository)(
        phone: '+573001234567',
        code: '12ab',
      );

      expect((result as Failed<UserEntity>).failure, isA<ValidationFailure>());
    });

    test('verifica un codigo valido', () async {
      when(
        () => repository.verifyPhoneOtp(phone: '+573001234567', code: '123456'),
      ).thenAnswer((_) async => const Success(user));

      final result = await VerifyPhoneOtpUseCase(repository)(
        phone: '+573001234567',
        code: '123456',
      );

      expect(result, const Success<UserEntity>(user));
    });
  });

  group('UpdatePasswordUseCase', () {
    test('rechaza contrasenas cortas', () async {
      final result = await UpdatePasswordUseCase(repository)(newPassword: '1234567');

      expect((result as Failed<UserEntity>).failure, isA<ValidationFailure>());
    });

    test('actualiza una contrasena valida', () async {
      when(() => repository.updatePassword(newPassword: 'nueva12345'))
          .thenAnswer((_) async => const Success(user));

      final result = await UpdatePasswordUseCase(repository)(newPassword: 'nueva12345');

      expect(result, const Success<UserEntity>(user));
    });
  });

  test('SendPasswordReset y ResendEmailConfirmation limpian espacios', () async {
    when(() => repository.sendPasswordReset(email: 'ana@catem.app'))
        .thenAnswer((_) async => const Success(null));
    when(() => repository.resendEmailConfirmation(email: 'ana@catem.app'))
        .thenAnswer((_) async => const Success(null));

    await SendPasswordResetUseCase(repository)(email: ' ana@catem.app ');
    await ResendEmailConfirmationUseCase(repository)(email: ' ana@catem.app ');

    verify(() => repository.sendPasswordReset(email: 'ana@catem.app')).called(1);
    verify(() => repository.resendEmailConfirmation(email: 'ana@catem.app')).called(1);
  });

  group('ValidateMinimumAgeUseCase (18+)', () {
    final today = DateTime(2026, 9, 24);
    final useCase = ValidateMinimumAgeUseCase(now: () => today);

    test('acepta a quien cumple 18 hoy', () {
      expect(useCase(birthDate: DateTime(2008, 9, 24)), isA<Success<void>>());
    });

    test('rechaza a quien cumple 18 manana', () {
      final result = useCase(birthDate: DateTime(2008, 9, 25));

      expect(result, isA<Failed<void>>());
      expect((result as Failed<void>).failure, isA<ValidationFailure>());
    });

    test('rechaza fechas futuras', () {
      expect(useCase(birthDate: DateTime(2030)), isA<Failed<void>>());
    });
  });
}
