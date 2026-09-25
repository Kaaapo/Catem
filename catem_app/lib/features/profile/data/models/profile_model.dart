import 'package:catem_app/core/local_database/app_database.dart';
import 'package:catem_app/features/profile/domain/entities/profile_entity.dart';
import 'package:drift/drift.dart' show Value;
import 'package:json_annotation/json_annotation.dart';

part 'profile_model.g.dart';

DateTime? _dateFromJson(String? value) =>
    value == null ? null : DateTime.parse(value);

String? _dateOnlyToJson(DateTime? value) =>
    value?.toIso8601String().split('T').first;

String? _timestampToJson(DateTime? value) => value?.toUtc().toIso8601String();

@JsonSerializable(fieldRename: FieldRename.snake)
class ProfileModel extends ProfileEntity {
  const ProfileModel({
    required super.id,
    super.nickPublico,
    super.nombreReal,
    super.fechaNacimiento,
    super.ciudad,
    super.consentAcceptedAt,
    super.termsVersion,
  });

  factory ProfileModel.fromJson(Map<String, dynamic> json) =>
      _$ProfileModelFromJson(json);

  factory ProfileModel.fromEntity(ProfileEntity entity) => ProfileModel(
    id: entity.id,
    nickPublico: entity.nickPublico,
    nombreReal: entity.nombreReal,
    fechaNacimiento: entity.fechaNacimiento,
    ciudad: entity.ciudad,
    consentAcceptedAt: entity.consentAcceptedAt,
    termsVersion: entity.termsVersion,
  );

  factory ProfileModel.fromCache(CachedProfile row) => ProfileModel(
    id: row.id,
    nickPublico: row.nickPublico,
    nombreReal: row.nombreReal,
    fechaNacimiento: row.fechaNacimiento,
    ciudad: row.ciudad,
    consentAcceptedAt: row.consentAcceptedAt,
    termsVersion: row.termsVersion,
  );

  @override
  @JsonKey(fromJson: _dateFromJson, toJson: _dateOnlyToJson)
  DateTime? get fechaNacimiento => super.fechaNacimiento;

  @override
  @JsonKey(fromJson: _dateFromJson, toJson: _timestampToJson)
  DateTime? get consentAcceptedAt => super.consentAcceptedAt;

  Map<String, dynamic> toJson() => _$ProfileModelToJson(this);

  CachedProfilesCompanion toCache({DateTime? syncedAt}) =>
      CachedProfilesCompanion(
        id: Value(id),
        nickPublico: Value(nickPublico),
        nombreReal: Value(nombreReal),
        fechaNacimiento: Value(fechaNacimiento),
        ciudad: Value(ciudad),
        consentAcceptedAt: Value(consentAcceptedAt),
        termsVersion: Value(termsVersion),
        syncedAt: Value(syncedAt ?? DateTime.now()),
      );
}
