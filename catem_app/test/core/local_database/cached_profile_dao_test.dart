import 'package:catem_app/core/local_database/app_database.dart';
import 'package:drift/drift.dart' show Value;
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late AppDatabase db;

  setUp(() => db = AppDatabase(NativeDatabase.memory()));
  tearDown(() => db.close());

  CachedProfilesCompanion profile(String id, {String? nick}) =>
      CachedProfilesCompanion(
        id: Value(id),
        nickPublico: Value(nick),
        syncedAt: Value(DateTime(2026, 9, 24)),
      );

  test('escribe y lee un perfil en cache', () async {
    await db.cachedProfileDao.upsert(profile('u1', nick: 'ana'));

    final row = await db.cachedProfileDao.getById('u1');

    expect(row?.id, 'u1');
    expect(row?.nickPublico, 'ana');
  });

  test('upsert actualiza la fila existente en vez de duplicarla', () async {
    await db.cachedProfileDao.upsert(profile('u1', nick: 'ana'));
    await db.cachedProfileDao.upsert(profile('u1', nick: 'ana2'));

    final rows = await db.select(db.cachedProfiles).get();

    expect(rows, hasLength(1));
    expect(rows.single.nickPublico, 'ana2');
  });

  test('watchById emite los cambios', () async {
    final stream = db.cachedProfileDao.watchById('u1');
    final emitsRow = expectLater(stream, emitsThrough(isA<CachedProfile>()));

    await db.cachedProfileDao.upsert(profile('u1'));

    await emitsRow;
  });

  test('clearAll vacia todas las tablas', () async {
    await db.cachedProfileDao.upsert(profile('u1'));

    await db.clearAll();

    expect(await db.cachedProfileDao.getById('u1'), isNull);
  });
}
