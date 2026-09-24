import 'package:catem_app/core/local_database/daos/cached_profile_dao.dart';
import 'package:catem_app/features/profile/data/models/profile_model.dart';

abstract interface class ProfileLocalDataSource {
  Future<ProfileModel?> getById(String userId);

  Stream<ProfileModel?> watchById(String userId);

  Future<void> upsert(ProfileModel profile);

  Future<void> clear();
}

class DriftProfileLocalDataSource implements ProfileLocalDataSource {
  const DriftProfileLocalDataSource(this._dao);

  final CachedProfileDao _dao;

  @override
  Future<ProfileModel?> getById(String userId) async {
    final row = await _dao.getById(userId);
    return row == null ? null : ProfileModel.fromCache(row);
  }

  @override
  Stream<ProfileModel?> watchById(String userId) => _dao
      .watchById(userId)
      .map((row) => row == null ? null : ProfileModel.fromCache(row));

  @override
  Future<void> upsert(ProfileModel profile) => _dao.upsert(profile.toCache());

  @override
  Future<void> clear() => _dao.attachedDatabase.clearAll();
}
