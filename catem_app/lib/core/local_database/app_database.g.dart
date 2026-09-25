// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $CachedProfilesTable extends CachedProfiles
    with TableInfo<$CachedProfilesTable, CachedProfile> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CachedProfilesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nickPublicoMeta = const VerificationMeta(
    'nickPublico',
  );
  @override
  late final GeneratedColumn<String> nickPublico = GeneratedColumn<String>(
    'nick_publico',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _nombreRealMeta = const VerificationMeta(
    'nombreReal',
  );
  @override
  late final GeneratedColumn<String> nombreReal = GeneratedColumn<String>(
    'nombre_real',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _fechaNacimientoMeta = const VerificationMeta(
    'fechaNacimiento',
  );
  @override
  late final GeneratedColumn<DateTime> fechaNacimiento =
      GeneratedColumn<DateTime>(
        'fecha_nacimiento',
        aliasedName,
        true,
        type: DriftSqlType.dateTime,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _ciudadMeta = const VerificationMeta('ciudad');
  @override
  late final GeneratedColumn<String> ciudad = GeneratedColumn<String>(
    'ciudad',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _consentAcceptedAtMeta = const VerificationMeta(
    'consentAcceptedAt',
  );
  @override
  late final GeneratedColumn<DateTime> consentAcceptedAt =
      GeneratedColumn<DateTime>(
        'consent_accepted_at',
        aliasedName,
        true,
        type: DriftSqlType.dateTime,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _termsVersionMeta = const VerificationMeta(
    'termsVersion',
  );
  @override
  late final GeneratedColumn<String> termsVersion = GeneratedColumn<String>(
    'terms_version',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _syncedAtMeta = const VerificationMeta(
    'syncedAt',
  );
  @override
  late final GeneratedColumn<DateTime> syncedAt = GeneratedColumn<DateTime>(
    'synced_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    nickPublico,
    nombreReal,
    fechaNacimiento,
    ciudad,
    consentAcceptedAt,
    termsVersion,
    syncedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'cached_profiles';
  @override
  VerificationContext validateIntegrity(
    Insertable<CachedProfile> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('nick_publico')) {
      context.handle(
        _nickPublicoMeta,
        nickPublico.isAcceptableOrUnknown(
          data['nick_publico']!,
          _nickPublicoMeta,
        ),
      );
    }
    if (data.containsKey('nombre_real')) {
      context.handle(
        _nombreRealMeta,
        nombreReal.isAcceptableOrUnknown(data['nombre_real']!, _nombreRealMeta),
      );
    }
    if (data.containsKey('fecha_nacimiento')) {
      context.handle(
        _fechaNacimientoMeta,
        fechaNacimiento.isAcceptableOrUnknown(
          data['fecha_nacimiento']!,
          _fechaNacimientoMeta,
        ),
      );
    }
    if (data.containsKey('ciudad')) {
      context.handle(
        _ciudadMeta,
        ciudad.isAcceptableOrUnknown(data['ciudad']!, _ciudadMeta),
      );
    }
    if (data.containsKey('consent_accepted_at')) {
      context.handle(
        _consentAcceptedAtMeta,
        consentAcceptedAt.isAcceptableOrUnknown(
          data['consent_accepted_at']!,
          _consentAcceptedAtMeta,
        ),
      );
    }
    if (data.containsKey('terms_version')) {
      context.handle(
        _termsVersionMeta,
        termsVersion.isAcceptableOrUnknown(
          data['terms_version']!,
          _termsVersionMeta,
        ),
      );
    }
    if (data.containsKey('synced_at')) {
      context.handle(
        _syncedAtMeta,
        syncedAt.isAcceptableOrUnknown(data['synced_at']!, _syncedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_syncedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  CachedProfile map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return CachedProfile(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      nickPublico: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}nick_publico'],
      ),
      nombreReal: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}nombre_real'],
      ),
      fechaNacimiento: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}fecha_nacimiento'],
      ),
      ciudad: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}ciudad'],
      ),
      consentAcceptedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}consent_accepted_at'],
      ),
      termsVersion: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}terms_version'],
      ),
      syncedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}synced_at'],
      )!,
    );
  }

  @override
  $CachedProfilesTable createAlias(String alias) {
    return $CachedProfilesTable(attachedDatabase, alias);
  }
}

