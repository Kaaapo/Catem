import 'package:supabase_flutter/supabase_flutter.dart';

abstract interface class DeviceTokenRemoteDataSource {
  Future<void> upsertToken({
    required String userId,
    required String token,
    required String platform,
  });

  Future<void> deleteToken(String token);
}

class SupabaseDeviceTokenRemoteDataSource implements DeviceTokenRemoteDataSource {
  const SupabaseDeviceTokenRemoteDataSource(this._client);

  static const _table = 'device_tokens';

  final SupabaseClient _client;

  @override
  Future<void> upsertToken({
    required String userId,
    required String token,
    required String platform,
  }) {
    return _client.from(_table).upsert(
      {'user_id': userId, 'token': token, 'platform': platform},
      onConflict: 'token',
    );
  }

  @override
  Future<void> deleteToken(String token) =>
      _client.from(_table).delete().eq('token', token);
}
