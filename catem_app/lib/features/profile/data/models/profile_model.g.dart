// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProfileModel _$ProfileModelFromJson(Map<String, dynamic> json) => ProfileModel(
  id: json['id'] as String,
  nickPublico: json['nick_publico'] as String?,
  nombreReal: json['nombre_real'] as String?,
  fechaNacimiento: _dateFromJson(json['fecha_nacimiento'] as String?),
  ciudad: json['ciudad'] as String?,
  consentAcceptedAt: _dateFromJson(json['consent_accepted_at'] as String?),
  termsVersion: json['terms_version'] as String?,
);

Map<String, dynamic> _$ProfileModelToJson(ProfileModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'nick_publico': instance.nickPublico,
      'nombre_real': instance.nombreReal,
      'ciudad': instance.ciudad,
      'terms_version': instance.termsVersion,
      'fecha_nacimiento': _dateOnlyToJson(instance.fechaNacimiento),
      'consent_accepted_at': _timestampToJson(instance.consentAcceptedAt),
    };
