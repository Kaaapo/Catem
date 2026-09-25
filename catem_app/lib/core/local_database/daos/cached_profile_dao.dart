import 'package:catem_app/core/local_database/app_database.dart';
import 'package:drift/drift.dart';

part 'cached_profile_dao.g.dart';

@DriftAccessor(tables: [CachedProfiles])
class CachedProfileDao extends DatabaseAccessor<AppDatabase>
    with _$CachedProfileDaoMixin {
  CachedProfileDao(super.attachedDatabase);

  Future<CachedProfile?> getById(String id) =>
      (select(cachedProfiles)..where((t) => t.id.equals(id))).getSingleOrNull();

  Stream<CachedProfile?> watchById(String id) =>
      (select(cachedProfiles)..where((t) => t.id.equals(id))).watchSingleOrNull();

  Future<void> upsert(CachedProfilesCompanion entry) =>
      into(cachedProfiles).insertOnConflictUpdate(entry);

  Future<int> deleteById(String id) =>
      (delete(cachedProfiles)..where((t) => t.id.equals(id))).go();
}
