// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserModel _$UserModelFromJson(Map<String, dynamic> json) => UserModel(
  id: json['id'] as String,
  email: json['email'] as String?,
  phone: json['phone'] as String?,
  isEmailConfirmed: json['isEmailConfirmed'] as bool? ?? false,
  isPhoneConfirmed: json['isPhoneConfirmed'] as bool? ?? false,
);

Map<String, dynamic> _$UserModelToJson(UserModel instance) => <String, dynamic>{
  'id': instance.id,
  'email': instance.email,
  'phone': instance.phone,
  'isEmailConfirmed': instance.isEmailConfirmed,
  'isPhoneConfirmed': instance.isPhoneConfirmed,
};
