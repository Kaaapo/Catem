import 'package:catem_app/core/errors/failures.dart';
import 'package:catem_app/core/utils/result.dart';
import 'package:catem_app/features/auth/auth_providers.dart';
import 'package:catem_app/features/auth/domain/entities/user_entity.dart';
import 'package:catem_app/features/auth/presentation/providers/auth_controller.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../helpers/mocks.dart';

void main() {
  late MockAuthRepository repository;
  late ProviderContainer container;

  const user = UserEntity(id: 'u1', email: 'ana@catem.app');

  setUp(() {
    repository = MockAuthRepository();
    container = ProviderContainer(
      overrides: [authRepositoryProvider.overrideWithValue(repository)],
    );
    addTearDown(container.dispose);
  });

  test('emite loading y luego data cuando el login funciona', () async {
    when(
      () => repository.signInWithEmail(email: 'ana@catem.app', password: 'x'),
    ).thenAnswer((_) async => const Success(user));
    final states = <AsyncValue<void>>[];
    container.listen(authControllerProvider, (_, next) => states.add(next));

    final ok = await container
        .read(authControllerProvider.notifier)
        .signInWithEmail(email: 'ana@catem.app', password: 'x');

    expect(ok, isTrue);
    expect(states.first, isA<AsyncLoading<void>>());
    expect(states.last, isA<AsyncData<void>>());
  });

  test('expone el Failure como AsyncError cuando falla', () async {
    when(
      () => repository.signInWithEmail(email: 'ana@catem.app', password: 'x'),
    ).thenAnswer((_) async => const Failed(AuthFailure('credenciales')));

    final ok = await container
        .read(authControllerProvider.notifier)
        .signInWithEmail(email: 'ana@catem.app', password: 'x');

    expect(ok, isFalse);
    final state = container.read(authControllerProvider);
    expect(state, isA<AsyncError<void>>());
    expect(state.error, const AuthFailure('credenciales'));
  });

  test('signOut delega al usecase y termina en data', () async {
    when(() => repository.signOut()).thenAnswer((_) async => const Success(null));

    final ok = await container.read(authControllerProvider.notifier).signOut();

    expect(ok, isTrue);
    expect(container.read(authControllerProvider), isA<AsyncData<void>>());
  });
}
