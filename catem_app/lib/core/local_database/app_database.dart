import 'package:catem_app/core/local_database/daos/cached_profile_dao.dart';
import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';

part 'app_database.g.dart';

class CachedProfiles extends Table {
  TextColumn get id => text()();
  TextColumn get nickPublico => text().nullable()();
  TextColumn get nombreReal => text().nullable()();
  DateTimeColumn get fechaNacimiento => dateTime().nullable()();
  TextColumn get ciudad => text().nullable()();
  DateTimeColumn get consentAcceptedAt => dateTime().nullable()();
  TextColumn get termsVersion => text().nullable()();
  DateTimeColumn get syncedAt => dateTime()();

  @override
  Set<Column<Object>> get primaryKey => {id};
}

// Ciclo 3: se completan con la pregunta diaria y el mood tracker.
class CachedDailyAnswers extends Table {
  TextColumn get id => text()();
  TextColumn get userId => text()();
  TextColumn get questionId => text()();
  TextColumn get answer => text()();
  DateTimeColumn get answeredAt => dateTime()();
  DateTimeColumn get syncedAt => dateTime()();

  @override
  Set<Column<Object>> get primaryKey => {id};
}

class CachedMoodEntries extends Table {
  TextColumn get id => text()();
  TextColumn get userId => text()();
  IntColumn get mood => integer()();
  TextColumn get note => text().nullable()();
  DateTimeColumn get recordedAt => dateTime()();
  DateTimeColumn get syncedAt => dateTime()();

  @override
  Set<Column<Object>> get primaryKey => {id};
}

@DriftDatabase(
  tables: [CachedProfiles, CachedDailyAnswers, CachedMoodEntries],
  daos: [CachedProfileDao],
)
class AppDatabase extends _$AppDatabase {
  AppDatabase([QueryExecutor? executor]) : super(executor ?? _openConnection());

  @override
  int get schemaVersion => 1;

  static QueryExecutor _openConnection() => driftDatabase(name: 'catem_cache');

  /// Borra toda la cache local (se usa al cerrar sesion).
  Future<void> clearAll() => transaction(() async {
    for (final table in allTables) {
      await delete(table).go();
    }
  });
}
