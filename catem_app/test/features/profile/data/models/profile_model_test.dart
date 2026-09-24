import 'package:catem_app/features/profile/data/models/profile_model.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final json = <String, dynamic>{
    'id': 'u1',
    'nick_publico': 'ana',
    'nombre_real': 'Ana Perez',
    'fecha_nacimiento': '2000-05-17',
    'ciudad': 'Bogota',
    'consent_accepted_at': '2026-09-24T15:00:00+00:00',
    'terms_version': '1.0',
  };

  test('fromJson mapea las columnas snake_case de Supabase', () {
    final model = ProfileModel.fromJson(json);

    expect(model.id, 'u1');
    expect(model.nickPublico, 'ana');
    expect(model.fechaNacimiento, DateTime(2000, 5, 17));
    expect(model.consentAcceptedAt, DateTime.utc(2026, 9, 24, 15));
    expect(model.termsVersion, '1.0');
  });

  test('toJson serializa la fecha de nacimiento solo como fecha', () {
    final out = ProfileModel.fromJson(json).toJson();

    expect(out['fecha_nacimiento'], '2000-05-17');
    expect(out['consent_accepted_at'], '2026-09-24T15:00:00.000Z');
  });

  test('isOnboardingComplete exige nick, fecha y consentimiento vigente', () {
    final complete = ProfileModel.fromJson(json);
    final withoutConsent = ProfileModel.fromJson({...json, 'terms_version': '0.9'});
    final withoutNick = ProfileModel.fromJson({...json, 'nick_publico': null});

    expect(complete.isOnboardingComplete, isTrue);
    expect(withoutConsent.isOnboardingComplete, isFalse);
    expect(withoutNick.isOnboardingComplete, isFalse);
  });

  test('toCache y fromCache conservan los datos', () {
    final model = ProfileModel.fromJson(json);

    final companion = model.toCache(syncedAt: DateTime(2026));

    expect(companion.id.value, 'u1');
    expect(companion.nickPublico.value, 'ana');
    expect(companion.termsVersion.value, '1.0');
  });
}
