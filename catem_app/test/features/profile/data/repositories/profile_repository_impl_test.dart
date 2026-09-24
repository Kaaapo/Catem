import 'package:catem_app/core/errors/failures.dart';
import 'package:catem_app/core/utils/result.dart';
import 'package:catem_app/features/profile/data/models/profile_model.dart';
import 'package:catem_app/features/profile/data/repositories/profile_repository_impl.dart';
import 'package:catem_app/features/profile/domain/entities/profile_entity.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../helpers/mocks.dart';

void main() {
  late MockProfileRemoteDataSource remote;
  late MockProfileLocalDataSource local;
  late MockNetworkInfo network;
  late ProfileRepositoryImpl repository;

  const cached = ProfileModel(id: 'u1', nickPublico: 'local');
  const fresh = ProfileModel(id: 'u1', nickPublico: 'remoto');

  setUpAll(() => registerFallbackValue(cached));

  setUp(() {
    remote = MockProfileRemoteDataSource();
    local = MockProfileLocalDataSource();
    network = MockNetworkInfo();
    repository = ProfileRepositoryImpl(remote, local, network);
    when(() => local.upsert(any())).thenAnswer((_) async {});
  });

  group('getProfile', () {
    test('devuelve la cache de inmediato y sincroniza en background', () async {
      when(() => local.getById('u1')).thenAnswer((_) async => cached);
      when(() => network.isConnected).thenAnswer((_) async => true);
      when(() => remote.getById('u1')).thenAnswer((_) async => fresh);

      final result = await repository.getProfile('u1');

      expect(result, const Success<ProfileEntity?>(cached));
      await untilCalled(() => local.upsert(fresh));
      verify(() => local.upsert(fresh)).called(1);
    });

    test('sin cache y sin red devuelve NetworkFailure', () async {
      when(() => local.getById('u1')).thenAnswer((_) async => null);
      when(() => network.isConnected).thenAnswer((_) async => false);

      final result = await repository.getProfile('u1');

      expect(result, const Failed<ProfileEntity?>(NetworkFailure()));
      verifyNever(() => remote.getById(any()));
    });

    test('sin cache y con red trae de Supabase y guarda en cache', () async {
      when(() => local.getById('u1')).thenAnswer((_) async => null);
      when(() => network.isConnected).thenAnswer((_) async => true);
      when(() => remote.getById('u1')).thenAnswer((_) async => fresh);

      final result = await repository.getProfile('u1');

      expect(result, const Success<ProfileEntity?>(fresh));
      verify(() => local.upsert(fresh)).called(1);
    });

    test('forceRefresh ignora la cache', () async {
      when(() => network.isConnected).thenAnswer((_) async => true);
      when(() => remote.getById('u1')).thenAnswer((_) async => fresh);

      final result = await repository.getProfile('u1', forceRefresh: true);

      expect(result, const Success<ProfileEntity?>(fresh));
      verifyNever(() => local.getById(any()));
    });
  });

  group('acceptConsent', () {
    test('registra el consentimiento y actualiza la cache', () async {
      when(() => network.isConnected).thenAnswer((_) async => true);
      when(
        () => remote.acceptConsent(userId: 'u1', termsVersion: '1.0'),
      ).thenAnswer((_) async => fresh);

      final result = await repository.acceptConsent(
        userId: 'u1',
        termsVersion: '1.0',
      );

      expect(result, const Success<ProfileEntity>(fresh));
      verify(() => local.upsert(fresh)).called(1);
    });

    test('sin red devuelve NetworkFailure', () async {
      when(() => network.isConnected).thenAnswer((_) async => false);

      final result = await repository.acceptConsent(
        userId: 'u1',
        termsVersion: '1.0',
      );

      expect(result, const Failed<ProfileEntity>(NetworkFailure()));
    });
  });
}
