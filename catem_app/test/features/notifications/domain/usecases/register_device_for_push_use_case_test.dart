import 'package:catem_app/core/errors/failures.dart';
import 'package:catem_app/core/utils/result.dart';
import 'package:catem_app/features/notifications/domain/usecases/register_device_for_push_use_case.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../helpers/mocks.dart';

void main() {
  late MockPushNotificationsRepository repository;
  late RegisterDeviceForPushUseCase useCase;

  setUp(() {
    repository = MockPushNotificationsRepository();
    useCase = RegisterDeviceForPushUseCase(repository);
  });

  test('registra el dispositivo cuando hay permiso', () async {
    when(() => repository.requestPermission())
        .thenAnswer((_) async => const Success(true));
    when(() => repository.registerCurrentDevice(userId: 'u1'))
        .thenAnswer((_) async => const Success(null));

    final result = await useCase(userId: 'u1');

    expect(result, isA<Success<void>>());
    verify(() => repository.registerCurrentDevice(userId: 'u1')).called(1);
  });

  test('devuelve PermissionFailure si el usuario niega el permiso', () async {
    when(() => repository.requestPermission())
        .thenAnswer((_) async => const Success(false));

    final result = await useCase(userId: 'u1');

    expect(result, isA<Failed<void>>());
    expect((result as Failed<void>).failure, isA<PermissionFailure>());
    verifyNever(() => repository.registerCurrentDevice(userId: any(named: 'userId')));
  });

  test('propaga el Failure de requestPermission', () async {
    when(() => repository.requestPermission())
        .thenAnswer((_) async => const Failed(ServerFailure('x')));

    final result = await useCase(userId: 'u1');

    expect(result, const Failed<void>(ServerFailure('x')));
  });
}
