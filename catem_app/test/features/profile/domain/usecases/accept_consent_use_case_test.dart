import 'package:catem_app/core/errors/failures.dart';
import 'package:catem_app/core/utils/result.dart';
import 'package:catem_app/features/profile/domain/entities/profile_entity.dart';
import 'package:catem_app/features/profile/domain/usecases/accept_consent_use_case.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../helpers/mocks.dart';

void main() {
  late MockProfileRepository repository;
  late AcceptConsentUseCase useCase;

  const profile = ProfileEntity(id: 'u1', termsVersion: '1.0');

  setUp(() {
    repository = MockProfileRepository();
    useCase = AcceptConsentUseCase(repository);
  });

  test('rechaza si el checkbox no fue marcado (no pre-marcado)', () async {
    final result = await useCase(userId: 'u1', checkboxAccepted: false);

    expect(result, isA<Failed<ProfileEntity>>());
    expect((result as Failed<ProfileEntity>).failure, isA<ValidationFailure>());
    verifyNever(
      () => repository.acceptConsent(
        userId: any(named: 'userId'),
        termsVersion: any(named: 'termsVersion'),
      ),
    );
  });

  test('registra el consentimiento con la version vigente', () async {
    when(
      () => repository.acceptConsent(userId: 'u1', termsVersion: '1.0'),
    ).thenAnswer((_) async => const Success(profile));

    final result = await useCase(userId: 'u1', checkboxAccepted: true);

    expect(result, const Success<ProfileEntity>(profile));
  });
}
