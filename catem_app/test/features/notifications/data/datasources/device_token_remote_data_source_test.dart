import 'package:catem_app/features/notifications/data/datasources/device_token_remote_data_source.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../helpers/fake_supabase.dart';

void main() {
  late FakeSupabase fake;
  late SupabaseDeviceTokenRemoteDataSource dataSource;

  setUp(() {
    fake = FakeSupabase();
    dataSource = SupabaseDeviceTokenRemoteDataSource(fake.client);
  });

  tearDown(() => fake.dispose());

  test('upsertToken hace upsert por token con user_id y plataforma', () async {
    fake.on('POST', '/rest/v1/device_tokens', <Map<String, dynamic>>[]);

    await dataSource.upsertToken(
      userId: 'u1',
      token: 'tok-1',
      platform: 'ios',
    );

    final request = fake.requestTo('POST', '/rest/v1/device_tokens');
    expect(request.url.queryParameters['on_conflict'], 'token');
    expect(request.headers['Prefer'], contains('resolution=merge-duplicates'));
    final body = fake.jsonBodyOf(request);
    expect(body, {'user_id': 'u1', 'token': 'tok-1', 'platform': 'ios'});
  });

  test('deleteToken borra por token', () async {
    fake.on('DELETE', '/rest/v1/device_tokens', <Map<String, dynamic>>[]);

    await dataSource.deleteToken('tok-1');

    final request = fake.requestTo('DELETE', '/rest/v1/device_tokens');
    expect(request.url.queryParameters['token'], 'eq.tok-1');
  });
}
