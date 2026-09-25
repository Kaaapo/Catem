import 'package:catem_app/features/profile/data/models/profile_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract interface class ProfileRemoteDataSource {
  Future<ProfileModel?> getById(String userId);

  Future<ProfileModel> acceptConsent({
    required String userId,
    required String termsVersion,
  });
}

class SupabaseProfileRemoteDataSource implements ProfileRemoteDataSource {
  const SupabaseProfileRemoteDataSource(this._client);

  static const _table = 'profiles';

  final SupabaseClient _client;

  @override
  Future<ProfileModel?> getById(String userId) async {
    final row = await _client.from(_table).select().eq('id', userId).maybeSingle();
    return row == null ? null : ProfileModel.fromJson(row);
  }

  @override
  Future<ProfileModel> acceptConsent({
    required String userId,
    required String termsVersion,
  }) async {
    final row = await _client
        .from(_table)
        .update({
          'consent_accepted_at': DateTime.now().toUtc().toIso8601String(),
          'terms_version': termsVersion,
        })
        .eq('id', userId)
        .select()
        .single();
    return ProfileModel.fromJson(row);
  }
}
