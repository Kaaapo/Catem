import 'package:catem_app/core/local_database/app_database.dart';
import 'package:catem_app/features/profile/data/datasources/profile_local_data_source.dart';
import 'package:catem_app/features/profile/data/models/profile_model.dart';
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late AppDatabase db;
  late DriftProfileLocalDataSource dataSource;

  const profile = ProfileModel(id: 'u1', nickPublico: 'ana', termsVersion: '1.0');

  setUp(() {
    db = AppDatabase(NativeDatabase.memory());
    dataSource = DriftProfileLocalDataSource(db.cachedProfileDao);
  });

  tearDown(() => db.close());

  test('getById es null hasta que se guarda el perfil', () async {
    expect(await dataSource.getById('u1'), isNull);

    await dataSource.upsert(profile);

    final cached = await dataSource.getById('u1');
    expect(cached?.nickPublico, 'ana');
    expect(cached?.termsVersion, '1.0');
  });

  test('watchById emite el perfil guardado', () async {
    final emitsProfile = expectLater(
      dataSource.watchById('u1'),
      emitsThrough(isA<ProfileModel>()),
    );

    await dataSource.upsert(profile);

    await emitsProfile;
  });

  test('clear borra la cache', () async {
    await dataSource.upsert(profile);

    await dataSource.clear();

    expect(await dataSource.getById('u1'), isNull);
  });
}