class CachedProfile extends DataClass implements Insertable<CachedProfile> {
  final String id;
  final String? nickPublico;
  final String? nombreReal;
  final DateTime? fechaNacimiento;
  final String? ciudad;
  final DateTime? consentAcceptedAt;
  final String? termsVersion;
  final DateTime syncedAt;
  const CachedProfile({
    required this.id,
    this.nickPublico,
    this.nombreReal,
    this.fechaNacimiento,
    this.ciudad,
    this.consentAcceptedAt,
    this.termsVersion,
    required this.syncedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    if (!nullToAbsent || nickPublico != null) {
      map['nick_publico'] = Variable<String>(nickPublico);
    }
    if (!nullToAbsent || nombreReal != null) {
      map['nombre_real'] = Variable<String>(nombreReal);
    }
    if (!nullToAbsent || fechaNacimiento != null) {
      map['fecha_nacimiento'] = Variable<DateTime>(fechaNacimiento);
    }
    if (!nullToAbsent || ciudad != null) {
      map['ciudad'] = Variable<String>(ciudad);
    }
    if (!nullToAbsent || consentAcceptedAt != null) {
      map['consent_accepted_at'] = Variable<DateTime>(consentAcceptedAt);
    }
    if (!nullToAbsent || termsVersion != null) {
      map['terms_version'] = Variable<String>(termsVersion);
    }
    map['synced_at'] = Variable<DateTime>(syncedAt);
    return map;
  }

  CachedProfilesCompanion toCompanion(bool nullToAbsent) {
    return CachedProfilesCompanion(
      id: Value(id),
      nickPublico: nickPublico == null && nullToAbsent
          ? const Value.absent()
          : Value(nickPublico),
      nombreReal: nombreReal == null && nullToAbsent
          ? const Value.absent()
          : Value(nombreReal),
      fechaNacimiento: fechaNacimiento == null && nullToAbsent
          ? const Value.absent()
          : Value(fechaNacimiento),
      ciudad: ciudad == null && nullToAbsent
          ? const Value.absent()
          : Value(ciudad),
      consentAcceptedAt: consentAcceptedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(consentAcceptedAt),
      termsVersion: termsVersion == null && nullToAbsent
          ? const Value.absent()
          : Value(termsVersion),
      syncedAt: Value(syncedAt),
    );
  }

  factory CachedProfile.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return CachedProfile(
      id: serializer.fromJson<String>(json['id']),
      nickPublico: serializer.fromJson<String?>(json['nickPublico']),
      nombreReal: serializer.fromJson<String?>(json['nombreReal']),
      fechaNacimiento: serializer.fromJson<DateTime?>(json['fechaNacimiento']),
      ciudad: serializer.fromJson<String?>(json['ciudad']),
      consentAcceptedAt: serializer.fromJson<DateTime?>(
        json['consentAcceptedAt'],
      ),
      termsVersion: serializer.fromJson<String?>(json['termsVersion']),
      syncedAt: serializer.fromJson<DateTime>(json['syncedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'nickPublico': serializer.toJson<String?>(nickPublico),
      'nombreReal': serializer.toJson<String?>(nombreReal),
      'fechaNacimiento': serializer.toJson<DateTime?>(fechaNacimiento),
      'ciudad': serializer.toJson<String?>(ciudad),
      'consentAcceptedAt': serializer.toJson<DateTime?>(consentAcceptedAt),
      'termsVersion': serializer.toJson<String?>(termsVersion),
      'syncedAt': serializer.toJson<DateTime>(syncedAt),
    };
  }

  CachedProfile copyWith({
    String? id,
    Value<String?> nickPublico = const Value.absent(),
    Value<String?> nombreReal = const Value.absent(),
    Value<DateTime?> fechaNacimiento = const Value.absent(),
    Value<String?> ciudad = const Value.absent(),
    Value<DateTime?> consentAcceptedAt = const Value.absent(),
    Value<String?> termsVersion = const Value.absent(),
    DateTime? syncedAt,
  }) => CachedProfile(
    id: id ?? this.id,
    nickPublico: nickPublico.present ? nickPublico.value : this.nickPublico,
    nombreReal: nombreReal.present ? nombreReal.value : this.nombreReal,
    fechaNacimiento: fechaNacimiento.present
        ? fechaNacimiento.value
        : this.fechaNacimiento,
    ciudad: ciudad.present ? ciudad.value : this.ciudad,
    consentAcceptedAt: consentAcceptedAt.present
        ? consentAcceptedAt.value
        : this.consentAcceptedAt,
    termsVersion: termsVersion.present ? termsVersion.value : this.termsVersion,
    syncedAt: syncedAt ?? this.syncedAt,
  );
  CachedProfile copyWithCompanion(CachedProfilesCompanion data) {
    return CachedProfile(
      id: data.id.present ? data.id.value : this.id,
      nickPublico: data.nickPublico.present
          ? data.nickPublico.value
          : this.nickPublico,
      nombreReal: data.nombreReal.present
          ? data.nombreReal.value
          : this.nombreReal,
      fechaNacimiento: data.fechaNacimiento.present
          ? data.fechaNacimiento.value
          : this.fechaNacimiento,
      ciudad: data.ciudad.present ? data.ciudad.value : this.ciudad,
      consentAcceptedAt: data.consentAcceptedAt.present
          ? data.consentAcceptedAt.value
          : this.consentAcceptedAt,
      termsVersion: data.termsVersion.present
          ? data.termsVersion.value
          : this.termsVersion,
      syncedAt: data.syncedAt.present ? data.syncedAt.value : this.syncedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('CachedProfile(')
          ..write('id: $id, ')
          ..write('nickPublico: $nickPublico, ')
          ..write('nombreReal: $nombreReal, ')
          ..write('fechaNacimiento: $fechaNacimiento, ')
          ..write('ciudad: $ciudad, ')
          ..write('consentAcceptedAt: $consentAcceptedAt, ')
          ..write('termsVersion: $termsVersion, ')
          ..write('syncedAt: $syncedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    nickPublico,
    nombreReal,
    fechaNacimiento,
    ciudad,
    consentAcceptedAt,
    termsVersion,
    syncedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CachedProfile &&
          other.id == this.id &&
          other.nickPublico == this.nickPublico &&
          other.nombreReal == this.nombreReal &&
          other.fechaNacimiento == this.fechaNacimiento &&
          other.ciudad == this.ciudad &&
          other.consentAcceptedAt == this.consentAcceptedAt &&
          other.termsVersion == this.termsVersion &&
          other.syncedAt == this.syncedAt);
}

class CachedProfilesCompanion extends UpdateCompanion<CachedProfile> {
  final Value<String> id;
  final Value<String?> nickPublico;
  final Value<String?> nombreReal;
  final Value<DateTime?> fechaNacimiento;
  final Value<String?> ciudad;
  final Value<DateTime?> consentAcceptedAt;
  final Value<String?> termsVersion;
  final Value<DateTime> syncedAt;
  final Value<int> rowid;
  const CachedProfilesCompanion({
    this.id = const Value.absent(),
    this.nickPublico = const Value.absent(),
    this.nombreReal = const Value.absent(),
    this.fechaNacimiento = const Value.absent(),
    this.ciudad = const Value.absent(),
    this.consentAcceptedAt = const Value.absent(),
    this.termsVersion = const Value.absent(),
    this.syncedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  CachedProfilesCompanion.insert({
    required String id,
    this.nickPublico = const Value.absent(),
    this.nombreReal = const Value.absent(),
    this.fechaNacimiento = const Value.absent(),
    this.ciudad = const Value.absent(),
    this.consentAcceptedAt = const Value.absent(),
    this.termsVersion = const Value.absent(),
    required DateTime syncedAt,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       syncedAt = Value(syncedAt);
  static Insertable<CachedProfile> custom({
    Expression<String>? id,
    Expression<String>? nickPublico,
    Expression<String>? nombreReal,
    Expression<DateTime>? fechaNacimiento,
    Expression<String>? ciudad,
    Expression<DateTime>? consentAcceptedAt,
    Expression<String>? termsVersion,
    Expression<DateTime>? syncedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (nickPublico != null) 'nick_publico': nickPublico,
      if (nombreReal != null) 'nombre_real': nombreReal,
      if (fechaNacimiento != null) 'fecha_nacimiento': fechaNacimiento,
      if (ciudad != null) 'ciudad': ciudad,
      if (consentAcceptedAt != null) 'consent_accepted_at': consentAcceptedAt,
      if (termsVersion != null) 'terms_version': termsVersion,
      if (syncedAt != null) 'synced_at': syncedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  CachedProfilesCompanion copyWith({
    Value<String>? id,
    Value<String?>? nickPublico,
    Value<String?>? nombreReal,
    Value<DateTime?>? fechaNacimiento,
    Value<String?>? ciudad,
    Value<DateTime?>? consentAcceptedAt,
    Value<String?>? termsVersion,
    Value<DateTime>? syncedAt,
    Value<int>? rowid,
  }) {
    return CachedProfilesCompanion(
      id: id ?? this.id,
      nickPublico: nickPublico ?? this.nickPublico,
      nombreReal: nombreReal ?? this.nombreReal,
      fechaNacimiento: fechaNacimiento ?? this.fechaNacimiento,
      ciudad: ciudad ?? this.ciudad,
      consentAcceptedAt: consentAcceptedAt ?? this.consentAcceptedAt,
      termsVersion: termsVersion ?? this.termsVersion,
      syncedAt: syncedAt ?? this.syncedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (nickPublico.present) {
      map['nick_publico'] = Variable<String>(nickPublico.value);
    }
    if (nombreReal.present) {
      map['nombre_real'] = Variable<String>(nombreReal.value);
    }
    if (fechaNacimiento.present) {
      map['fecha_nacimiento'] = Variable<DateTime>(fechaNacimiento.value);
    }
    if (ciudad.present) {
      map['ciudad'] = Variable<String>(ciudad.value);
    }
    if (consentAcceptedAt.present) {
      map['consent_accepted_at'] = Variable<DateTime>(consentAcceptedAt.value);
    }
    if (termsVersion.present) {
      map['terms_version'] = Variable<String>(termsVersion.value);
    }
    if (syncedAt.present) {
      map['synced_at'] = Variable<DateTime>(syncedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CachedProfilesCompanion(')
          ..write('id: $id, ')
          ..write('nickPublico: $nickPublico, ')
          ..write('nombreReal: $nombreReal, ')
          ..write('fechaNacimiento: $fechaNacimiento, ')
          ..write('ciudad: $ciudad, ')
          ..write('consentAcceptedAt: $consentAcceptedAt, ')
          ..write('termsVersion: $termsVersion, ')
          ..write('syncedAt: $syncedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $CachedDailyAnswersTable extends CachedDailyAnswers
    with TableInfo<$CachedDailyAnswersTable, CachedDailyAnswer> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CachedDailyAnswersTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _userIdMeta = const VerificationMeta('userId');
  @override
  late final GeneratedColumn<String> userId = GeneratedColumn<String>(
    'user_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _questionIdMeta = const VerificationMeta(
    'questionId',
  );
  @override
  late final GeneratedColumn<String> questionId = GeneratedColumn<String>(
    'question_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _answerMeta = const VerificationMeta('answer');
  @override
  late final GeneratedColumn<String> answer = GeneratedColumn<String>(
    'answer',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _answeredAtMeta = const VerificationMeta(
    'answeredAt',
  );
  @override
  late final GeneratedColumn<DateTime> answeredAt = GeneratedColumn<DateTime>(
    'answered_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _syncedAtMeta = const VerificationMeta(
    'syncedAt',
  );
  @override
  late final GeneratedColumn<DateTime> syncedAt = GeneratedColumn<DateTime>(
    'synced_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    userId,
    questionId,
    answer,
    answeredAt,
    syncedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'cached_daily_answers';
  @override
  VerificationContext validateIntegrity(
    Insertable<CachedDailyAnswer> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('user_id')) {
      context.handle(
        _userIdMeta,
        userId.isAcceptableOrUnknown(data['user_id']!, _userIdMeta),
      );
    } else if (isInserting) {
      context.missing(_userIdMeta);
    }
    if (data.containsKey('question_id')) {
      context.handle(
        _questionIdMeta,
        questionId.isAcceptableOrUnknown(data['question_id']!, _questionIdMeta),
      );
    } else if (isInserting) {
      context.missing(_questionIdMeta);
    }
    if (data.containsKey('answer')) {
      context.handle(
        _answerMeta,
        answer.isAcceptableOrUnknown(data['answer']!, _answerMeta),
      );
    } else if (isInserting) {
      context.missing(_answerMeta);
    }
    if (data.containsKey('answered_at')) {
      context.handle(
        _answeredAtMeta,
        answeredAt.isAcceptableOrUnknown(data['answered_at']!, _answeredAtMeta),
      );
    } else if (isInserting) {
      context.missing(_answeredAtMeta);
    }
    if (data.containsKey('synced_at')) {
      context.handle(
        _syncedAtMeta,
        syncedAt.isAcceptableOrUnknown(data['synced_at']!, _syncedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_syncedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  CachedDailyAnswer map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return CachedDailyAnswer(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      userId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}user_id'],
      )!,
      questionId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}question_id'],
      )!,
      answer: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}answer'],
      )!,
      answeredAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}answered_at'],
      )!,
      syncedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}synced_at'],
      )!,
    );
  }

  @override
  $CachedDailyAnswersTable createAlias(String alias) {
    return $CachedDailyAnswersTable(attachedDatabase, alias);
  }
}

class CachedDailyAnswer extends DataClass
    implements Insertable<CachedDailyAnswer> {
  final String id;
  final String userId;
  final String questionId;
  final String answer;
  final DateTime answeredAt;
  final DateTime syncedAt;
  const CachedDailyAnswer({
    required this.id,
    required this.userId,
    required this.questionId,
    required this.answer,
    required this.answeredAt,
    required this.syncedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['user_id'] = Variable<String>(userId);
    map['question_id'] = Variable<String>(questionId);
    map['answer'] = Variable<String>(answer);
    map['answered_at'] = Variable<DateTime>(answeredAt);
    map['synced_at'] = Variable<DateTime>(syncedAt);
    return map;
  }

  CachedDailyAnswersCompanion toCompanion(bool nullToAbsent) {
    return CachedDailyAnswersCompanion(
      id: Value(id),
      userId: Value(userId),
      questionId: Value(questionId),
      answer: Value(answer),
      answeredAt: Value(answeredAt),
      syncedAt: Value(syncedAt),
    );
  }

  factory CachedDailyAnswer.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return CachedDailyAnswer(
      id: serializer.fromJson<String>(json['id']),
      userId: serializer.fromJson<String>(json['userId']),
      questionId: serializer.fromJson<String>(json['questionId']),
      answer: serializer.fromJson<String>(json['answer']),
      answeredAt: serializer.fromJson<DateTime>(json['answeredAt']),
      syncedAt: serializer.fromJson<DateTime>(json['syncedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'userId': serializer.toJson<String>(userId),
      'questionId': serializer.toJson<String>(questionId),
      'answer': serializer.toJson<String>(answer),
      'answeredAt': serializer.toJson<DateTime>(answeredAt),
      'syncedAt': serializer.toJson<DateTime>(syncedAt),
    };
  }

  CachedDailyAnswer copyWith({
    String? id,
    String? userId,
    String? questionId,
    String? answer,
    DateTime? answeredAt,
    DateTime? syncedAt,
  }) => CachedDailyAnswer(
    id: id ?? this.id,
    userId: userId ?? this.userId,
    questionId: questionId ?? this.questionId,
    answer: answer ?? this.answer,
    answeredAt: answeredAt ?? this.answeredAt,
    syncedAt: syncedAt ?? this.syncedAt,
  );
  CachedDailyAnswer copyWithCompanion(CachedDailyAnswersCompanion data) {
    return CachedDailyAnswer(
      id: data.id.present ? data.id.value : this.id,
      userId: data.userId.present ? data.userId.value : this.userId,
      questionId: data.questionId.present
          ? data.questionId.value
          : this.questionId,
      answer: data.answer.present ? data.answer.value : this.answer,
      answeredAt: data.answeredAt.present
          ? data.answeredAt.value
          : this.answeredAt,
      syncedAt: data.syncedAt.present ? data.syncedAt.value : this.syncedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('CachedDailyAnswer(')
          ..write('id: $id, ')
          ..write('userId: $userId, ')
          ..write('questionId: $questionId, ')
          ..write('answer: $answer, ')
          ..write('answeredAt: $answeredAt, ')
          ..write('syncedAt: $syncedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, userId, questionId, answer, answeredAt, syncedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CachedDailyAnswer &&
          other.id == this.id &&
          other.userId == this.userId &&
          other.questionId == this.questionId &&
          other.answer == this.answer &&
          other.answeredAt == this.answeredAt &&
          other.syncedAt == this.syncedAt);
}

class CachedDailyAnswersCompanion extends UpdateCompanion<CachedDailyAnswer> {
  final Value<String> id;
  final Value<String> userId;
  final Value<String> questionId;
  final Value<String> answer;
  final Value<DateTime> answeredAt;
  final Value<DateTime> syncedAt;
  final Value<int> rowid;
  const CachedDailyAnswersCompanion({
    this.id = const Value.absent(),
    this.userId = const Value.absent(),
    this.questionId = const Value.absent(),
    this.answer = const Value.absent(),
    this.answeredAt = const Value.absent(),
    this.syncedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  CachedDailyAnswersCompanion.insert({
    required String id,
    required String userId,
    required String questionId,
    required String answer,
    required DateTime answeredAt,
    required DateTime syncedAt,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       userId = Value(userId),
       questionId = Value(questionId),
       answer = Value(answer),
       answeredAt = Value(answeredAt),
       syncedAt = Value(syncedAt);
  static Insertable<CachedDailyAnswer> custom({
    Expression<String>? id,
    Expression<String>? userId,
    Expression<String>? questionId,
    Expression<String>? answer,
    Expression<DateTime>? answeredAt,
    Expression<DateTime>? syncedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (userId != null) 'user_id': userId,
      if (questionId != null) 'question_id': questionId,
      if (answer != null) 'answer': answer,
      if (answeredAt != null) 'answered_at': answeredAt,
      if (syncedAt != null) 'synced_at': syncedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  CachedDailyAnswersCompanion copyWith({
    Value<String>? id,
    Value<String>? userId,
    Value<String>? questionId,
    Value<String>? answer,
    Value<DateTime>? answeredAt,
    Value<DateTime>? syncedAt,
    Value<int>? rowid,
  }) {
    return CachedDailyAnswersCompanion(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      questionId: questionId ?? this.questionId,
      answer: answer ?? this.answer,
      answeredAt: answeredAt ?? this.answeredAt,
      syncedAt: syncedAt ?? this.syncedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (userId.present) {
      map['user_id'] = Variable<String>(userId.value);
    }
    if (questionId.present) {
      map['question_id'] = Variable<String>(questionId.value);
    }
    if (answer.present) {
      map['answer'] = Variable<String>(answer.value);
    }
    if (answeredAt.present) {
      map['answered_at'] = Variable<DateTime>(answeredAt.value);
    }
    if (syncedAt.present) {
      map['synced_at'] = Variable<DateTime>(syncedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CachedDailyAnswersCompanion(')
          ..write('id: $id, ')
          ..write('userId: $userId, ')
          ..write('questionId: $questionId, ')
          ..write('answer: $answer, ')
          ..write('answeredAt: $answeredAt, ')
          ..write('syncedAt: $syncedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $CachedMoodEntriesTable extends CachedMoodEntries
    with TableInfo<$CachedMoodEntriesTable, CachedMoodEntry> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CachedMoodEntriesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _userIdMeta = const VerificationMeta('userId');
  @override
  late final GeneratedColumn<String> userId = GeneratedColumn<String>(
    'user_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _moodMeta = const VerificationMeta('mood');
  @override
  late final GeneratedColumn<int> mood = GeneratedColumn<int>(
    'mood',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _noteMeta = const VerificationMeta('note');
  @override
  late final GeneratedColumn<String> note = GeneratedColumn<String>(
    'note',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _recordedAtMeta = const VerificationMeta(
    'recordedAt',
  );
  @override
  late final GeneratedColumn<DateTime> recordedAt = GeneratedColumn<DateTime>(
    'recorded_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _syncedAtMeta = const VerificationMeta(
    'syncedAt',
  );
  @override
  late final GeneratedColumn<DateTime> syncedAt = GeneratedColumn<DateTime>(
    'synced_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    userId,
    mood,
    note,
    recordedAt,
    syncedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'cached_mood_entries';
  @override
  VerificationContext validateIntegrity(
    Insertable<CachedMoodEntry> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('user_id')) {
      context.handle(
        _userIdMeta,
        userId.isAcceptableOrUnknown(data['user_id']!, _userIdMeta),
      );
    } else if (isInserting) {
      context.missing(_userIdMeta);
    }
    if (data.containsKey('mood')) {
      context.handle(
        _moodMeta,
        mood.isAcceptableOrUnknown(data['mood']!, _moodMeta),
      );
    } else if (isInserting) {
      context.missing(_moodMeta);
    }
    if (data.containsKey('note')) {
      context.handle(
        _noteMeta,
        note.isAcceptableOrUnknown(data['note']!, _noteMeta),
      );
    }
    if (data.containsKey('recorded_at')) {
      context.handle(
        _recordedAtMeta,
        recordedAt.isAcceptableOrUnknown(data['recorded_at']!, _recordedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_recordedAtMeta);
    }
    if (data.containsKey('synced_at')) {
      context.handle(
        _syncedAtMeta,
        syncedAt.isAcceptableOrUnknown(data['synced_at']!, _syncedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_syncedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  CachedMoodEntry map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return CachedMoodEntry(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      userId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}user_id'],
      )!,
      mood: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}mood'],
      )!,
      note: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}note'],
      ),
      recordedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}recorded_at'],
      )!,
      syncedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}synced_at'],
      )!,
    );
  }

  @override
  $CachedMoodEntriesTable createAlias(String alias) {
    return $CachedMoodEntriesTable(attachedDatabase, alias);
  }
}

class CachedMoodEntry extends DataClass implements Insertable<CachedMoodEntry> {
  final String id;
  final String userId;
  final int mood;
  final String? note;
  final DateTime recordedAt;
  final DateTime syncedAt;
  const CachedMoodEntry({
    required this.id,
    required this.userId,
    required this.mood,
    this.note,
    required this.recordedAt,
    required this.syncedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['user_id'] = Variable<String>(userId);
    map['mood'] = Variable<int>(mood);
    if (!nullToAbsent || note != null) {
      map['note'] = Variable<String>(note);
    }
    map['recorded_at'] = Variable<DateTime>(recordedAt);
    map['synced_at'] = Variable<DateTime>(syncedAt);
    return map;
  }

  CachedMoodEntriesCompanion toCompanion(bool nullToAbsent) {
    return CachedMoodEntriesCompanion(
      id: Value(id),
      userId: Value(userId),
      mood: Value(mood),
      note: note == null && nullToAbsent ? const Value.absent() : Value(note),
      recordedAt: Value(recordedAt),
      syncedAt: Value(syncedAt),
    );
  }

  factory CachedMoodEntry.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return CachedMoodEntry(
      id: serializer.fromJson<String>(json['id']),
      userId: serializer.fromJson<String>(json['userId']),
      mood: serializer.fromJson<int>(json['mood']),
      note: serializer.fromJson<String?>(json['note']),
      recordedAt: serializer.fromJson<DateTime>(json['recordedAt']),
      syncedAt: serializer.fromJson<DateTime>(json['syncedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'userId': serializer.toJson<String>(userId),
      'mood': serializer.toJson<int>(mood),
      'note': serializer.toJson<String?>(note),
      'recordedAt': serializer.toJson<DateTime>(recordedAt),
      'syncedAt': serializer.toJson<DateTime>(syncedAt),
    };
  }

  CachedMoodEntry copyWith({
    String? id,
    String? userId,
    int? mood,
    Value<String?> note = const Value.absent(),
    DateTime? recordedAt,
    DateTime? syncedAt,
  }) => CachedMoodEntry(
    id: id ?? this.id,
    userId: userId ?? this.userId,
    mood: mood ?? this.mood,
    note: note.present ? note.value : this.note,
    recordedAt: recordedAt ?? this.recordedAt,
    syncedAt: syncedAt ?? this.syncedAt,
  );
  CachedMoodEntry copyWithCompanion(CachedMoodEntriesCompanion data) {
    return CachedMoodEntry(
      id: data.id.present ? data.id.value : this.id,
      userId: data.userId.present ? data.userId.value : this.userId,
      mood: data.mood.present ? data.mood.value : this.mood,
      note: data.note.present ? data.note.value : this.note,
      recordedAt: data.recordedAt.present
          ? data.recordedAt.value
          : this.recordedAt,
      syncedAt: data.syncedAt.present ? data.syncedAt.value : this.syncedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('CachedMoodEntry(')
          ..write('id: $id, ')
          ..write('userId: $userId, ')
          ..write('mood: $mood, ')
          ..write('note: $note, ')
          ..write('recordedAt: $recordedAt, ')
          ..write('syncedAt: $syncedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, userId, mood, note, recordedAt, syncedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CachedMoodEntry &&
          other.id == this.id &&
          other.userId == this.userId &&
          other.mood == this.mood &&
          other.note == this.note &&
          other.recordedAt == this.recordedAt &&
          other.syncedAt == this.syncedAt);
}

class CachedMoodEntriesCompanion extends UpdateCompanion<CachedMoodEntry> {
  final Value<String> id;
  final Value<String> userId;
  final Value<int> mood;
  final Value<String?> note;
  final Value<DateTime> recordedAt;
  final Value<DateTime> syncedAt;
  final Value<int> rowid;
  const CachedMoodEntriesCompanion({
    this.id = const Value.absent(),
    this.userId = const Value.absent(),
    this.mood = const Value.absent(),
    this.note = const Value.absent(),
    this.recordedAt = const Value.absent(),
    this.syncedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  CachedMoodEntriesCompanion.insert({
    required String id,
    required String userId,
    required int mood,
    this.note = const Value.absent(),
    required DateTime recordedAt,
    required DateTime syncedAt,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       userId = Value(userId),
       mood = Value(mood),
       recordedAt = Value(recordedAt),
       syncedAt = Value(syncedAt);
  static Insertable<CachedMoodEntry> custom({
    Expression<String>? id,
    Expression<String>? userId,
    Expression<int>? mood,
    Expression<String>? note,
    Expression<DateTime>? recordedAt,
    Expression<DateTime>? syncedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (userId != null) 'user_id': userId,
      if (mood != null) 'mood': mood,
      if (note != null) 'note': note,
      if (recordedAt != null) 'recorded_at': recordedAt,
      if (syncedAt != null) 'synced_at': syncedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  CachedMoodEntriesCompanion copyWith({
    Value<String>? id,
    Value<String>? userId,
    Value<int>? mood,
    Value<String?>? note,
    Value<DateTime>? recordedAt,
    Value<DateTime>? syncedAt,
    Value<int>? rowid,
  }) {
    return CachedMoodEntriesCompanion(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      mood: mood ?? this.mood,
      note: note ?? this.note,
      recordedAt: recordedAt ?? this.recordedAt,
      syncedAt: syncedAt ?? this.syncedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (userId.present) {
      map['user_id'] = Variable<String>(userId.value);
    }
    if (mood.present) {
      map['mood'] = Variable<int>(mood.value);
    }
    if (note.present) {
      map['note'] = Variable<String>(note.value);
    }
    if (recordedAt.present) {
      map['recorded_at'] = Variable<DateTime>(recordedAt.value);
    }
    if (syncedAt.present) {
      map['synced_at'] = Variable<DateTime>(syncedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CachedMoodEntriesCompanion(')
          ..write('id: $id, ')
          ..write('userId: $userId, ')
          ..write('mood: $mood, ')
          ..write('note: $note, ')
          ..write('recordedAt: $recordedAt, ')
          ..write('syncedAt: $syncedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $CachedProfilesTable cachedProfiles = $CachedProfilesTable(this);
  late final $CachedDailyAnswersTable cachedDailyAnswers =
      $CachedDailyAnswersTable(this);
  late final $CachedMoodEntriesTable cachedMoodEntries =
      $CachedMoodEntriesTable(this);
  late final CachedProfileDao cachedProfileDao = CachedProfileDao(
    this as AppDatabase,
  );
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    cachedProfiles,
    cachedDailyAnswers,
    cachedMoodEntries,
  ];
}

typedef $$CachedProfilesTableCreateCompanionBuilder =
    CachedProfilesCompanion Function({
      required String id,
      Value<String?> nickPublico,
      Value<String?> nombreReal,
      Value<DateTime?> fechaNacimiento,
      Value<String?> ciudad,
      Value<DateTime?> consentAcceptedAt,
      Value<String?> termsVersion,
      required DateTime syncedAt,
      Value<int> rowid,
    });
typedef $$CachedProfilesTableUpdateCompanionBuilder =
    CachedProfilesCompanion Function({
      Value<String> id,
      Value<String?> nickPublico,
      Value<String?> nombreReal,
      Value<DateTime?> fechaNacimiento,
      Value<String?> ciudad,
      Value<DateTime?> consentAcceptedAt,
      Value<String?> termsVersion,
      Value<DateTime> syncedAt,
      Value<int> rowid,
    });

class $$CachedProfilesTableFilterComposer
    extends Composer<_$AppDatabase, $CachedProfilesTable> {
  $$CachedProfilesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get nickPublico => $composableBuilder(
    column: $table.nickPublico,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get nombreReal => $composableBuilder(
    column: $table.nombreReal,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get fechaNacimiento => $composableBuilder(
    column: $table.fechaNacimiento,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get ciudad => $composableBuilder(
    column: $table.ciudad,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get consentAcceptedAt => $composableBuilder(
    column: $table.consentAcceptedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get termsVersion => $composableBuilder(
    column: $table.termsVersion,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get syncedAt => $composableBuilder(
    column: $table.syncedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$CachedProfilesTableOrderingComposer
    extends Composer<_$AppDatabase, $CachedProfilesTable> {
  $$CachedProfilesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get nickPublico => $composableBuilder(
    column: $table.nickPublico,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get nombreReal => $composableBuilder(
    column: $table.nombreReal,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get fechaNacimiento => $composableBuilder(
    column: $table.fechaNacimiento,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get ciudad => $composableBuilder(
    column: $table.ciudad,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get consentAcceptedAt => $composableBuilder(
    column: $table.consentAcceptedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get termsVersion => $composableBuilder(
    column: $table.termsVersion,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get syncedAt => $composableBuilder(
    column: $table.syncedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$CachedProfilesTableAnnotationComposer
    extends Composer<_$AppDatabase, $CachedProfilesTable> {
  $$CachedProfilesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get nickPublico => $composableBuilder(
    column: $table.nickPublico,
    builder: (column) => column,
  );

  GeneratedColumn<String> get nombreReal => $composableBuilder(
    column: $table.nombreReal,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get fechaNacimiento => $composableBuilder(
    column: $table.fechaNacimiento,
    builder: (column) => column,
  );

  GeneratedColumn<String> get ciudad =>
      $composableBuilder(column: $table.ciudad, builder: (column) => column);

  GeneratedColumn<DateTime> get consentAcceptedAt => $composableBuilder(
    column: $table.consentAcceptedAt,
    builder: (column) => column,
  );

  GeneratedColumn<String> get termsVersion => $composableBuilder(
    column: $table.termsVersion,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get syncedAt =>
      $composableBuilder(column: $table.syncedAt, builder: (column) => column);
}

class $$CachedProfilesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $CachedProfilesTable,
          CachedProfile,
          $$CachedProfilesTableFilterComposer,
          $$CachedProfilesTableOrderingComposer,
          $$CachedProfilesTableAnnotationComposer,
          $$CachedProfilesTableCreateCompanionBuilder,
          $$CachedProfilesTableUpdateCompanionBuilder,
          (
            CachedProfile,
            BaseReferences<_$AppDatabase, $CachedProfilesTable, CachedProfile>,
          ),
          CachedProfile,
          PrefetchHooks Function()
        > {
  $$CachedProfilesTableTableManager(
    _$AppDatabase db,
    $CachedProfilesTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$CachedProfilesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$CachedProfilesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$CachedProfilesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String?> nickPublico = const Value.absent(),
                Value<String?> nombreReal = const Value.absent(),
                Value<DateTime?> fechaNacimiento = const Value.absent(),
                Value<String?> ciudad = const Value.absent(),
                Value<DateTime?> consentAcceptedAt = const Value.absent(),
                Value<String?> termsVersion = const Value.absent(),
                Value<DateTime> syncedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => CachedProfilesCompanion(
                id: id,
                nickPublico: nickPublico,
                nombreReal: nombreReal,
                fechaNacimiento: fechaNacimiento,
                ciudad: ciudad,
                consentAcceptedAt: consentAcceptedAt,
                termsVersion: termsVersion,
                syncedAt: syncedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                Value<String?> nickPublico = const Value.absent(),
                Value<String?> nombreReal = const Value.absent(),
                Value<DateTime?> fechaNacimiento = const Value.absent(),
                Value<String?> ciudad = const Value.absent(),
                Value<DateTime?> consentAcceptedAt = const Value.absent(),
                Value<String?> termsVersion = const Value.absent(),
                required DateTime syncedAt,
                Value<int> rowid = const Value.absent(),
              }) => CachedProfilesCompanion.insert(
                id: id,
                nickPublico: nickPublico,
                nombreReal: nombreReal,
                fechaNacimiento: fechaNacimiento,
                ciudad: ciudad,
                consentAcceptedAt: consentAcceptedAt,
                termsVersion: termsVersion,
                syncedAt: syncedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$CachedProfilesTable, CachedProfile>(table),
                  BaseReferences<
                    _$AppDatabase,
                    $CachedProfilesTable,
                    CachedProfile
                  >(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$CachedProfilesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $CachedProfilesTable,
      CachedProfile,
      $$CachedProfilesTableFilterComposer,
      $$CachedProfilesTableOrderingComposer,
      $$CachedProfilesTableAnnotationComposer,
      $$CachedProfilesTableCreateCompanionBuilder,
      $$CachedProfilesTableUpdateCompanionBuilder,
      (
        CachedProfile,
        BaseReferences<_$AppDatabase, $CachedProfilesTable, CachedProfile>,
      ),
      CachedProfile,
      PrefetchHooks Function()
    >;
typedef $$CachedDailyAnswersTableCreateCompanionBuilder =
    CachedDailyAnswersCompanion Function({
      required String id,
      required String userId,
      required String questionId,
      required String answer,
      required DateTime answeredAt,
      required DateTime syncedAt,
      Value<int> rowid,
    });
typedef $$CachedDailyAnswersTableUpdateCompanionBuilder =
    CachedDailyAnswersCompanion Function({
      Value<String> id,
      Value<String> userId,
      Value<String> questionId,
      Value<String> answer,
      Value<DateTime> answeredAt,
      Value<DateTime> syncedAt,
      Value<int> rowid,
    });

class $$CachedDailyAnswersTableFilterComposer
    extends Composer<_$AppDatabase, $CachedDailyAnswersTable> {
  $$CachedDailyAnswersTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get userId => $composableBuilder(
    column: $table.userId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get questionId => $composableBuilder(
    column: $table.questionId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get answer => $composableBuilder(
    column: $table.answer,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get answeredAt => $composableBuilder(
    column: $table.answeredAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get syncedAt => $composableBuilder(
    column: $table.syncedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$CachedDailyAnswersTableOrderingComposer
    extends Composer<_$AppDatabase, $CachedDailyAnswersTable> {
  $$CachedDailyAnswersTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get userId => $composableBuilder(
    column: $table.userId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get questionId => $composableBuilder(
    column: $table.questionId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get answer => $composableBuilder(
    column: $table.answer,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get answeredAt => $composableBuilder(
    column: $table.answeredAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get syncedAt => $composableBuilder(
    column: $table.syncedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$CachedDailyAnswersTableAnnotationComposer
    extends Composer<_$AppDatabase, $CachedDailyAnswersTable> {
  $$CachedDailyAnswersTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get userId =>
      $composableBuilder(column: $table.userId, builder: (column) => column);

  GeneratedColumn<String> get questionId => $composableBuilder(
    column: $table.questionId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get answer =>
      $composableBuilder(column: $table.answer, builder: (column) => column);

  GeneratedColumn<DateTime> get answeredAt => $composableBuilder(
    column: $table.answeredAt,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get syncedAt =>
      $composableBuilder(column: $table.syncedAt, builder: (column) => column);
}

class $$CachedDailyAnswersTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $CachedDailyAnswersTable,
          CachedDailyAnswer,
          $$CachedDailyAnswersTableFilterComposer,
          $$CachedDailyAnswersTableOrderingComposer,
          $$CachedDailyAnswersTableAnnotationComposer,
          $$CachedDailyAnswersTableCreateCompanionBuilder,
          $$CachedDailyAnswersTableUpdateCompanionBuilder,
          (
            CachedDailyAnswer,
            BaseReferences<
              _$AppDatabase,
              $CachedDailyAnswersTable,
              CachedDailyAnswer
            >,
          ),
          CachedDailyAnswer,
          PrefetchHooks Function()
        > {
  $$CachedDailyAnswersTableTableManager(
    _$AppDatabase db,
    $CachedDailyAnswersTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$CachedDailyAnswersTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$CachedDailyAnswersTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$CachedDailyAnswersTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> userId = const Value.absent(),
                Value<String> questionId = const Value.absent(),
                Value<String> answer = const Value.absent(),
                Value<DateTime> answeredAt = const Value.absent(),
                Value<DateTime> syncedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => CachedDailyAnswersCompanion(
                id: id,
                userId: userId,
                questionId: questionId,
                answer: answer,
                answeredAt: answeredAt,
                syncedAt: syncedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String userId,
                required String questionId,
                required String answer,
                required DateTime answeredAt,
                required DateTime syncedAt,
                Value<int> rowid = const Value.absent(),
              }) => CachedDailyAnswersCompanion.insert(
                id: id,
                userId: userId,
                questionId: questionId,
                answer: answer,
                answeredAt: answeredAt,
                syncedAt: syncedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$CachedDailyAnswersTable, CachedDailyAnswer>(
                    table,
                  ),
                  BaseReferences<
                    _$AppDatabase,
                    $CachedDailyAnswersTable,
                    CachedDailyAnswer
                  >(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$CachedDailyAnswersTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $CachedDailyAnswersTable,
      CachedDailyAnswer,
      $$CachedDailyAnswersTableFilterComposer,
      $$CachedDailyAnswersTableOrderingComposer,
      $$CachedDailyAnswersTableAnnotationComposer,
      $$CachedDailyAnswersTableCreateCompanionBuilder,
      $$CachedDailyAnswersTableUpdateCompanionBuilder,
      (
        CachedDailyAnswer,
        BaseReferences<
          _$AppDatabase,
          $CachedDailyAnswersTable,
          CachedDailyAnswer
        >,
      ),
      CachedDailyAnswer,
      PrefetchHooks Function()
    >;
typedef $$CachedMoodEntriesTableCreateCompanionBuilder =
    CachedMoodEntriesCompanion Function({
      required String id,
      required String userId,
      required int mood,
      Value<String?> note,
      required DateTime recordedAt,
      required DateTime syncedAt,
      Value<int> rowid,
    });
typedef $$CachedMoodEntriesTableUpdateCompanionBuilder =
    CachedMoodEntriesCompanion Function({
      Value<String> id,
      Value<String> userId,
      Value<int> mood,
      Value<String?> note,
      Value<DateTime> recordedAt,
      Value<DateTime> syncedAt,
      Value<int> rowid,
    });

class $$CachedMoodEntriesTableFilterComposer
    extends Composer<_$AppDatabase, $CachedMoodEntriesTable> {
  $$CachedMoodEntriesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get userId => $composableBuilder(
    column: $table.userId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get mood => $composableBuilder(
    column: $table.mood,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get note => $composableBuilder(
    column: $table.note,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get recordedAt => $composableBuilder(
    column: $table.recordedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get syncedAt => $composableBuilder(
    column: $table.syncedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$CachedMoodEntriesTableOrderingComposer
    extends Composer<_$AppDatabase, $CachedMoodEntriesTable> {
  $$CachedMoodEntriesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get userId => $composableBuilder(
    column: $table.userId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get mood => $composableBuilder(
    column: $table.mood,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get note => $composableBuilder(
    column: $table.note,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get recordedAt => $composableBuilder(
    column: $table.recordedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get syncedAt => $composableBuilder(
    column: $table.syncedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$CachedMoodEntriesTableAnnotationComposer
    extends Composer<_$AppDatabase, $CachedMoodEntriesTable> {
  $$CachedMoodEntriesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get userId =>
      $composableBuilder(column: $table.userId, builder: (column) => column);

  GeneratedColumn<int> get mood =>
      $composableBuilder(column: $table.mood, builder: (column) => column);

  GeneratedColumn<String> get note =>
      $composableBuilder(column: $table.note, builder: (column) => column);

  GeneratedColumn<DateTime> get recordedAt => $composableBuilder(
    column: $table.recordedAt,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get syncedAt =>
      $composableBuilder(column: $table.syncedAt, builder: (column) => column);
}

class $$CachedMoodEntriesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $CachedMoodEntriesTable,
          CachedMoodEntry,
          $$CachedMoodEntriesTableFilterComposer,
          $$CachedMoodEntriesTableOrderingComposer,
          $$CachedMoodEntriesTableAnnotationComposer,
          $$CachedMoodEntriesTableCreateCompanionBuilder,
          $$CachedMoodEntriesTableUpdateCompanionBuilder,
          (
            CachedMoodEntry,
            BaseReferences<
              _$AppDatabase,
              $CachedMoodEntriesTable,
              CachedMoodEntry
            >,
          ),
          CachedMoodEntry,
          PrefetchHooks Function()
        > {
  $$CachedMoodEntriesTableTableManager(
    _$AppDatabase db,
    $CachedMoodEntriesTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$CachedMoodEntriesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$CachedMoodEntriesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$CachedMoodEntriesTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> userId = const Value.absent(),
                Value<int> mood = const Value.absent(),
                Value<String?> note = const Value.absent(),
                Value<DateTime> recordedAt = const Value.absent(),
                Value<DateTime> syncedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => CachedMoodEntriesCompanion(
                id: id,
                userId: userId,
                mood: mood,
                note: note,
                recordedAt: recordedAt,
                syncedAt: syncedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String userId,
                required int mood,
                Value<String?> note = const Value.absent(),
                required DateTime recordedAt,
                required DateTime syncedAt,
                Value<int> rowid = const Value.absent(),
              }) => CachedMoodEntriesCompanion.insert(
                id: id,
                userId: userId,
                mood: mood,
                note: note,
                recordedAt: recordedAt,
                syncedAt: syncedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$CachedMoodEntriesTable, CachedMoodEntry>(table),
                  BaseReferences<
                    _$AppDatabase,
                    $CachedMoodEntriesTable,
                    CachedMoodEntry
                  >(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$CachedMoodEntriesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $CachedMoodEntriesTable,
      CachedMoodEntry,
      $$CachedMoodEntriesTableFilterComposer,
      $$CachedMoodEntriesTableOrderingComposer,
      $$CachedMoodEntriesTableAnnotationComposer,
      $$CachedMoodEntriesTableCreateCompanionBuilder,
      $$CachedMoodEntriesTableUpdateCompanionBuilder,
      (
        CachedMoodEntry,
        BaseReferences<_$AppDatabase, $CachedMoodEntriesTable, CachedMoodEntry>,
      ),
      CachedMoodEntry,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$CachedProfilesTableTableManager get cachedProfiles =>
      $$CachedProfilesTableTableManager(_db, _db.cachedProfiles);
  $$CachedDailyAnswersTableTableManager get cachedDailyAnswers =>
      $$CachedDailyAnswersTableTableManager(_db, _db.cachedDailyAnswers);
  $$CachedMoodEntriesTableTableManager get cachedMoodEntries =>
      $$CachedMoodEntriesTableTableManager(_db, _db.cachedMoodEntries);
}
