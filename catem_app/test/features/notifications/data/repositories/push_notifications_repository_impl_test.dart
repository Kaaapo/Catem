import 'package:catem_app/core/errors/failures.dart';
import 'package:catem_app/core/utils/result.dart';
import 'package:catem_app/features/notifications/data/repositories/push_notifications_repository_impl.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../helpers/mocks.dart';

void main() {
  late MockFcmRemoteDataSource fcm;
  late MockDeviceTokenRemoteDataSource tokens;
  late PushNotificationsRepositoryImpl repository;

  setUp(() {
    fcm = MockFcmRemoteDataSource();
    tokens = MockDeviceTokenRemoteDataSource();
    repository = PushNotificationsRepositoryImpl(fcm, tokens, 'android');
  });

  group('requestPermission', () {
    test('devuelve Success(true) cuando el usuario autoriza', () async {
      when(() => fcm.requestPermission()).thenAnswer((_) async => true);

      expect(await repository.requestPermission(), const Success(true));
    });

    test('mapea excepciones a ServerFailure', () async {
      when(() => fcm.requestPermission()).thenThrow(Exception('boom'));

      expect(await repository.requestPermission(), isA<Failed<bool>>());
    });
  });

  group('registerCurrentDevice', () {
    test('sube el token con user_id y plataforma', () async {
      when(() => fcm.getToken()).thenAnswer((_) async => 'tok-123');
      when(
        () => tokens.upsertToken(
          userId: any(named: 'userId'),
          token: any(named: 'token'),
          platform: any(named: 'platform'),
        ),
      ).thenAnswer((_) async {});

      final result = await repository.registerCurrentDevice(userId: 'u1');

      expect(result, isA<Success<void>>());
      verify(
        () => tokens.upsertToken(
          userId: 'u1',
          token: 'tok-123',
          platform: 'android',
        ),
      ).called(1);
    });

    test('falla si FCM no entrega token', () async {
      when(() => fcm.getToken()).thenAnswer((_) async => null);

      final result = await repository.registerCurrentDevice(userId: 'u1');

      expect(result, const Failed<void>(ServerFailure('FCM no entrego token')));
      verifyNever(
        () => tokens.upsertToken(
          userId: any(named: 'userId'),
          token: any(named: 'token'),
          platform: any(named: 'platform'),
        ),
      );
    });
  });
}
