import 'package:catem_app/features/profile/data/datasources/profile_remote_data_source.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../helpers/fake_supabase.dart';

void main() {
  late FakeSupabase fake;
  late SupabaseProfileRemoteDataSource dataSource;

  final row = <String, dynamic>{
    'id': 'u1',
    'nick_publico': 'ana',
    'nombre_real': null,
    'fecha_nacimiento': '2000-05-17',
    'ciudad': 'Bogota',
    'consent_accepted_at': '2026-09-24T15:00:00+00:00',
    'terms_version': '1.0',
  };

  setUp(() {
    fake = FakeSupabase();
    dataSource = SupabaseProfileRemoteDataSource(fake.client);
  });

  tearDown(() => fake.dispose());

  test('getById consulta profiles filtrando por id', () async {
    fake.on('GET', '/rest/v1/profiles', row);

    final profile = await dataSource.getById('u1');

    expect(profile?.nickPublico, 'ana');
    expect(profile?.isOnboardingComplete, isTrue);
    final request = fake.requestTo('GET', '/rest/v1/profiles');
    expect(request.url.queryParameters['id'], 'eq.u1');
  });

  test('acceptConsent actualiza fecha y version y devuelve el perfil', () async {
    fake.on('PATCH', '/rest/v1/profiles', row);

    final profile = await dataSource.acceptConsent(
      userId: 'u1',
      termsVersion: '1.0',
    );

    expect(profile.termsVersion, '1.0');
    final request = fake.requestTo('PATCH', '/rest/v1/profiles');
    final body = fake.jsonBodyOf(request);
    expect(body['terms_version'], '1.0');
    expect(body['consent_accepted_at'], isNotNull);
    expect(request.url.queryParameters['id'], 'eq.u1');
  });
}
