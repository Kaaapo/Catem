import 'package:catem_app/core/utils/result.dart';
import 'package:catem_app/features/profile/domain/entities/profile_entity.dart';

abstract interface class ProfileRepository {
  /// Cache-first: devuelve la copia local si existe y sincroniza en background.
  Future<Result<ProfileEntity?>> getProfile(
    String userId, {
    bool forceRefresh = false,
  });

  Stream<ProfileEntity?> watchProfile(String userId);

  Future<Result<ProfileEntity>> acceptConsent({
    required String userId,
    required String termsVersion,
  });

  Future<void> clearCache();
}
