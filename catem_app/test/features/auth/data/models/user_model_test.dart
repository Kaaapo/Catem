import 'package:catem_app/features/auth/data/models/user_model.dart';
import 'package:catem_app/features/auth/domain/entities/user_entity.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() {
  test('fromSupabase mapea confirmaciones de email y telefono', () {
    final user = User.fromJson({
      'id': 'u1',
      'aud': 'authenticated',
      'email': 'ana@catem.app',
      'phone': '573001234567',
      'email_confirmed_at': '2026-09-24T15:00:00Z',
      'phone_confirmed_at': null,
      'app_metadata': <String, dynamic>{},
      'user_metadata': <String, dynamic>{},
      'created_at': '2026-09-24T15:00:00Z',
    })!;

    final model = UserModel.fromSupabase(user);

    expect(model.id, 'u1');
    expect(model.email, 'ana@catem.app');
    expect(model.phone, '573001234567');
    expect(model.isEmailConfirmed, isTrue);
    expect(model.isPhoneConfirmed, isFalse);
    expect(model.isVerified, isTrue);
  });

  test('toJson / fromJson son simetricos', () {
    const model = UserModel(id: 'u1', email: 'a@b.co', isEmailConfirmed: true);

    final restored = UserModel.fromJson(model.toJson());

    expect(restored, model);
  });

  test('UserEntity.isVerified exige email o telefono confirmado', () {
    const none = UserEntity(id: 'u1');
    const phone = UserEntity(id: 'u1', isPhoneConfirmed: true);

    expect(none.isVerified, isFalse);
    expect(phone.isVerified, isTrue);
    expect(none, isNot(phone));
  });
}
