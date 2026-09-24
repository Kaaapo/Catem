import 'package:catem_app/features/auth/domain/entities/user_entity.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'user_model.g.dart';

@JsonSerializable()
class UserModel extends UserEntity {
  const UserModel({
    required super.id,
    super.email,
    super.phone,
    super.isEmailConfirmed,
    super.isPhoneConfirmed,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);

  factory UserModel.fromSupabase(User user) => UserModel(
    id: user.id,
    email: user.email,
    phone: user.phone,
    isEmailConfirmed: user.emailConfirmedAt != null,
    isPhoneConfirmed: user.phoneConfirmedAt != null,
  );

  Map<String, dynamic> toJson() => _$UserModelToJson(this);
}
