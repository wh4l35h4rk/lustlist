// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// ignore_for_file: type=lint
class $TypesTable extends Types with TableInfo<$TypesTable, Type> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TypesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 20,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'),
  );
  static const VerificationMeta _slugMeta = const VerificationMeta('slug');
  @override
  late final GeneratedColumn<String> slug = GeneratedColumn<String>(
    'slug',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 20,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'),
  );
  @override
  List<GeneratedColumn> get $columns => [id, name, slug];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'types';
  @override
  VerificationContext validateIntegrity(
    Insertable<Type> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('slug')) {
      context.handle(
        _slugMeta,
        slug.isAcceptableOrUnknown(data['slug']!, _slugMeta),
      );
    } else if (isInserting) {
      context.missing(_slugMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Type map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Type(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      slug: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}slug'],
      )!,
    );
  }

  @override
  $TypesTable createAlias(String alias) {
    return $TypesTable(attachedDatabase, alias);
  }
}

class Type extends DataClass implements Insertable<Type> {
  final int id;
  final String name;
  final String slug;
  const Type({required this.id, required this.name, required this.slug});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    map['slug'] = Variable<String>(slug);
    return map;
  }

  TypesCompanion toCompanion(bool nullToAbsent) {
    return TypesCompanion(id: Value(id), name: Value(name), slug: Value(slug));
  }

  factory Type.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Type(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      slug: serializer.fromJson<String>(json['slug']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'slug': serializer.toJson<String>(slug),
    };
  }

  Type copyWith({int? id, String? name, String? slug}) =>
      Type(id: id ?? this.id, name: name ?? this.name, slug: slug ?? this.slug);
  Type copyWithCompanion(TypesCompanion data) {
    return Type(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      slug: data.slug.present ? data.slug.value : this.slug,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Type(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('slug: $slug')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name, slug);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Type &&
          other.id == this.id &&
          other.name == this.name &&
          other.slug == this.slug);
}

class TypesCompanion extends UpdateCompanion<Type> {
  final Value<int> id;
  final Value<String> name;
  final Value<String> slug;
  const TypesCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.slug = const Value.absent(),
  });
  TypesCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    required String slug,
  }) : name = Value(name),
       slug = Value(slug);
  static Insertable<Type> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<String>? slug,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (slug != null) 'slug': slug,
    });
  }

  TypesCompanion copyWith({
    Value<int>? id,
    Value<String>? name,
    Value<String>? slug,
  }) {
    return TypesCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      slug: slug ?? this.slug,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (slug.present) {
      map['slug'] = Variable<String>(slug.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TypesCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('slug: $slug')
          ..write(')'))
        .toString();
  }
}

class $CategoriesTable extends Categories
    with TableInfo<$CategoriesTable, Category> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CategoriesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 20,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _slugMeta = const VerificationMeta('slug');
  @override
  late final GeneratedColumn<String> slug = GeneratedColumn<String>(
    'slug',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 20,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'),
  );
  @override
  List<GeneratedColumn> get $columns => [id, name, slug];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'categories';
  @override
  VerificationContext validateIntegrity(
    Insertable<Category> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('slug')) {
      context.handle(
        _slugMeta,
        slug.isAcceptableOrUnknown(data['slug']!, _slugMeta),
      );
    } else if (isInserting) {
      context.missing(_slugMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Category map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Category(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      slug: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}slug'],
      )!,
    );
  }

  @override
  $CategoriesTable createAlias(String alias) {
    return $CategoriesTable(attachedDatabase, alias);
  }
}

class Category extends DataClass implements Insertable<Category> {
  final int id;
  final String name;
  final String slug;
  const Category({required this.id, required this.name, required this.slug});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    map['slug'] = Variable<String>(slug);
    return map;
  }

  CategoriesCompanion toCompanion(bool nullToAbsent) {
    return CategoriesCompanion(
      id: Value(id),
      name: Value(name),
      slug: Value(slug),
    );
  }

  factory Category.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Category(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      slug: serializer.fromJson<String>(json['slug']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'slug': serializer.toJson<String>(slug),
    };
  }

  Category copyWith({int? id, String? name, String? slug}) => Category(
    id: id ?? this.id,
    name: name ?? this.name,
    slug: slug ?? this.slug,
  );
  Category copyWithCompanion(CategoriesCompanion data) {
    return Category(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      slug: data.slug.present ? data.slug.value : this.slug,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Category(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('slug: $slug')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name, slug);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Category &&
          other.id == this.id &&
          other.name == this.name &&
          other.slug == this.slug);
}

class CategoriesCompanion extends UpdateCompanion<Category> {
  final Value<int> id;
  final Value<String> name;
  final Value<String> slug;
  const CategoriesCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.slug = const Value.absent(),
  });
  CategoriesCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    required String slug,
  }) : name = Value(name),
       slug = Value(slug);
  static Insertable<Category> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<String>? slug,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (slug != null) 'slug': slug,
    });
  }

  CategoriesCompanion copyWith({
    Value<int>? id,
    Value<String>? name,
    Value<String>? slug,
  }) {
    return CategoriesCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      slug: slug ?? this.slug,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (slug.present) {
      map['slug'] = Variable<String>(slug.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CategoriesCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('slug: $slug')
          ..write(')'))
        .toString();
  }
}

class $PartnersTable extends Partners with TableInfo<$PartnersTable, Partner> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PartnersTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 32,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  late final GeneratedColumnWithTypeConverter<Gender, int> gender =
      GeneratedColumn<int>(
        'gender',
        aliasedName,
        false,
        type: DriftSqlType.int,
        requiredDuringInsert: true,
      ).withConverter<Gender>($PartnersTable.$convertergender);
  static const VerificationMeta _birthdayMeta = const VerificationMeta(
    'birthday',
  );
  @override
  late final GeneratedColumn<DateTime> birthday = GeneratedColumn<DateTime>(
    'birthday',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _lastEventDateMeta = const VerificationMeta(
    'lastEventDate',
  );
  @override
  late final GeneratedColumn<DateTime> lastEventDate =
      GeneratedColumn<DateTime>(
        'last_event_date',
        aliasedName,
        false,
        type: DriftSqlType.dateTime,
        requiredDuringInsert: false,
        defaultValue: Constant(DateTime(1970, 1, 1)),
      );
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
    'notes',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    name,
    gender,
    birthday,
    createdAt,
    lastEventDate,
    notes,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'partners';
  @override
  VerificationContext validateIntegrity(
    Insertable<Partner> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('birthday')) {
      context.handle(
        _birthdayMeta,
        birthday.isAcceptableOrUnknown(data['birthday']!, _birthdayMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('last_event_date')) {
      context.handle(
        _lastEventDateMeta,
        lastEventDate.isAcceptableOrUnknown(
          data['last_event_date']!,
          _lastEventDateMeta,
        ),
      );
    }
    if (data.containsKey('notes')) {
      context.handle(
        _notesMeta,
        notes.isAcceptableOrUnknown(data['notes']!, _notesMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Partner map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Partner(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      gender: $PartnersTable.$convertergender.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.int,
          data['${effectivePrefix}gender'],
        )!,
      ),
      birthday: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}birthday'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      lastEventDate: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}last_event_date'],
      )!,
      notes: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}notes'],
      ),
    );
  }

  @override
  $PartnersTable createAlias(String alias) {
    return $PartnersTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<Gender, int, int> $convertergender =
      const EnumIndexConverter<Gender>(Gender.values);
}

class Partner extends DataClass implements Insertable<Partner> {
  final int id;
  final String name;
  final Gender gender;
  final DateTime? birthday;
  final DateTime createdAt;
  final DateTime lastEventDate;
  final String? notes;
  const Partner({
    required this.id,
    required this.name,
    required this.gender,
    this.birthday,
    required this.createdAt,
    required this.lastEventDate,
    this.notes,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    {
      map['gender'] = Variable<int>(
        $PartnersTable.$convertergender.toSql(gender),
      );
    }
    if (!nullToAbsent || birthday != null) {
      map['birthday'] = Variable<DateTime>(birthday);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    map['last_event_date'] = Variable<DateTime>(lastEventDate);
    if (!nullToAbsent || notes != null) {
      map['notes'] = Variable<String>(notes);
    }
    return map;
  }

  PartnersCompanion toCompanion(bool nullToAbsent) {
    return PartnersCompanion(
      id: Value(id),
      name: Value(name),
      gender: Value(gender),
      birthday: birthday == null && nullToAbsent
          ? const Value.absent()
          : Value(birthday),
      createdAt: Value(createdAt),
      lastEventDate: Value(lastEventDate),
      notes: notes == null && nullToAbsent
          ? const Value.absent()
          : Value(notes),
    );
  }

  factory Partner.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Partner(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      gender: $PartnersTable.$convertergender.fromJson(
        serializer.fromJson<int>(json['gender']),
      ),
      birthday: serializer.fromJson<DateTime?>(json['birthday']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      lastEventDate: serializer.fromJson<DateTime>(json['lastEventDate']),
      notes: serializer.fromJson<String?>(json['notes']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'gender': serializer.toJson<int>(
        $PartnersTable.$convertergender.toJson(gender),
      ),
      'birthday': serializer.toJson<DateTime?>(birthday),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'lastEventDate': serializer.toJson<DateTime>(lastEventDate),
      'notes': serializer.toJson<String?>(notes),
    };
  }

  Partner copyWith({
    int? id,
    String? name,
    Gender? gender,
    Value<DateTime?> birthday = const Value.absent(),
    DateTime? createdAt,
    DateTime? lastEventDate,
    Value<String?> notes = const Value.absent(),
  }) => Partner(
    id: id ?? this.id,
    name: name ?? this.name,
    gender: gender ?? this.gender,
    birthday: birthday.present ? birthday.value : this.birthday,
    createdAt: createdAt ?? this.createdAt,
    lastEventDate: lastEventDate ?? this.lastEventDate,
    notes: notes.present ? notes.value : this.notes,
  );
  Partner copyWithCompanion(PartnersCompanion data) {
    return Partner(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      gender: data.gender.present ? data.gender.value : this.gender,
      birthday: data.birthday.present ? data.birthday.value : this.birthday,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      lastEventDate: data.lastEventDate.present
          ? data.lastEventDate.value
          : this.lastEventDate,
      notes: data.notes.present ? data.notes.value : this.notes,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Partner(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('gender: $gender, ')
          ..write('birthday: $birthday, ')
          ..write('createdAt: $createdAt, ')
          ..write('lastEventDate: $lastEventDate, ')
          ..write('notes: $notes')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, name, gender, birthday, createdAt, lastEventDate, notes);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Partner &&
          other.id == this.id &&
          other.name == this.name &&
          other.gender == this.gender &&
          other.birthday == this.birthday &&
          other.createdAt == this.createdAt &&
          other.lastEventDate == this.lastEventDate &&
          other.notes == this.notes);
}

class PartnersCompanion extends UpdateCompanion<Partner> {
  final Value<int> id;
  final Value<String> name;
  final Value<Gender> gender;
  final Value<DateTime?> birthday;
  final Value<DateTime> createdAt;
  final Value<DateTime> lastEventDate;
  final Value<String?> notes;
  const PartnersCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.gender = const Value.absent(),
    this.birthday = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.lastEventDate = const Value.absent(),
    this.notes = const Value.absent(),
  });
  PartnersCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    required Gender gender,
    this.birthday = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.lastEventDate = const Value.absent(),
    this.notes = const Value.absent(),
  }) : name = Value(name),
       gender = Value(gender);
  static Insertable<Partner> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<int>? gender,
    Expression<DateTime>? birthday,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? lastEventDate,
    Expression<String>? notes,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (gender != null) 'gender': gender,
      if (birthday != null) 'birthday': birthday,
      if (createdAt != null) 'created_at': createdAt,
      if (lastEventDate != null) 'last_event_date': lastEventDate,
      if (notes != null) 'notes': notes,
    });
  }

  PartnersCompanion copyWith({
    Value<int>? id,
    Value<String>? name,
    Value<Gender>? gender,
    Value<DateTime?>? birthday,
    Value<DateTime>? createdAt,
    Value<DateTime>? lastEventDate,
    Value<String?>? notes,
  }) {
    return PartnersCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      gender: gender ?? this.gender,
      birthday: birthday ?? this.birthday,
      createdAt: createdAt ?? this.createdAt,
      lastEventDate: lastEventDate ?? this.lastEventDate,
      notes: notes ?? this.notes,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (gender.present) {
      map['gender'] = Variable<int>(
        $PartnersTable.$convertergender.toSql(gender.value),
      );
    }
    if (birthday.present) {
      map['birthday'] = Variable<DateTime>(birthday.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (lastEventDate.present) {
      map['last_event_date'] = Variable<DateTime>(lastEventDate.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PartnersCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('gender: $gender, ')
          ..write('birthday: $birthday, ')
          ..write('createdAt: $createdAt, ')
          ..write('lastEventDate: $lastEventDate, ')
          ..write('notes: $notes')
          ..write(')'))
        .toString();
  }
}

class $EventsTable extends Events with TableInfo<$EventsTable, Event> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $EventsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _typeIdMeta = const VerificationMeta('typeId');
  @override
  late final GeneratedColumn<int> typeId = GeneratedColumn<int>(
    'type_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES types (id)',
    ),
  );
  static const VerificationMeta _dateMeta = const VerificationMeta('date');
  @override
  late final GeneratedColumn<DateTime> date = GeneratedColumn<DateTime>(
    'date',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _timeMeta = const VerificationMeta('time');
  @override
  late final GeneratedColumn<DateTime> time = GeneratedColumn<DateTime>(
    'time',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: Constant(DateTime(2006, 01, 01, 12, 0, 0)),
  );
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
    'notes',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    typeId,
    date,
    time,
    notes,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'events';
  @override
  VerificationContext validateIntegrity(
    Insertable<Event> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('type_id')) {
      context.handle(
        _typeIdMeta,
        typeId.isAcceptableOrUnknown(data['type_id']!, _typeIdMeta),
      );
    } else if (isInserting) {
      context.missing(_typeIdMeta);
    }
    if (data.containsKey('date')) {
      context.handle(
        _dateMeta,
        date.isAcceptableOrUnknown(data['date']!, _dateMeta),
      );
    } else if (isInserting) {
      context.missing(_dateMeta);
    }
    if (data.containsKey('time')) {
      context.handle(
        _timeMeta,
        time.isAcceptableOrUnknown(data['time']!, _timeMeta),
      );
    }
    if (data.containsKey('notes')) {
      context.handle(
        _notesMeta,
        notes.isAcceptableOrUnknown(data['notes']!, _notesMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Event map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Event(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      typeId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}type_id'],
      )!,
      date: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}date'],
      )!,
      time: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}time'],
      )!,
      notes: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}notes'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $EventsTable createAlias(String alias) {
    return $EventsTable(attachedDatabase, alias);
  }
}

class Event extends DataClass implements Insertable<Event> {
  final int id;
  final int typeId;
  final DateTime date;
  final DateTime time;
  final String? notes;
  final DateTime createdAt;
  const Event({
    required this.id,
    required this.typeId,
    required this.date,
    required this.time,
    this.notes,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['type_id'] = Variable<int>(typeId);
    map['date'] = Variable<DateTime>(date);
    map['time'] = Variable<DateTime>(time);
    if (!nullToAbsent || notes != null) {
      map['notes'] = Variable<String>(notes);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  EventsCompanion toCompanion(bool nullToAbsent) {
    return EventsCompanion(
      id: Value(id),
      typeId: Value(typeId),
      date: Value(date),
      time: Value(time),
      notes: notes == null && nullToAbsent
          ? const Value.absent()
          : Value(notes),
      createdAt: Value(createdAt),
    );
  }

  factory Event.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Event(
      id: serializer.fromJson<int>(json['id']),
      typeId: serializer.fromJson<int>(json['typeId']),
      date: serializer.fromJson<DateTime>(json['date']),
      time: serializer.fromJson<DateTime>(json['time']),
      notes: serializer.fromJson<String?>(json['notes']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'typeId': serializer.toJson<int>(typeId),
      'date': serializer.toJson<DateTime>(date),
      'time': serializer.toJson<DateTime>(time),
      'notes': serializer.toJson<String?>(notes),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  Event copyWith({
    int? id,
    int? typeId,
    DateTime? date,
    DateTime? time,
    Value<String?> notes = const Value.absent(),
    DateTime? createdAt,
  }) => Event(
    id: id ?? this.id,
    typeId: typeId ?? this.typeId,
    date: date ?? this.date,
    time: time ?? this.time,
    notes: notes.present ? notes.value : this.notes,
    createdAt: createdAt ?? this.createdAt,
  );
  Event copyWithCompanion(EventsCompanion data) {
    return Event(
      id: data.id.present ? data.id.value : this.id,
      typeId: data.typeId.present ? data.typeId.value : this.typeId,
      date: data.date.present ? data.date.value : this.date,
      time: data.time.present ? data.time.value : this.time,
      notes: data.notes.present ? data.notes.value : this.notes,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Event(')
          ..write('id: $id, ')
          ..write('typeId: $typeId, ')
          ..write('date: $date, ')
          ..write('time: $time, ')
          ..write('notes: $notes, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, typeId, date, time, notes, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Event &&
          other.id == this.id &&
          other.typeId == this.typeId &&
          other.date == this.date &&
          other.time == this.time &&
          other.notes == this.notes &&
          other.createdAt == this.createdAt);
}

class EventsCompanion extends UpdateCompanion<Event> {
  final Value<int> id;
  final Value<int> typeId;
  final Value<DateTime> date;
  final Value<DateTime> time;
  final Value<String?> notes;
  final Value<DateTime> createdAt;
  const EventsCompanion({
    this.id = const Value.absent(),
    this.typeId = const Value.absent(),
    this.date = const Value.absent(),
    this.time = const Value.absent(),
    this.notes = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  EventsCompanion.insert({
    this.id = const Value.absent(),
    required int typeId,
    required DateTime date,
    this.time = const Value.absent(),
    this.notes = const Value.absent(),
    this.createdAt = const Value.absent(),
  }) : typeId = Value(typeId),
       date = Value(date);
  static Insertable<Event> custom({
    Expression<int>? id,
    Expression<int>? typeId,
    Expression<DateTime>? date,
    Expression<DateTime>? time,
    Expression<String>? notes,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (typeId != null) 'type_id': typeId,
      if (date != null) 'date': date,
      if (time != null) 'time': time,
      if (notes != null) 'notes': notes,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  EventsCompanion copyWith({
    Value<int>? id,
    Value<int>? typeId,
    Value<DateTime>? date,
    Value<DateTime>? time,
    Value<String?>? notes,
    Value<DateTime>? createdAt,
  }) {
    return EventsCompanion(
      id: id ?? this.id,
      typeId: typeId ?? this.typeId,
      date: date ?? this.date,
      time: time ?? this.time,
      notes: notes ?? this.notes,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (typeId.present) {
      map['type_id'] = Variable<int>(typeId.value);
    }
    if (date.present) {
      map['date'] = Variable<DateTime>(date.value);
    }
    if (time.present) {
      map['time'] = Variable<DateTime>(time.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('EventsCompanion(')
          ..write('id: $id, ')
          ..write('typeId: $typeId, ')
          ..write('date: $date, ')
          ..write('time: $time, ')
          ..write('notes: $notes, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

class $EventDataTableTable extends EventDataTable
    with TableInfo<$EventDataTableTable, EventData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $EventDataTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _eventIdMeta = const VerificationMeta(
    'eventId',
  );
  @override
  late final GeneratedColumn<int> eventId = GeneratedColumn<int>(
    'event_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES events (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _ratingMeta = const VerificationMeta('rating');
  @override
  late final GeneratedColumn<int> rating = GeneratedColumn<int>(
    'rating',
    aliasedName,
    false,
    check: () => ComparableExpr(rating).isBetweenValues(0, 5),
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _durationMeta = const VerificationMeta(
    'duration',
  );
  @override
  late final GeneratedColumn<DateTime> duration = GeneratedColumn<DateTime>(
    'duration',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _userOrgasmsMeta = const VerificationMeta(
    'userOrgasms',
  );
  @override
  late final GeneratedColumn<int> userOrgasms = GeneratedColumn<int>(
    'user_orgasms',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    $customConstraints:
        'NOT NULL DEFAULT 1 CHECK(user_orgasms BETWEEN 0 AND 25)',
    defaultValue: const CustomExpression('1'),
  );
  static const VerificationMeta _didWatchPornMeta = const VerificationMeta(
    'didWatchPorn',
  );
  @override
  late final GeneratedColumn<bool> didWatchPorn = GeneratedColumn<bool>(
    'did_watch_porn',
    aliasedName,
    true,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("did_watch_porn" IN (0, 1))',
    ),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    eventId,
    rating,
    duration,
    userOrgasms,
    didWatchPorn,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'event_data_table';
  @override
  VerificationContext validateIntegrity(
    Insertable<EventData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('event_id')) {
      context.handle(
        _eventIdMeta,
        eventId.isAcceptableOrUnknown(data['event_id']!, _eventIdMeta),
      );
    } else if (isInserting) {
      context.missing(_eventIdMeta);
    }
    if (data.containsKey('rating')) {
      context.handle(
        _ratingMeta,
        rating.isAcceptableOrUnknown(data['rating']!, _ratingMeta),
      );
    } else if (isInserting) {
      context.missing(_ratingMeta);
    }
    if (data.containsKey('duration')) {
      context.handle(
        _durationMeta,
        duration.isAcceptableOrUnknown(data['duration']!, _durationMeta),
      );
    }
    if (data.containsKey('user_orgasms')) {
      context.handle(
        _userOrgasmsMeta,
        userOrgasms.isAcceptableOrUnknown(
          data['user_orgasms']!,
          _userOrgasmsMeta,
        ),
      );
    }
    if (data.containsKey('did_watch_porn')) {
      context.handle(
        _didWatchPornMeta,
        didWatchPorn.isAcceptableOrUnknown(
          data['did_watch_porn']!,
          _didWatchPornMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  EventData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return EventData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      eventId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}event_id'],
      )!,
      rating: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}rating'],
      )!,
      duration: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}duration'],
      ),
      userOrgasms: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}user_orgasms'],
      )!,
      didWatchPorn: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}did_watch_porn'],
      ),
    );
  }

  @override
  $EventDataTableTable createAlias(String alias) {
    return $EventDataTableTable(attachedDatabase, alias);
  }
}

class EventData extends DataClass implements Insertable<EventData> {
  final int id;
  final int eventId;
  final int rating;
  final DateTime? duration;
  final int userOrgasms;
  final bool? didWatchPorn;
  const EventData({
    required this.id,
    required this.eventId,
    required this.rating,
    this.duration,
    required this.userOrgasms,
    this.didWatchPorn,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['event_id'] = Variable<int>(eventId);
    map['rating'] = Variable<int>(rating);
    if (!nullToAbsent || duration != null) {
      map['duration'] = Variable<DateTime>(duration);
    }
    map['user_orgasms'] = Variable<int>(userOrgasms);
    if (!nullToAbsent || didWatchPorn != null) {
      map['did_watch_porn'] = Variable<bool>(didWatchPorn);
    }
    return map;
  }

  EventDataTableCompanion toCompanion(bool nullToAbsent) {
    return EventDataTableCompanion(
      id: Value(id),
      eventId: Value(eventId),
      rating: Value(rating),
      duration: duration == null && nullToAbsent
          ? const Value.absent()
          : Value(duration),
      userOrgasms: Value(userOrgasms),
      didWatchPorn: didWatchPorn == null && nullToAbsent
          ? const Value.absent()
          : Value(didWatchPorn),
    );
  }

  factory EventData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return EventData(
      id: serializer.fromJson<int>(json['id']),
      eventId: serializer.fromJson<int>(json['eventId']),
      rating: serializer.fromJson<int>(json['rating']),
      duration: serializer.fromJson<DateTime?>(json['duration']),
      userOrgasms: serializer.fromJson<int>(json['userOrgasms']),
      didWatchPorn: serializer.fromJson<bool?>(json['didWatchPorn']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'eventId': serializer.toJson<int>(eventId),
      'rating': serializer.toJson<int>(rating),
      'duration': serializer.toJson<DateTime?>(duration),
      'userOrgasms': serializer.toJson<int>(userOrgasms),
      'didWatchPorn': serializer.toJson<bool?>(didWatchPorn),
    };
  }

  EventData copyWith({
    int? id,
    int? eventId,
    int? rating,
    Value<DateTime?> duration = const Value.absent(),
    int? userOrgasms,
    Value<bool?> didWatchPorn = const Value.absent(),
  }) => EventData(
    id: id ?? this.id,
    eventId: eventId ?? this.eventId,
    rating: rating ?? this.rating,
    duration: duration.present ? duration.value : this.duration,
    userOrgasms: userOrgasms ?? this.userOrgasms,
    didWatchPorn: didWatchPorn.present ? didWatchPorn.value : this.didWatchPorn,
  );
  EventData copyWithCompanion(EventDataTableCompanion data) {
    return EventData(
      id: data.id.present ? data.id.value : this.id,
      eventId: data.eventId.present ? data.eventId.value : this.eventId,
      rating: data.rating.present ? data.rating.value : this.rating,
      duration: data.duration.present ? data.duration.value : this.duration,
      userOrgasms: data.userOrgasms.present
          ? data.userOrgasms.value
          : this.userOrgasms,
      didWatchPorn: data.didWatchPorn.present
          ? data.didWatchPorn.value
          : this.didWatchPorn,
    );
  }

  @override
  String toString() {
    return (StringBuffer('EventData(')
          ..write('id: $id, ')
          ..write('eventId: $eventId, ')
          ..write('rating: $rating, ')
          ..write('duration: $duration, ')
          ..write('userOrgasms: $userOrgasms, ')
          ..write('didWatchPorn: $didWatchPorn')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, eventId, rating, duration, userOrgasms, didWatchPorn);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is EventData &&
          other.id == this.id &&
          other.eventId == this.eventId &&
          other.rating == this.rating &&
          other.duration == this.duration &&
          other.userOrgasms == this.userOrgasms &&
          other.didWatchPorn == this.didWatchPorn);
}

class EventDataTableCompanion extends UpdateCompanion<EventData> {
  final Value<int> id;
  final Value<int> eventId;
  final Value<int> rating;
  final Value<DateTime?> duration;
  final Value<int> userOrgasms;
  final Value<bool?> didWatchPorn;
  const EventDataTableCompanion({
    this.id = const Value.absent(),
    this.eventId = const Value.absent(),
    this.rating = const Value.absent(),
    this.duration = const Value.absent(),
    this.userOrgasms = const Value.absent(),
    this.didWatchPorn = const Value.absent(),
  });
  EventDataTableCompanion.insert({
    this.id = const Value.absent(),
    required int eventId,
    required int rating,
    this.duration = const Value.absent(),
    this.userOrgasms = const Value.absent(),
    this.didWatchPorn = const Value.absent(),
  }) : eventId = Value(eventId),
       rating = Value(rating);
  static Insertable<EventData> custom({
    Expression<int>? id,
    Expression<int>? eventId,
    Expression<int>? rating,
    Expression<DateTime>? duration,
    Expression<int>? userOrgasms,
    Expression<bool>? didWatchPorn,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (eventId != null) 'event_id': eventId,
      if (rating != null) 'rating': rating,
      if (duration != null) 'duration': duration,
      if (userOrgasms != null) 'user_orgasms': userOrgasms,
      if (didWatchPorn != null) 'did_watch_porn': didWatchPorn,
    });
  }

  EventDataTableCompanion copyWith({
    Value<int>? id,
    Value<int>? eventId,
    Value<int>? rating,
    Value<DateTime?>? duration,
    Value<int>? userOrgasms,
    Value<bool?>? didWatchPorn,
  }) {
    return EventDataTableCompanion(
      id: id ?? this.id,
      eventId: eventId ?? this.eventId,
      rating: rating ?? this.rating,
      duration: duration ?? this.duration,
      userOrgasms: userOrgasms ?? this.userOrgasms,
      didWatchPorn: didWatchPorn ?? this.didWatchPorn,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (eventId.present) {
      map['event_id'] = Variable<int>(eventId.value);
    }
    if (rating.present) {
      map['rating'] = Variable<int>(rating.value);
    }
    if (duration.present) {
      map['duration'] = Variable<DateTime>(duration.value);
    }
    if (userOrgasms.present) {
      map['user_orgasms'] = Variable<int>(userOrgasms.value);
    }
    if (didWatchPorn.present) {
      map['did_watch_porn'] = Variable<bool>(didWatchPorn.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('EventDataTableCompanion(')
          ..write('id: $id, ')
          ..write('eventId: $eventId, ')
          ..write('rating: $rating, ')
          ..write('duration: $duration, ')
          ..write('userOrgasms: $userOrgasms, ')
          ..write('didWatchPorn: $didWatchPorn')
          ..write(')'))
        .toString();
  }
}

class $EOptionsTable extends EOptions with TableInfo<$EOptionsTable, EOption> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $EOptionsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 40,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _slugMeta = const VerificationMeta('slug');
  @override
  late final GeneratedColumn<String> slug = GeneratedColumn<String>(
    'slug',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 40,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'),
  );
  static const VerificationMeta _categoryIdMeta = const VerificationMeta(
    'categoryId',
  );
  @override
  late final GeneratedColumn<int> categoryId = GeneratedColumn<int>(
    'category_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES categories (id)',
    ),
  );
  static const VerificationMeta _isVisibleMeta = const VerificationMeta(
    'isVisible',
  );
  @override
  late final GeneratedColumn<bool> isVisible = GeneratedColumn<bool>(
    'is_visible',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_visible" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  static const VerificationMeta _isBasicMeta = const VerificationMeta(
    'isBasic',
  );
  @override
  late final GeneratedColumn<bool> isBasic = GeneratedColumn<bool>(
    'is_basic',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_basic" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    name,
    slug,
    categoryId,
    isVisible,
    isBasic,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'e_options';
  @override
  VerificationContext validateIntegrity(
    Insertable<EOption> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('slug')) {
      context.handle(
        _slugMeta,
        slug.isAcceptableOrUnknown(data['slug']!, _slugMeta),
      );
    } else if (isInserting) {
      context.missing(_slugMeta);
    }
    if (data.containsKey('category_id')) {
      context.handle(
        _categoryIdMeta,
        categoryId.isAcceptableOrUnknown(data['category_id']!, _categoryIdMeta),
      );
    } else if (isInserting) {
      context.missing(_categoryIdMeta);
    }
    if (data.containsKey('is_visible')) {
      context.handle(
        _isVisibleMeta,
        isVisible.isAcceptableOrUnknown(data['is_visible']!, _isVisibleMeta),
      );
    }
    if (data.containsKey('is_basic')) {
      context.handle(
        _isBasicMeta,
        isBasic.isAcceptableOrUnknown(data['is_basic']!, _isBasicMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  EOption map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return EOption(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      slug: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}slug'],
      )!,
      categoryId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}category_id'],
      )!,
      isVisible: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_visible'],
      )!,
      isBasic: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_basic'],
      )!,
    );
  }

  @override
  $EOptionsTable createAlias(String alias) {
    return $EOptionsTable(attachedDatabase, alias);
  }
}

class EOption extends DataClass implements Insertable<EOption> {
  final int id;
  final String name;
  final String slug;
  final int categoryId;
  final bool isVisible;
  final bool isBasic;
  const EOption({
    required this.id,
    required this.name,
    required this.slug,
    required this.categoryId,
    required this.isVisible,
    required this.isBasic,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    map['slug'] = Variable<String>(slug);
    map['category_id'] = Variable<int>(categoryId);
    map['is_visible'] = Variable<bool>(isVisible);
    map['is_basic'] = Variable<bool>(isBasic);
    return map;
  }

  EOptionsCompanion toCompanion(bool nullToAbsent) {
    return EOptionsCompanion(
      id: Value(id),
      name: Value(name),
      slug: Value(slug),
      categoryId: Value(categoryId),
      isVisible: Value(isVisible),
      isBasic: Value(isBasic),
    );
  }

  factory EOption.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return EOption(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      slug: serializer.fromJson<String>(json['slug']),
      categoryId: serializer.fromJson<int>(json['categoryId']),
      isVisible: serializer.fromJson<bool>(json['isVisible']),
      isBasic: serializer.fromJson<bool>(json['isBasic']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'slug': serializer.toJson<String>(slug),
      'categoryId': serializer.toJson<int>(categoryId),
      'isVisible': serializer.toJson<bool>(isVisible),
      'isBasic': serializer.toJson<bool>(isBasic),
    };
  }

  EOption copyWith({
    int? id,
    String? name,
    String? slug,
    int? categoryId,
    bool? isVisible,
    bool? isBasic,
  }) => EOption(
    id: id ?? this.id,
    name: name ?? this.name,
    slug: slug ?? this.slug,
    categoryId: categoryId ?? this.categoryId,
    isVisible: isVisible ?? this.isVisible,
    isBasic: isBasic ?? this.isBasic,
  );
  EOption copyWithCompanion(EOptionsCompanion data) {
    return EOption(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      slug: data.slug.present ? data.slug.value : this.slug,
      categoryId: data.categoryId.present
          ? data.categoryId.value
          : this.categoryId,
      isVisible: data.isVisible.present ? data.isVisible.value : this.isVisible,
      isBasic: data.isBasic.present ? data.isBasic.value : this.isBasic,
    );
  }

  @override
  String toString() {
    return (StringBuffer('EOption(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('slug: $slug, ')
          ..write('categoryId: $categoryId, ')
          ..write('isVisible: $isVisible, ')
          ..write('isBasic: $isBasic')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, name, slug, categoryId, isVisible, isBasic);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is EOption &&
          other.id == this.id &&
          other.name == this.name &&
          other.slug == this.slug &&
          other.categoryId == this.categoryId &&
          other.isVisible == this.isVisible &&
          other.isBasic == this.isBasic);
}

class EOptionsCompanion extends UpdateCompanion<EOption> {
  final Value<int> id;
  final Value<String> name;
  final Value<String> slug;
  final Value<int> categoryId;
  final Value<bool> isVisible;
  final Value<bool> isBasic;
  const EOptionsCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.slug = const Value.absent(),
    this.categoryId = const Value.absent(),
    this.isVisible = const Value.absent(),
    this.isBasic = const Value.absent(),
  });
  EOptionsCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    required String slug,
    required int categoryId,
    this.isVisible = const Value.absent(),
    this.isBasic = const Value.absent(),
  }) : name = Value(name),
       slug = Value(slug),
       categoryId = Value(categoryId);
  static Insertable<EOption> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<String>? slug,
    Expression<int>? categoryId,
    Expression<bool>? isVisible,
    Expression<bool>? isBasic,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (slug != null) 'slug': slug,
      if (categoryId != null) 'category_id': categoryId,
      if (isVisible != null) 'is_visible': isVisible,
      if (isBasic != null) 'is_basic': isBasic,
    });
  }

  EOptionsCompanion copyWith({
    Value<int>? id,
    Value<String>? name,
    Value<String>? slug,
    Value<int>? categoryId,
    Value<bool>? isVisible,
    Value<bool>? isBasic,
  }) {
    return EOptionsCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      slug: slug ?? this.slug,
      categoryId: categoryId ?? this.categoryId,
      isVisible: isVisible ?? this.isVisible,
      isBasic: isBasic ?? this.isBasic,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (slug.present) {
      map['slug'] = Variable<String>(slug.value);
    }
    if (categoryId.present) {
      map['category_id'] = Variable<int>(categoryId.value);
    }
    if (isVisible.present) {
      map['is_visible'] = Variable<bool>(isVisible.value);
    }
    if (isBasic.present) {
      map['is_basic'] = Variable<bool>(isBasic.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('EOptionsCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('slug: $slug, ')
          ..write('categoryId: $categoryId, ')
          ..write('isVisible: $isVisible, ')
          ..write('isBasic: $isBasic')
          ..write(')'))
        .toString();
  }
}

class $CategoriesTypesTable extends CategoriesTypes
    with TableInfo<$CategoriesTypesTable, CategoryType> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CategoriesTypesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _categoryIdMeta = const VerificationMeta(
    'categoryId',
  );
  @override
  late final GeneratedColumn<int> categoryId = GeneratedColumn<int>(
    'category_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES categories (id)',
    ),
  );
  static const VerificationMeta _typeIdMeta = const VerificationMeta('typeId');
  @override
  late final GeneratedColumn<int> typeId = GeneratedColumn<int>(
    'type_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES types (id)',
    ),
  );
  @override
  List<GeneratedColumn> get $columns => [categoryId, typeId];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'categories_types';
  @override
  VerificationContext validateIntegrity(
    Insertable<CategoryType> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('category_id')) {
      context.handle(
        _categoryIdMeta,
        categoryId.isAcceptableOrUnknown(data['category_id']!, _categoryIdMeta),
      );
    } else if (isInserting) {
      context.missing(_categoryIdMeta);
    }
    if (data.containsKey('type_id')) {
      context.handle(
        _typeIdMeta,
        typeId.isAcceptableOrUnknown(data['type_id']!, _typeIdMeta),
      );
    } else if (isInserting) {
      context.missing(_typeIdMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {categoryId, typeId};
  @override
  CategoryType map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return CategoryType(
      categoryId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}category_id'],
      )!,
      typeId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}type_id'],
      )!,
    );
  }

  @override
  $CategoriesTypesTable createAlias(String alias) {
    return $CategoriesTypesTable(attachedDatabase, alias);
  }
}

class CategoryType extends DataClass implements Insertable<CategoryType> {
  final int categoryId;
  final int typeId;
  const CategoryType({required this.categoryId, required this.typeId});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['category_id'] = Variable<int>(categoryId);
    map['type_id'] = Variable<int>(typeId);
    return map;
  }

  CategoriesTypesCompanion toCompanion(bool nullToAbsent) {
    return CategoriesTypesCompanion(
      categoryId: Value(categoryId),
      typeId: Value(typeId),
    );
  }

  factory CategoryType.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return CategoryType(
      categoryId: serializer.fromJson<int>(json['categoryId']),
      typeId: serializer.fromJson<int>(json['typeId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'categoryId': serializer.toJson<int>(categoryId),
      'typeId': serializer.toJson<int>(typeId),
    };
  }

  CategoryType copyWith({int? categoryId, int? typeId}) => CategoryType(
    categoryId: categoryId ?? this.categoryId,
    typeId: typeId ?? this.typeId,
  );
  CategoryType copyWithCompanion(CategoriesTypesCompanion data) {
    return CategoryType(
      categoryId: data.categoryId.present
          ? data.categoryId.value
          : this.categoryId,
      typeId: data.typeId.present ? data.typeId.value : this.typeId,
    );
  }

  @override
  String toString() {
    return (StringBuffer('CategoryType(')
          ..write('categoryId: $categoryId, ')
          ..write('typeId: $typeId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(categoryId, typeId);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CategoryType &&
          other.categoryId == this.categoryId &&
          other.typeId == this.typeId);
}

class CategoriesTypesCompanion extends UpdateCompanion<CategoryType> {
  final Value<int> categoryId;
  final Value<int> typeId;
  final Value<int> rowid;
  const CategoriesTypesCompanion({
    this.categoryId = const Value.absent(),
    this.typeId = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  CategoriesTypesCompanion.insert({
    required int categoryId,
    required int typeId,
    this.rowid = const Value.absent(),
  }) : categoryId = Value(categoryId),
       typeId = Value(typeId);
  static Insertable<CategoryType> custom({
    Expression<int>? categoryId,
    Expression<int>? typeId,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (categoryId != null) 'category_id': categoryId,
      if (typeId != null) 'type_id': typeId,
      if (rowid != null) 'rowid': rowid,
    });
  }

  CategoriesTypesCompanion copyWith({
    Value<int>? categoryId,
    Value<int>? typeId,
    Value<int>? rowid,
  }) {
    return CategoriesTypesCompanion(
      categoryId: categoryId ?? this.categoryId,
      typeId: typeId ?? this.typeId,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (categoryId.present) {
      map['category_id'] = Variable<int>(categoryId.value);
    }
    if (typeId.present) {
      map['type_id'] = Variable<int>(typeId.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CategoriesTypesCompanion(')
          ..write('categoryId: $categoryId, ')
          ..write('typeId: $typeId, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $EventsOptionsTable extends EventsOptions
    with TableInfo<$EventsOptionsTable, EventOption> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $EventsOptionsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _eventIdMeta = const VerificationMeta(
    'eventId',
  );
  @override
  late final GeneratedColumn<int> eventId = GeneratedColumn<int>(
    'event_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES events (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _optionIdMeta = const VerificationMeta(
    'optionId',
  );
  @override
  late final GeneratedColumn<int> optionId = GeneratedColumn<int>(
    'option_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES e_options (id)',
    ),
  );
  @override
  late final GeneratedColumnWithTypeConverter<TestStatus?, String> testStatus =
      GeneratedColumn<String>(
        'test_status',
        aliasedName,
        true,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
      ).withConverter<TestStatus?>($EventsOptionsTable.$convertertestStatusn);
  @override
  List<GeneratedColumn> get $columns => [eventId, optionId, testStatus];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'events_options';
  @override
  VerificationContext validateIntegrity(
    Insertable<EventOption> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('event_id')) {
      context.handle(
        _eventIdMeta,
        eventId.isAcceptableOrUnknown(data['event_id']!, _eventIdMeta),
      );
    } else if (isInserting) {
      context.missing(_eventIdMeta);
    }
    if (data.containsKey('option_id')) {
      context.handle(
        _optionIdMeta,
        optionId.isAcceptableOrUnknown(data['option_id']!, _optionIdMeta),
      );
    } else if (isInserting) {
      context.missing(_optionIdMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {eventId, optionId};
  @override
  EventOption map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return EventOption(
      eventId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}event_id'],
      )!,
      optionId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}option_id'],
      )!,
      testStatus: $EventsOptionsTable.$convertertestStatusn.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}test_status'],
        ),
      ),
    );
  }

  @override
  $EventsOptionsTable createAlias(String alias) {
    return $EventsOptionsTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<TestStatus, String, String> $convertertestStatus =
      const EnumNameConverter<TestStatus>(TestStatus.values);
  static JsonTypeConverter2<TestStatus?, String?, String?>
  $convertertestStatusn = JsonTypeConverter2.asNullable($convertertestStatus);
}

class EventOption extends DataClass implements Insertable<EventOption> {
  final int eventId;
  final int optionId;
  final TestStatus? testStatus;
  const EventOption({
    required this.eventId,
    required this.optionId,
    this.testStatus,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['event_id'] = Variable<int>(eventId);
    map['option_id'] = Variable<int>(optionId);
    if (!nullToAbsent || testStatus != null) {
      map['test_status'] = Variable<String>(
        $EventsOptionsTable.$convertertestStatusn.toSql(testStatus),
      );
    }
    return map;
  }

  EventsOptionsCompanion toCompanion(bool nullToAbsent) {
    return EventsOptionsCompanion(
      eventId: Value(eventId),
      optionId: Value(optionId),
      testStatus: testStatus == null && nullToAbsent
          ? const Value.absent()
          : Value(testStatus),
    );
  }

  factory EventOption.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return EventOption(
      eventId: serializer.fromJson<int>(json['eventId']),
      optionId: serializer.fromJson<int>(json['optionId']),
      testStatus: $EventsOptionsTable.$convertertestStatusn.fromJson(
        serializer.fromJson<String?>(json['testStatus']),
      ),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'eventId': serializer.toJson<int>(eventId),
      'optionId': serializer.toJson<int>(optionId),
      'testStatus': serializer.toJson<String?>(
        $EventsOptionsTable.$convertertestStatusn.toJson(testStatus),
      ),
    };
  }

  EventOption copyWith({
    int? eventId,
    int? optionId,
    Value<TestStatus?> testStatus = const Value.absent(),
  }) => EventOption(
    eventId: eventId ?? this.eventId,
    optionId: optionId ?? this.optionId,
    testStatus: testStatus.present ? testStatus.value : this.testStatus,
  );
  EventOption copyWithCompanion(EventsOptionsCompanion data) {
    return EventOption(
      eventId: data.eventId.present ? data.eventId.value : this.eventId,
      optionId: data.optionId.present ? data.optionId.value : this.optionId,
      testStatus: data.testStatus.present
          ? data.testStatus.value
          : this.testStatus,
    );
  }

  @override
  String toString() {
    return (StringBuffer('EventOption(')
          ..write('eventId: $eventId, ')
          ..write('optionId: $optionId, ')
          ..write('testStatus: $testStatus')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(eventId, optionId, testStatus);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is EventOption &&
          other.eventId == this.eventId &&
          other.optionId == this.optionId &&
          other.testStatus == this.testStatus);
}

class EventsOptionsCompanion extends UpdateCompanion<EventOption> {
  final Value<int> eventId;
  final Value<int> optionId;
  final Value<TestStatus?> testStatus;
  final Value<int> rowid;
  const EventsOptionsCompanion({
    this.eventId = const Value.absent(),
    this.optionId = const Value.absent(),
    this.testStatus = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  EventsOptionsCompanion.insert({
    required int eventId,
    required int optionId,
    this.testStatus = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : eventId = Value(eventId),
       optionId = Value(optionId);
  static Insertable<EventOption> custom({
    Expression<int>? eventId,
    Expression<int>? optionId,
    Expression<String>? testStatus,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (eventId != null) 'event_id': eventId,
      if (optionId != null) 'option_id': optionId,
      if (testStatus != null) 'test_status': testStatus,
      if (rowid != null) 'rowid': rowid,
    });
  }

  EventsOptionsCompanion copyWith({
    Value<int>? eventId,
    Value<int>? optionId,
    Value<TestStatus?>? testStatus,
    Value<int>? rowid,
  }) {
    return EventsOptionsCompanion(
      eventId: eventId ?? this.eventId,
      optionId: optionId ?? this.optionId,
      testStatus: testStatus ?? this.testStatus,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (eventId.present) {
      map['event_id'] = Variable<int>(eventId.value);
    }
    if (optionId.present) {
      map['option_id'] = Variable<int>(optionId.value);
    }
    if (testStatus.present) {
      map['test_status'] = Variable<String>(
        $EventsOptionsTable.$convertertestStatusn.toSql(testStatus.value),
      );
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('EventsOptionsCompanion(')
          ..write('eventId: $eventId, ')
          ..write('optionId: $optionId, ')
          ..write('testStatus: $testStatus, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $EventsPartnersTable extends EventsPartners
    with TableInfo<$EventsPartnersTable, EventPartner> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $EventsPartnersTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _eventIdMeta = const VerificationMeta(
    'eventId',
  );
  @override
  late final GeneratedColumn<int> eventId = GeneratedColumn<int>(
    'event_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES events (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _partnerIdMeta = const VerificationMeta(
    'partnerId',
  );
  @override
  late final GeneratedColumn<int> partnerId = GeneratedColumn<int>(
    'partner_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES partners (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _partnerOrgasmsMeta = const VerificationMeta(
    'partnerOrgasms',
  );
  @override
  late final GeneratedColumn<int> partnerOrgasms = GeneratedColumn<int>(
    'partner_orgasms',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    $customConstraints:
        'NOT NULL DEFAULT 1 CHECK(partner_orgasms BETWEEN 0 AND 25)',
    defaultValue: const CustomExpression('1'),
  );
  @override
  List<GeneratedColumn> get $columns => [eventId, partnerId, partnerOrgasms];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'events_partners';
  @override
  VerificationContext validateIntegrity(
    Insertable<EventPartner> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('event_id')) {
      context.handle(
        _eventIdMeta,
        eventId.isAcceptableOrUnknown(data['event_id']!, _eventIdMeta),
      );
    } else if (isInserting) {
      context.missing(_eventIdMeta);
    }
    if (data.containsKey('partner_id')) {
      context.handle(
        _partnerIdMeta,
        partnerId.isAcceptableOrUnknown(data['partner_id']!, _partnerIdMeta),
      );
    } else if (isInserting) {
      context.missing(_partnerIdMeta);
    }
    if (data.containsKey('partner_orgasms')) {
      context.handle(
        _partnerOrgasmsMeta,
        partnerOrgasms.isAcceptableOrUnknown(
          data['partner_orgasms']!,
          _partnerOrgasmsMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {eventId, partnerId};
  @override
  EventPartner map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return EventPartner(
      eventId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}event_id'],
      )!,
      partnerId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}partner_id'],
      )!,
      partnerOrgasms: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}partner_orgasms'],
      )!,
    );
  }

  @override
  $EventsPartnersTable createAlias(String alias) {
    return $EventsPartnersTable(attachedDatabase, alias);
  }
}

class EventPartner extends DataClass implements Insertable<EventPartner> {
  final int eventId;
  final int partnerId;
  final int partnerOrgasms;
  const EventPartner({
    required this.eventId,
    required this.partnerId,
    required this.partnerOrgasms,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['event_id'] = Variable<int>(eventId);
    map['partner_id'] = Variable<int>(partnerId);
    map['partner_orgasms'] = Variable<int>(partnerOrgasms);
    return map;
  }

  EventsPartnersCompanion toCompanion(bool nullToAbsent) {
    return EventsPartnersCompanion(
      eventId: Value(eventId),
      partnerId: Value(partnerId),
      partnerOrgasms: Value(partnerOrgasms),
    );
  }

  factory EventPartner.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return EventPartner(
      eventId: serializer.fromJson<int>(json['eventId']),
      partnerId: serializer.fromJson<int>(json['partnerId']),
      partnerOrgasms: serializer.fromJson<int>(json['partnerOrgasms']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'eventId': serializer.toJson<int>(eventId),
      'partnerId': serializer.toJson<int>(partnerId),
      'partnerOrgasms': serializer.toJson<int>(partnerOrgasms),
    };
  }

  EventPartner copyWith({int? eventId, int? partnerId, int? partnerOrgasms}) =>
      EventPartner(
        eventId: eventId ?? this.eventId,
        partnerId: partnerId ?? this.partnerId,
        partnerOrgasms: partnerOrgasms ?? this.partnerOrgasms,
      );
  EventPartner copyWithCompanion(EventsPartnersCompanion data) {
    return EventPartner(
      eventId: data.eventId.present ? data.eventId.value : this.eventId,
      partnerId: data.partnerId.present ? data.partnerId.value : this.partnerId,
      partnerOrgasms: data.partnerOrgasms.present
          ? data.partnerOrgasms.value
          : this.partnerOrgasms,
    );
  }

  @override
  String toString() {
    return (StringBuffer('EventPartner(')
          ..write('eventId: $eventId, ')
          ..write('partnerId: $partnerId, ')
          ..write('partnerOrgasms: $partnerOrgasms')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(eventId, partnerId, partnerOrgasms);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is EventPartner &&
          other.eventId == this.eventId &&
          other.partnerId == this.partnerId &&
          other.partnerOrgasms == this.partnerOrgasms);
}

class EventsPartnersCompanion extends UpdateCompanion<EventPartner> {
  final Value<int> eventId;
  final Value<int> partnerId;
  final Value<int> partnerOrgasms;
  final Value<int> rowid;
  const EventsPartnersCompanion({
    this.eventId = const Value.absent(),
    this.partnerId = const Value.absent(),
    this.partnerOrgasms = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  EventsPartnersCompanion.insert({
    required int eventId,
    required int partnerId,
    this.partnerOrgasms = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : eventId = Value(eventId),
       partnerId = Value(partnerId);
  static Insertable<EventPartner> custom({
    Expression<int>? eventId,
    Expression<int>? partnerId,
    Expression<int>? partnerOrgasms,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (eventId != null) 'event_id': eventId,
      if (partnerId != null) 'partner_id': partnerId,
      if (partnerOrgasms != null) 'partner_orgasms': partnerOrgasms,
      if (rowid != null) 'rowid': rowid,
    });
  }

  EventsPartnersCompanion copyWith({
    Value<int>? eventId,
    Value<int>? partnerId,
    Value<int>? partnerOrgasms,
    Value<int>? rowid,
  }) {
    return EventsPartnersCompanion(
      eventId: eventId ?? this.eventId,
      partnerId: partnerId ?? this.partnerId,
      partnerOrgasms: partnerOrgasms ?? this.partnerOrgasms,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (eventId.present) {
      map['event_id'] = Variable<int>(eventId.value);
    }
    if (partnerId.present) {
      map['partner_id'] = Variable<int>(partnerId.value);
    }
    if (partnerOrgasms.present) {
      map['partner_orgasms'] = Variable<int>(partnerOrgasms.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('EventsPartnersCompanion(')
          ..write('eventId: $eventId, ')
          ..write('partnerId: $partnerId, ')
          ..write('partnerOrgasms: $partnerOrgasms, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $TypesTable types = $TypesTable(this);
  late final $CategoriesTable categories = $CategoriesTable(this);
  late final $PartnersTable partners = $PartnersTable(this);
  late final $EventsTable events = $EventsTable(this);
  late final $EventDataTableTable eventDataTable = $EventDataTableTable(this);
  late final $EOptionsTable eOptions = $EOptionsTable(this);
  late final $CategoriesTypesTable categoriesTypes = $CategoriesTypesTable(
    this,
  );
  late final $EventsOptionsTable eventsOptions = $EventsOptionsTable(this);
  late final $EventsPartnersTable eventsPartners = $EventsPartnersTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    types,
    categories,
    partners,
    events,
    eventDataTable,
    eOptions,
    categoriesTypes,
    eventsOptions,
    eventsPartners,
  ];
  @override
  StreamQueryUpdateRules get streamUpdateRules => const StreamQueryUpdateRules([
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'events',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('event_data_table', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'events',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('events_options', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'events',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('events_partners', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'partners',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('events_partners', kind: UpdateKind.delete)],
    ),
  ]);
  @override
  DriftDatabaseOptions get options =>
      const DriftDatabaseOptions(storeDateTimeAsText: true);
}

typedef $$TypesTableCreateCompanionBuilder =
    TypesCompanion Function({
      Value<int> id,
      required String name,
      required String slug,
    });
typedef $$TypesTableUpdateCompanionBuilder =
    TypesCompanion Function({
      Value<int> id,
      Value<String> name,
      Value<String> slug,
    });

final class $$TypesTableReferences
    extends BaseReferences<_$AppDatabase, $TypesTable, Type> {
  $$TypesTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$EventsTable, List<Event>> _eventsRefsTable(
    _$AppDatabase db,
  ) => MultiTypedResultKey.fromTable(
    db.events,
    aliasName: $_aliasNameGenerator(db.types.id, db.events.typeId),
  );

  $$EventsTableProcessedTableManager get eventsRefs {
    final manager = $$EventsTableTableManager(
      $_db,
      $_db.events,
    ).filter((f) => f.typeId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_eventsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$CategoriesTypesTable, List<CategoryType>>
  _categoriesTypesRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.categoriesTypes,
    aliasName: $_aliasNameGenerator(db.types.id, db.categoriesTypes.typeId),
  );

  $$CategoriesTypesTableProcessedTableManager get categoriesTypesRefs {
    final manager = $$CategoriesTypesTableTableManager(
      $_db,
      $_db.categoriesTypes,
    ).filter((f) => f.typeId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _categoriesTypesRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$TypesTableFilterComposer extends Composer<_$AppDatabase, $TypesTable> {
  $$TypesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get slug => $composableBuilder(
    column: $table.slug,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> eventsRefs(
    Expression<bool> Function($$EventsTableFilterComposer f) f,
  ) {
    final $$EventsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.events,
      getReferencedColumn: (t) => t.typeId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$EventsTableFilterComposer(
            $db: $db,
            $table: $db.events,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> categoriesTypesRefs(
    Expression<bool> Function($$CategoriesTypesTableFilterComposer f) f,
  ) {
    final $$CategoriesTypesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.categoriesTypes,
      getReferencedColumn: (t) => t.typeId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CategoriesTypesTableFilterComposer(
            $db: $db,
            $table: $db.categoriesTypes,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$TypesTableOrderingComposer
    extends Composer<_$AppDatabase, $TypesTable> {
  $$TypesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get slug => $composableBuilder(
    column: $table.slug,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$TypesTableAnnotationComposer
    extends Composer<_$AppDatabase, $TypesTable> {
  $$TypesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get slug =>
      $composableBuilder(column: $table.slug, builder: (column) => column);

  Expression<T> eventsRefs<T extends Object>(
    Expression<T> Function($$EventsTableAnnotationComposer a) f,
  ) {
    final $$EventsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.events,
      getReferencedColumn: (t) => t.typeId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$EventsTableAnnotationComposer(
            $db: $db,
            $table: $db.events,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> categoriesTypesRefs<T extends Object>(
    Expression<T> Function($$CategoriesTypesTableAnnotationComposer a) f,
  ) {
    final $$CategoriesTypesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.categoriesTypes,
      getReferencedColumn: (t) => t.typeId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CategoriesTypesTableAnnotationComposer(
            $db: $db,
            $table: $db.categoriesTypes,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$TypesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $TypesTable,
          Type,
          $$TypesTableFilterComposer,
          $$TypesTableOrderingComposer,
          $$TypesTableAnnotationComposer,
          $$TypesTableCreateCompanionBuilder,
          $$TypesTableUpdateCompanionBuilder,
          (Type, $$TypesTableReferences),
          Type,
          PrefetchHooks Function({bool eventsRefs, bool categoriesTypesRefs})
        > {
  $$TypesTableTableManager(_$AppDatabase db, $TypesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$TypesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$TypesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$TypesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String> slug = const Value.absent(),
              }) => TypesCompanion(id: id, name: name, slug: slug),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String name,
                required String slug,
              }) => TypesCompanion.insert(id: id, name: name, slug: slug),
          withReferenceMapper: (p0) => p0
              .map(
                (e) =>
                    (e.readTable(table), $$TypesTableReferences(db, table, e)),
              )
              .toList(),
          prefetchHooksCallback:
              ({eventsRefs = false, categoriesTypesRefs = false}) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (eventsRefs) db.events,
                    if (categoriesTypesRefs) db.categoriesTypes,
                  ],
                  addJoins: null,
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (eventsRefs)
                        await $_getPrefetchedData<Type, $TypesTable, Event>(
                          currentTable: table,
                          referencedTable: $$TypesTableReferences
                              ._eventsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$TypesTableReferences(db, table, p0).eventsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.typeId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (categoriesTypesRefs)
                        await $_getPrefetchedData<
                          Type,
                          $TypesTable,
                          CategoryType
                        >(
                          currentTable: table,
                          referencedTable: $$TypesTableReferences
                              ._categoriesTypesRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$TypesTableReferences(
                                db,
                                table,
                                p0,
                              ).categoriesTypesRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.typeId == item.id,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$TypesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $TypesTable,
      Type,
      $$TypesTableFilterComposer,
      $$TypesTableOrderingComposer,
      $$TypesTableAnnotationComposer,
      $$TypesTableCreateCompanionBuilder,
      $$TypesTableUpdateCompanionBuilder,
      (Type, $$TypesTableReferences),
      Type,
      PrefetchHooks Function({bool eventsRefs, bool categoriesTypesRefs})
    >;
typedef $$CategoriesTableCreateCompanionBuilder =
    CategoriesCompanion Function({
      Value<int> id,
      required String name,
      required String slug,
    });
typedef $$CategoriesTableUpdateCompanionBuilder =
    CategoriesCompanion Function({
      Value<int> id,
      Value<String> name,
      Value<String> slug,
    });

final class $$CategoriesTableReferences
    extends BaseReferences<_$AppDatabase, $CategoriesTable, Category> {
  $$CategoriesTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$EOptionsTable, List<EOption>> _eOptionsRefsTable(
    _$AppDatabase db,
  ) => MultiTypedResultKey.fromTable(
    db.eOptions,
    aliasName: $_aliasNameGenerator(db.categories.id, db.eOptions.categoryId),
  );

  $$EOptionsTableProcessedTableManager get eOptionsRefs {
    final manager = $$EOptionsTableTableManager(
      $_db,
      $_db.eOptions,
    ).filter((f) => f.categoryId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_eOptionsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$CategoriesTypesTable, List<CategoryType>>
  _categoriesTypesRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.categoriesTypes,
    aliasName: $_aliasNameGenerator(
      db.categories.id,
      db.categoriesTypes.categoryId,
    ),
  );

  $$CategoriesTypesTableProcessedTableManager get categoriesTypesRefs {
    final manager = $$CategoriesTypesTableTableManager(
      $_db,
      $_db.categoriesTypes,
    ).filter((f) => f.categoryId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _categoriesTypesRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$CategoriesTableFilterComposer
    extends Composer<_$AppDatabase, $CategoriesTable> {
  $$CategoriesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get slug => $composableBuilder(
    column: $table.slug,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> eOptionsRefs(
    Expression<bool> Function($$EOptionsTableFilterComposer f) f,
  ) {
    final $$EOptionsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.eOptions,
      getReferencedColumn: (t) => t.categoryId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$EOptionsTableFilterComposer(
            $db: $db,
            $table: $db.eOptions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> categoriesTypesRefs(
    Expression<bool> Function($$CategoriesTypesTableFilterComposer f) f,
  ) {
    final $$CategoriesTypesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.categoriesTypes,
      getReferencedColumn: (t) => t.categoryId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CategoriesTypesTableFilterComposer(
            $db: $db,
            $table: $db.categoriesTypes,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$CategoriesTableOrderingComposer
    extends Composer<_$AppDatabase, $CategoriesTable> {
  $$CategoriesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get slug => $composableBuilder(
    column: $table.slug,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$CategoriesTableAnnotationComposer
    extends Composer<_$AppDatabase, $CategoriesTable> {
  $$CategoriesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get slug =>
      $composableBuilder(column: $table.slug, builder: (column) => column);

  Expression<T> eOptionsRefs<T extends Object>(
    Expression<T> Function($$EOptionsTableAnnotationComposer a) f,
  ) {
    final $$EOptionsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.eOptions,
      getReferencedColumn: (t) => t.categoryId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$EOptionsTableAnnotationComposer(
            $db: $db,
            $table: $db.eOptions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> categoriesTypesRefs<T extends Object>(
    Expression<T> Function($$CategoriesTypesTableAnnotationComposer a) f,
  ) {
    final $$CategoriesTypesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.categoriesTypes,
      getReferencedColumn: (t) => t.categoryId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CategoriesTypesTableAnnotationComposer(
            $db: $db,
            $table: $db.categoriesTypes,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$CategoriesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $CategoriesTable,
          Category,
          $$CategoriesTableFilterComposer,
          $$CategoriesTableOrderingComposer,
          $$CategoriesTableAnnotationComposer,
          $$CategoriesTableCreateCompanionBuilder,
          $$CategoriesTableUpdateCompanionBuilder,
          (Category, $$CategoriesTableReferences),
          Category,
          PrefetchHooks Function({bool eOptionsRefs, bool categoriesTypesRefs})
        > {
  $$CategoriesTableTableManager(_$AppDatabase db, $CategoriesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$CategoriesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$CategoriesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$CategoriesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String> slug = const Value.absent(),
              }) => CategoriesCompanion(id: id, name: name, slug: slug),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String name,
                required String slug,
              }) => CategoriesCompanion.insert(id: id, name: name, slug: slug),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$CategoriesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({eOptionsRefs = false, categoriesTypesRefs = false}) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (eOptionsRefs) db.eOptions,
                    if (categoriesTypesRefs) db.categoriesTypes,
                  ],
                  addJoins: null,
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (eOptionsRefs)
                        await $_getPrefetchedData<
                          Category,
                          $CategoriesTable,
                          EOption
                        >(
                          currentTable: table,
                          referencedTable: $$CategoriesTableReferences
                              ._eOptionsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$CategoriesTableReferences(
                                db,
                                table,
                                p0,
                              ).eOptionsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.categoryId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (categoriesTypesRefs)
                        await $_getPrefetchedData<
                          Category,
                          $CategoriesTable,
                          CategoryType
                        >(
                          currentTable: table,
                          referencedTable: $$CategoriesTableReferences
                              ._categoriesTypesRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$CategoriesTableReferences(
                                db,
                                table,
                                p0,
                              ).categoriesTypesRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.categoryId == item.id,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$CategoriesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $CategoriesTable,
      Category,
      $$CategoriesTableFilterComposer,
      $$CategoriesTableOrderingComposer,
      $$CategoriesTableAnnotationComposer,
      $$CategoriesTableCreateCompanionBuilder,
      $$CategoriesTableUpdateCompanionBuilder,
      (Category, $$CategoriesTableReferences),
      Category,
      PrefetchHooks Function({bool eOptionsRefs, bool categoriesTypesRefs})
    >;
typedef $$PartnersTableCreateCompanionBuilder =
    PartnersCompanion Function({
      Value<int> id,
      required String name,
      required Gender gender,
      Value<DateTime?> birthday,
      Value<DateTime> createdAt,
      Value<DateTime> lastEventDate,
      Value<String?> notes,
    });
typedef $$PartnersTableUpdateCompanionBuilder =
    PartnersCompanion Function({
      Value<int> id,
      Value<String> name,
      Value<Gender> gender,
      Value<DateTime?> birthday,
      Value<DateTime> createdAt,
      Value<DateTime> lastEventDate,
      Value<String?> notes,
    });

final class $$PartnersTableReferences
    extends BaseReferences<_$AppDatabase, $PartnersTable, Partner> {
  $$PartnersTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$EventsPartnersTable, List<EventPartner>>
  _eventsPartnersRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.eventsPartners,
    aliasName: $_aliasNameGenerator(
      db.partners.id,
      db.eventsPartners.partnerId,
    ),
  );

  $$EventsPartnersTableProcessedTableManager get eventsPartnersRefs {
    final manager = $$EventsPartnersTableTableManager(
      $_db,
      $_db.eventsPartners,
    ).filter((f) => f.partnerId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_eventsPartnersRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$PartnersTableFilterComposer
    extends Composer<_$AppDatabase, $PartnersTable> {
  $$PartnersTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<Gender, Gender, int> get gender =>
      $composableBuilder(
        column: $table.gender,
        builder: (column) => ColumnWithTypeConverterFilters(column),
      );

  ColumnFilters<DateTime> get birthday => $composableBuilder(
    column: $table.birthday,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get lastEventDate => $composableBuilder(
    column: $table.lastEventDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> eventsPartnersRefs(
    Expression<bool> Function($$EventsPartnersTableFilterComposer f) f,
  ) {
    final $$EventsPartnersTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.eventsPartners,
      getReferencedColumn: (t) => t.partnerId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$EventsPartnersTableFilterComposer(
            $db: $db,
            $table: $db.eventsPartners,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$PartnersTableOrderingComposer
    extends Composer<_$AppDatabase, $PartnersTable> {
  $$PartnersTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get gender => $composableBuilder(
    column: $table.gender,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get birthday => $composableBuilder(
    column: $table.birthday,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get lastEventDate => $composableBuilder(
    column: $table.lastEventDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$PartnersTableAnnotationComposer
    extends Composer<_$AppDatabase, $PartnersTable> {
  $$PartnersTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumnWithTypeConverter<Gender, int> get gender =>
      $composableBuilder(column: $table.gender, builder: (column) => column);

  GeneratedColumn<DateTime> get birthday =>
      $composableBuilder(column: $table.birthday, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get lastEventDate => $composableBuilder(
    column: $table.lastEventDate,
    builder: (column) => column,
  );

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);

  Expression<T> eventsPartnersRefs<T extends Object>(
    Expression<T> Function($$EventsPartnersTableAnnotationComposer a) f,
  ) {
    final $$EventsPartnersTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.eventsPartners,
      getReferencedColumn: (t) => t.partnerId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$EventsPartnersTableAnnotationComposer(
            $db: $db,
            $table: $db.eventsPartners,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$PartnersTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $PartnersTable,
          Partner,
          $$PartnersTableFilterComposer,
          $$PartnersTableOrderingComposer,
          $$PartnersTableAnnotationComposer,
          $$PartnersTableCreateCompanionBuilder,
          $$PartnersTableUpdateCompanionBuilder,
          (Partner, $$PartnersTableReferences),
          Partner,
          PrefetchHooks Function({bool eventsPartnersRefs})
        > {
  $$PartnersTableTableManager(_$AppDatabase db, $PartnersTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PartnersTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$PartnersTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$PartnersTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<Gender> gender = const Value.absent(),
                Value<DateTime?> birthday = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> lastEventDate = const Value.absent(),
                Value<String?> notes = const Value.absent(),
              }) => PartnersCompanion(
                id: id,
                name: name,
                gender: gender,
                birthday: birthday,
                createdAt: createdAt,
                lastEventDate: lastEventDate,
                notes: notes,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String name,
                required Gender gender,
                Value<DateTime?> birthday = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> lastEventDate = const Value.absent(),
                Value<String?> notes = const Value.absent(),
              }) => PartnersCompanion.insert(
                id: id,
                name: name,
                gender: gender,
                birthday: birthday,
                createdAt: createdAt,
                lastEventDate: lastEventDate,
                notes: notes,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$PartnersTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({eventsPartnersRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (eventsPartnersRefs) db.eventsPartners,
              ],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (eventsPartnersRefs)
                    await $_getPrefetchedData<
                      Partner,
                      $PartnersTable,
                      EventPartner
                    >(
                      currentTable: table,
                      referencedTable: $$PartnersTableReferences
                          ._eventsPartnersRefsTable(db),
                      managerFromTypedResult: (p0) => $$PartnersTableReferences(
                        db,
                        table,
                        p0,
                      ).eventsPartnersRefs,
                      referencedItemsForCurrentItem: (item, referencedItems) =>
                          referencedItems.where((e) => e.partnerId == item.id),
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$PartnersTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $PartnersTable,
      Partner,
      $$PartnersTableFilterComposer,
      $$PartnersTableOrderingComposer,
      $$PartnersTableAnnotationComposer,
      $$PartnersTableCreateCompanionBuilder,
      $$PartnersTableUpdateCompanionBuilder,
      (Partner, $$PartnersTableReferences),
      Partner,
      PrefetchHooks Function({bool eventsPartnersRefs})
    >;
typedef $$EventsTableCreateCompanionBuilder =
    EventsCompanion Function({
      Value<int> id,
      required int typeId,
      required DateTime date,
      Value<DateTime> time,
      Value<String?> notes,
      Value<DateTime> createdAt,
    });
typedef $$EventsTableUpdateCompanionBuilder =
    EventsCompanion Function({
      Value<int> id,
      Value<int> typeId,
      Value<DateTime> date,
      Value<DateTime> time,
      Value<String?> notes,
      Value<DateTime> createdAt,
    });

final class $$EventsTableReferences
    extends BaseReferences<_$AppDatabase, $EventsTable, Event> {
  $$EventsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $TypesTable _typeIdTable(_$AppDatabase db) =>
      db.types.createAlias($_aliasNameGenerator(db.events.typeId, db.types.id));

  $$TypesTableProcessedTableManager get typeId {
    final $_column = $_itemColumn<int>('type_id')!;

    final manager = $$TypesTableTableManager(
      $_db,
      $_db.types,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_typeIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static MultiTypedResultKey<$EventDataTableTable, List<EventData>>
  _eventDataTableRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.eventDataTable,
    aliasName: $_aliasNameGenerator(db.events.id, db.eventDataTable.eventId),
  );

  $$EventDataTableTableProcessedTableManager get eventDataTableRefs {
    final manager = $$EventDataTableTableTableManager(
      $_db,
      $_db.eventDataTable,
    ).filter((f) => f.eventId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_eventDataTableRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$EventsOptionsTable, List<EventOption>>
  _eventsOptionsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.eventsOptions,
    aliasName: $_aliasNameGenerator(db.events.id, db.eventsOptions.eventId),
  );

  $$EventsOptionsTableProcessedTableManager get eventsOptionsRefs {
    final manager = $$EventsOptionsTableTableManager(
      $_db,
      $_db.eventsOptions,
    ).filter((f) => f.eventId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_eventsOptionsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$EventsPartnersTable, List<EventPartner>>
  _eventsPartnersRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.eventsPartners,
    aliasName: $_aliasNameGenerator(db.events.id, db.eventsPartners.eventId),
  );

  $$EventsPartnersTableProcessedTableManager get eventsPartnersRefs {
    final manager = $$EventsPartnersTableTableManager(
      $_db,
      $_db.eventsPartners,
    ).filter((f) => f.eventId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_eventsPartnersRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$EventsTableFilterComposer
    extends Composer<_$AppDatabase, $EventsTable> {
  $$EventsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get date => $composableBuilder(
    column: $table.date,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get time => $composableBuilder(
    column: $table.time,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  $$TypesTableFilterComposer get typeId {
    final $$TypesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.typeId,
      referencedTable: $db.types,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TypesTableFilterComposer(
            $db: $db,
            $table: $db.types,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<bool> eventDataTableRefs(
    Expression<bool> Function($$EventDataTableTableFilterComposer f) f,
  ) {
    final $$EventDataTableTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.eventDataTable,
      getReferencedColumn: (t) => t.eventId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$EventDataTableTableFilterComposer(
            $db: $db,
            $table: $db.eventDataTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> eventsOptionsRefs(
    Expression<bool> Function($$EventsOptionsTableFilterComposer f) f,
  ) {
    final $$EventsOptionsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.eventsOptions,
      getReferencedColumn: (t) => t.eventId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$EventsOptionsTableFilterComposer(
            $db: $db,
            $table: $db.eventsOptions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> eventsPartnersRefs(
    Expression<bool> Function($$EventsPartnersTableFilterComposer f) f,
  ) {
    final $$EventsPartnersTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.eventsPartners,
      getReferencedColumn: (t) => t.eventId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$EventsPartnersTableFilterComposer(
            $db: $db,
            $table: $db.eventsPartners,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$EventsTableOrderingComposer
    extends Composer<_$AppDatabase, $EventsTable> {
  $$EventsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get date => $composableBuilder(
    column: $table.date,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get time => $composableBuilder(
    column: $table.time,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$TypesTableOrderingComposer get typeId {
    final $$TypesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.typeId,
      referencedTable: $db.types,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TypesTableOrderingComposer(
            $db: $db,
            $table: $db.types,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$EventsTableAnnotationComposer
    extends Composer<_$AppDatabase, $EventsTable> {
  $$EventsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get date =>
      $composableBuilder(column: $table.date, builder: (column) => column);

  GeneratedColumn<DateTime> get time =>
      $composableBuilder(column: $table.time, builder: (column) => column);

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  $$TypesTableAnnotationComposer get typeId {
    final $$TypesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.typeId,
      referencedTable: $db.types,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TypesTableAnnotationComposer(
            $db: $db,
            $table: $db.types,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<T> eventDataTableRefs<T extends Object>(
    Expression<T> Function($$EventDataTableTableAnnotationComposer a) f,
  ) {
    final $$EventDataTableTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.eventDataTable,
      getReferencedColumn: (t) => t.eventId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$EventDataTableTableAnnotationComposer(
            $db: $db,
            $table: $db.eventDataTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> eventsOptionsRefs<T extends Object>(
    Expression<T> Function($$EventsOptionsTableAnnotationComposer a) f,
  ) {
    final $$EventsOptionsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.eventsOptions,
      getReferencedColumn: (t) => t.eventId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$EventsOptionsTableAnnotationComposer(
            $db: $db,
            $table: $db.eventsOptions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> eventsPartnersRefs<T extends Object>(
    Expression<T> Function($$EventsPartnersTableAnnotationComposer a) f,
  ) {
    final $$EventsPartnersTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.eventsPartners,
      getReferencedColumn: (t) => t.eventId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$EventsPartnersTableAnnotationComposer(
            $db: $db,
            $table: $db.eventsPartners,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$EventsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $EventsTable,
          Event,
          $$EventsTableFilterComposer,
          $$EventsTableOrderingComposer,
          $$EventsTableAnnotationComposer,
          $$EventsTableCreateCompanionBuilder,
          $$EventsTableUpdateCompanionBuilder,
          (Event, $$EventsTableReferences),
          Event,
          PrefetchHooks Function({
            bool typeId,
            bool eventDataTableRefs,
            bool eventsOptionsRefs,
            bool eventsPartnersRefs,
          })
        > {
  $$EventsTableTableManager(_$AppDatabase db, $EventsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$EventsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$EventsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$EventsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> typeId = const Value.absent(),
                Value<DateTime> date = const Value.absent(),
                Value<DateTime> time = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => EventsCompanion(
                id: id,
                typeId: typeId,
                date: date,
                time: time,
                notes: notes,
                createdAt: createdAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int typeId,
                required DateTime date,
                Value<DateTime> time = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => EventsCompanion.insert(
                id: id,
                typeId: typeId,
                date: date,
                time: time,
                notes: notes,
                createdAt: createdAt,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) =>
                    (e.readTable(table), $$EventsTableReferences(db, table, e)),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                typeId = false,
                eventDataTableRefs = false,
                eventsOptionsRefs = false,
                eventsPartnersRefs = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (eventDataTableRefs) db.eventDataTable,
                    if (eventsOptionsRefs) db.eventsOptions,
                    if (eventsPartnersRefs) db.eventsPartners,
                  ],
                  addJoins:
                      <
                        T extends TableManagerState<
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic
                        >
                      >(state) {
                        if (typeId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.typeId,
                                    referencedTable: $$EventsTableReferences
                                        ._typeIdTable(db),
                                    referencedColumn: $$EventsTableReferences
                                        ._typeIdTable(db)
                                        .id,
                                  )
                                  as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (eventDataTableRefs)
                        await $_getPrefetchedData<
                          Event,
                          $EventsTable,
                          EventData
                        >(
                          currentTable: table,
                          referencedTable: $$EventsTableReferences
                              ._eventDataTableRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$EventsTableReferences(
                                db,
                                table,
                                p0,
                              ).eventDataTableRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.eventId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (eventsOptionsRefs)
                        await $_getPrefetchedData<
                          Event,
                          $EventsTable,
                          EventOption
                        >(
                          currentTable: table,
                          referencedTable: $$EventsTableReferences
                              ._eventsOptionsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$EventsTableReferences(
                                db,
                                table,
                                p0,
                              ).eventsOptionsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.eventId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (eventsPartnersRefs)
                        await $_getPrefetchedData<
                          Event,
                          $EventsTable,
                          EventPartner
                        >(
                          currentTable: table,
                          referencedTable: $$EventsTableReferences
                              ._eventsPartnersRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$EventsTableReferences(
                                db,
                                table,
                                p0,
                              ).eventsPartnersRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.eventId == item.id,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$EventsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $EventsTable,
      Event,
      $$EventsTableFilterComposer,
      $$EventsTableOrderingComposer,
      $$EventsTableAnnotationComposer,
      $$EventsTableCreateCompanionBuilder,
      $$EventsTableUpdateCompanionBuilder,
      (Event, $$EventsTableReferences),
      Event,
      PrefetchHooks Function({
        bool typeId,
        bool eventDataTableRefs,
        bool eventsOptionsRefs,
        bool eventsPartnersRefs,
      })
    >;
typedef $$EventDataTableTableCreateCompanionBuilder =
    EventDataTableCompanion Function({
      Value<int> id,
      required int eventId,
      required int rating,
      Value<DateTime?> duration,
      Value<int> userOrgasms,
      Value<bool?> didWatchPorn,
    });
typedef $$EventDataTableTableUpdateCompanionBuilder =
    EventDataTableCompanion Function({
      Value<int> id,
      Value<int> eventId,
      Value<int> rating,
      Value<DateTime?> duration,
      Value<int> userOrgasms,
      Value<bool?> didWatchPorn,
    });

final class $$EventDataTableTableReferences
    extends BaseReferences<_$AppDatabase, $EventDataTableTable, EventData> {
  $$EventDataTableTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $EventsTable _eventIdTable(_$AppDatabase db) => db.events.createAlias(
    $_aliasNameGenerator(db.eventDataTable.eventId, db.events.id),
  );

  $$EventsTableProcessedTableManager get eventId {
    final $_column = $_itemColumn<int>('event_id')!;

    final manager = $$EventsTableTableManager(
      $_db,
      $_db.events,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_eventIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$EventDataTableTableFilterComposer
    extends Composer<_$AppDatabase, $EventDataTableTable> {
  $$EventDataTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get rating => $composableBuilder(
    column: $table.rating,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get duration => $composableBuilder(
    column: $table.duration,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get userOrgasms => $composableBuilder(
    column: $table.userOrgasms,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get didWatchPorn => $composableBuilder(
    column: $table.didWatchPorn,
    builder: (column) => ColumnFilters(column),
  );

  $$EventsTableFilterComposer get eventId {
    final $$EventsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.eventId,
      referencedTable: $db.events,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$EventsTableFilterComposer(
            $db: $db,
            $table: $db.events,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$EventDataTableTableOrderingComposer
    extends Composer<_$AppDatabase, $EventDataTableTable> {
  $$EventDataTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get rating => $composableBuilder(
    column: $table.rating,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get duration => $composableBuilder(
    column: $table.duration,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get userOrgasms => $composableBuilder(
    column: $table.userOrgasms,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get didWatchPorn => $composableBuilder(
    column: $table.didWatchPorn,
    builder: (column) => ColumnOrderings(column),
  );

  $$EventsTableOrderingComposer get eventId {
    final $$EventsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.eventId,
      referencedTable: $db.events,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$EventsTableOrderingComposer(
            $db: $db,
            $table: $db.events,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$EventDataTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $EventDataTableTable> {
  $$EventDataTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get rating =>
      $composableBuilder(column: $table.rating, builder: (column) => column);

  GeneratedColumn<DateTime> get duration =>
      $composableBuilder(column: $table.duration, builder: (column) => column);

  GeneratedColumn<int> get userOrgasms => $composableBuilder(
    column: $table.userOrgasms,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get didWatchPorn => $composableBuilder(
    column: $table.didWatchPorn,
    builder: (column) => column,
  );

  $$EventsTableAnnotationComposer get eventId {
    final $$EventsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.eventId,
      referencedTable: $db.events,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$EventsTableAnnotationComposer(
            $db: $db,
            $table: $db.events,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$EventDataTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $EventDataTableTable,
          EventData,
          $$EventDataTableTableFilterComposer,
          $$EventDataTableTableOrderingComposer,
          $$EventDataTableTableAnnotationComposer,
          $$EventDataTableTableCreateCompanionBuilder,
          $$EventDataTableTableUpdateCompanionBuilder,
          (EventData, $$EventDataTableTableReferences),
          EventData,
          PrefetchHooks Function({bool eventId})
        > {
  $$EventDataTableTableTableManager(
    _$AppDatabase db,
    $EventDataTableTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$EventDataTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$EventDataTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$EventDataTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> eventId = const Value.absent(),
                Value<int> rating = const Value.absent(),
                Value<DateTime?> duration = const Value.absent(),
                Value<int> userOrgasms = const Value.absent(),
                Value<bool?> didWatchPorn = const Value.absent(),
              }) => EventDataTableCompanion(
                id: id,
                eventId: eventId,
                rating: rating,
                duration: duration,
                userOrgasms: userOrgasms,
                didWatchPorn: didWatchPorn,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int eventId,
                required int rating,
                Value<DateTime?> duration = const Value.absent(),
                Value<int> userOrgasms = const Value.absent(),
                Value<bool?> didWatchPorn = const Value.absent(),
              }) => EventDataTableCompanion.insert(
                id: id,
                eventId: eventId,
                rating: rating,
                duration: duration,
                userOrgasms: userOrgasms,
                didWatchPorn: didWatchPorn,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$EventDataTableTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({eventId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (eventId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.eventId,
                                referencedTable: $$EventDataTableTableReferences
                                    ._eventIdTable(db),
                                referencedColumn:
                                    $$EventDataTableTableReferences
                                        ._eventIdTable(db)
                                        .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$EventDataTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $EventDataTableTable,
      EventData,
      $$EventDataTableTableFilterComposer,
      $$EventDataTableTableOrderingComposer,
      $$EventDataTableTableAnnotationComposer,
      $$EventDataTableTableCreateCompanionBuilder,
      $$EventDataTableTableUpdateCompanionBuilder,
      (EventData, $$EventDataTableTableReferences),
      EventData,
      PrefetchHooks Function({bool eventId})
    >;
typedef $$EOptionsTableCreateCompanionBuilder =
    EOptionsCompanion Function({
      Value<int> id,
      required String name,
      required String slug,
      required int categoryId,
      Value<bool> isVisible,
      Value<bool> isBasic,
    });
typedef $$EOptionsTableUpdateCompanionBuilder =
    EOptionsCompanion Function({
      Value<int> id,
      Value<String> name,
      Value<String> slug,
      Value<int> categoryId,
      Value<bool> isVisible,
      Value<bool> isBasic,
    });

final class $$EOptionsTableReferences
    extends BaseReferences<_$AppDatabase, $EOptionsTable, EOption> {
  $$EOptionsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $CategoriesTable _categoryIdTable(_$AppDatabase db) =>
      db.categories.createAlias(
        $_aliasNameGenerator(db.eOptions.categoryId, db.categories.id),
      );

  $$CategoriesTableProcessedTableManager get categoryId {
    final $_column = $_itemColumn<int>('category_id')!;

    final manager = $$CategoriesTableTableManager(
      $_db,
      $_db.categories,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_categoryIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static MultiTypedResultKey<$EventsOptionsTable, List<EventOption>>
  _eventsOptionsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.eventsOptions,
    aliasName: $_aliasNameGenerator(db.eOptions.id, db.eventsOptions.optionId),
  );

  $$EventsOptionsTableProcessedTableManager get eventsOptionsRefs {
    final manager = $$EventsOptionsTableTableManager(
      $_db,
      $_db.eventsOptions,
    ).filter((f) => f.optionId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_eventsOptionsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$EOptionsTableFilterComposer
    extends Composer<_$AppDatabase, $EOptionsTable> {
  $$EOptionsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get slug => $composableBuilder(
    column: $table.slug,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isVisible => $composableBuilder(
    column: $table.isVisible,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isBasic => $composableBuilder(
    column: $table.isBasic,
    builder: (column) => ColumnFilters(column),
  );

  $$CategoriesTableFilterComposer get categoryId {
    final $$CategoriesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.categoryId,
      referencedTable: $db.categories,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CategoriesTableFilterComposer(
            $db: $db,
            $table: $db.categories,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<bool> eventsOptionsRefs(
    Expression<bool> Function($$EventsOptionsTableFilterComposer f) f,
  ) {
    final $$EventsOptionsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.eventsOptions,
      getReferencedColumn: (t) => t.optionId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$EventsOptionsTableFilterComposer(
            $db: $db,
            $table: $db.eventsOptions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$EOptionsTableOrderingComposer
    extends Composer<_$AppDatabase, $EOptionsTable> {
  $$EOptionsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get slug => $composableBuilder(
    column: $table.slug,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isVisible => $composableBuilder(
    column: $table.isVisible,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isBasic => $composableBuilder(
    column: $table.isBasic,
    builder: (column) => ColumnOrderings(column),
  );

  $$CategoriesTableOrderingComposer get categoryId {
    final $$CategoriesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.categoryId,
      referencedTable: $db.categories,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CategoriesTableOrderingComposer(
            $db: $db,
            $table: $db.categories,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$EOptionsTableAnnotationComposer
    extends Composer<_$AppDatabase, $EOptionsTable> {
  $$EOptionsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get slug =>
      $composableBuilder(column: $table.slug, builder: (column) => column);

  GeneratedColumn<bool> get isVisible =>
      $composableBuilder(column: $table.isVisible, builder: (column) => column);

  GeneratedColumn<bool> get isBasic =>
      $composableBuilder(column: $table.isBasic, builder: (column) => column);

  $$CategoriesTableAnnotationComposer get categoryId {
    final $$CategoriesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.categoryId,
      referencedTable: $db.categories,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CategoriesTableAnnotationComposer(
            $db: $db,
            $table: $db.categories,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<T> eventsOptionsRefs<T extends Object>(
    Expression<T> Function($$EventsOptionsTableAnnotationComposer a) f,
  ) {
    final $$EventsOptionsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.eventsOptions,
      getReferencedColumn: (t) => t.optionId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$EventsOptionsTableAnnotationComposer(
            $db: $db,
            $table: $db.eventsOptions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$EOptionsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $EOptionsTable,
          EOption,
          $$EOptionsTableFilterComposer,
          $$EOptionsTableOrderingComposer,
          $$EOptionsTableAnnotationComposer,
          $$EOptionsTableCreateCompanionBuilder,
          $$EOptionsTableUpdateCompanionBuilder,
          (EOption, $$EOptionsTableReferences),
          EOption,
          PrefetchHooks Function({bool categoryId, bool eventsOptionsRefs})
        > {
  $$EOptionsTableTableManager(_$AppDatabase db, $EOptionsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$EOptionsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$EOptionsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$EOptionsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String> slug = const Value.absent(),
                Value<int> categoryId = const Value.absent(),
                Value<bool> isVisible = const Value.absent(),
                Value<bool> isBasic = const Value.absent(),
              }) => EOptionsCompanion(
                id: id,
                name: name,
                slug: slug,
                categoryId: categoryId,
                isVisible: isVisible,
                isBasic: isBasic,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String name,
                required String slug,
                required int categoryId,
                Value<bool> isVisible = const Value.absent(),
                Value<bool> isBasic = const Value.absent(),
              }) => EOptionsCompanion.insert(
                id: id,
                name: name,
                slug: slug,
                categoryId: categoryId,
                isVisible: isVisible,
                isBasic: isBasic,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$EOptionsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({categoryId = false, eventsOptionsRefs = false}) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (eventsOptionsRefs) db.eventsOptions,
                  ],
                  addJoins:
                      <
                        T extends TableManagerState<
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic
                        >
                      >(state) {
                        if (categoryId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.categoryId,
                                    referencedTable: $$EOptionsTableReferences
                                        ._categoryIdTable(db),
                                    referencedColumn: $$EOptionsTableReferences
                                        ._categoryIdTable(db)
                                        .id,
                                  )
                                  as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (eventsOptionsRefs)
                        await $_getPrefetchedData<
                          EOption,
                          $EOptionsTable,
                          EventOption
                        >(
                          currentTable: table,
                          referencedTable: $$EOptionsTableReferences
                              ._eventsOptionsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$EOptionsTableReferences(
                                db,
                                table,
                                p0,
                              ).eventsOptionsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.optionId == item.id,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$EOptionsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $EOptionsTable,
      EOption,
      $$EOptionsTableFilterComposer,
      $$EOptionsTableOrderingComposer,
      $$EOptionsTableAnnotationComposer,
      $$EOptionsTableCreateCompanionBuilder,
      $$EOptionsTableUpdateCompanionBuilder,
      (EOption, $$EOptionsTableReferences),
      EOption,
      PrefetchHooks Function({bool categoryId, bool eventsOptionsRefs})
    >;
typedef $$CategoriesTypesTableCreateCompanionBuilder =
    CategoriesTypesCompanion Function({
      required int categoryId,
      required int typeId,
      Value<int> rowid,
    });
typedef $$CategoriesTypesTableUpdateCompanionBuilder =
    CategoriesTypesCompanion Function({
      Value<int> categoryId,
      Value<int> typeId,
      Value<int> rowid,
    });

final class $$CategoriesTypesTableReferences
    extends BaseReferences<_$AppDatabase, $CategoriesTypesTable, CategoryType> {
  $$CategoriesTypesTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $CategoriesTable _categoryIdTable(_$AppDatabase db) =>
      db.categories.createAlias(
        $_aliasNameGenerator(db.categoriesTypes.categoryId, db.categories.id),
      );

  $$CategoriesTableProcessedTableManager get categoryId {
    final $_column = $_itemColumn<int>('category_id')!;

    final manager = $$CategoriesTableTableManager(
      $_db,
      $_db.categories,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_categoryIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $TypesTable _typeIdTable(_$AppDatabase db) => db.types.createAlias(
    $_aliasNameGenerator(db.categoriesTypes.typeId, db.types.id),
  );

  $$TypesTableProcessedTableManager get typeId {
    final $_column = $_itemColumn<int>('type_id')!;

    final manager = $$TypesTableTableManager(
      $_db,
      $_db.types,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_typeIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$CategoriesTypesTableFilterComposer
    extends Composer<_$AppDatabase, $CategoriesTypesTable> {
  $$CategoriesTypesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  $$CategoriesTableFilterComposer get categoryId {
    final $$CategoriesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.categoryId,
      referencedTable: $db.categories,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CategoriesTableFilterComposer(
            $db: $db,
            $table: $db.categories,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$TypesTableFilterComposer get typeId {
    final $$TypesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.typeId,
      referencedTable: $db.types,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TypesTableFilterComposer(
            $db: $db,
            $table: $db.types,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$CategoriesTypesTableOrderingComposer
    extends Composer<_$AppDatabase, $CategoriesTypesTable> {
  $$CategoriesTypesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  $$CategoriesTableOrderingComposer get categoryId {
    final $$CategoriesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.categoryId,
      referencedTable: $db.categories,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CategoriesTableOrderingComposer(
            $db: $db,
            $table: $db.categories,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$TypesTableOrderingComposer get typeId {
    final $$TypesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.typeId,
      referencedTable: $db.types,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TypesTableOrderingComposer(
            $db: $db,
            $table: $db.types,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$CategoriesTypesTableAnnotationComposer
    extends Composer<_$AppDatabase, $CategoriesTypesTable> {
  $$CategoriesTypesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  $$CategoriesTableAnnotationComposer get categoryId {
    final $$CategoriesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.categoryId,
      referencedTable: $db.categories,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CategoriesTableAnnotationComposer(
            $db: $db,
            $table: $db.categories,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$TypesTableAnnotationComposer get typeId {
    final $$TypesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.typeId,
      referencedTable: $db.types,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TypesTableAnnotationComposer(
            $db: $db,
            $table: $db.types,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$CategoriesTypesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $CategoriesTypesTable,
          CategoryType,
          $$CategoriesTypesTableFilterComposer,
          $$CategoriesTypesTableOrderingComposer,
          $$CategoriesTypesTableAnnotationComposer,
          $$CategoriesTypesTableCreateCompanionBuilder,
          $$CategoriesTypesTableUpdateCompanionBuilder,
          (CategoryType, $$CategoriesTypesTableReferences),
          CategoryType,
          PrefetchHooks Function({bool categoryId, bool typeId})
        > {
  $$CategoriesTypesTableTableManager(
    _$AppDatabase db,
    $CategoriesTypesTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$CategoriesTypesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$CategoriesTypesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$CategoriesTypesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> categoryId = const Value.absent(),
                Value<int> typeId = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => CategoriesTypesCompanion(
                categoryId: categoryId,
                typeId: typeId,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required int categoryId,
                required int typeId,
                Value<int> rowid = const Value.absent(),
              }) => CategoriesTypesCompanion.insert(
                categoryId: categoryId,
                typeId: typeId,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$CategoriesTypesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({categoryId = false, typeId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (categoryId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.categoryId,
                                referencedTable:
                                    $$CategoriesTypesTableReferences
                                        ._categoryIdTable(db),
                                referencedColumn:
                                    $$CategoriesTypesTableReferences
                                        ._categoryIdTable(db)
                                        .id,
                              )
                              as T;
                    }
                    if (typeId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.typeId,
                                referencedTable:
                                    $$CategoriesTypesTableReferences
                                        ._typeIdTable(db),
                                referencedColumn:
                                    $$CategoriesTypesTableReferences
                                        ._typeIdTable(db)
                                        .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$CategoriesTypesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $CategoriesTypesTable,
      CategoryType,
      $$CategoriesTypesTableFilterComposer,
      $$CategoriesTypesTableOrderingComposer,
      $$CategoriesTypesTableAnnotationComposer,
      $$CategoriesTypesTableCreateCompanionBuilder,
      $$CategoriesTypesTableUpdateCompanionBuilder,
      (CategoryType, $$CategoriesTypesTableReferences),
      CategoryType,
      PrefetchHooks Function({bool categoryId, bool typeId})
    >;
typedef $$EventsOptionsTableCreateCompanionBuilder =
    EventsOptionsCompanion Function({
      required int eventId,
      required int optionId,
      Value<TestStatus?> testStatus,
      Value<int> rowid,
    });
typedef $$EventsOptionsTableUpdateCompanionBuilder =
    EventsOptionsCompanion Function({
      Value<int> eventId,
      Value<int> optionId,
      Value<TestStatus?> testStatus,
      Value<int> rowid,
    });

final class $$EventsOptionsTableReferences
    extends BaseReferences<_$AppDatabase, $EventsOptionsTable, EventOption> {
  $$EventsOptionsTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $EventsTable _eventIdTable(_$AppDatabase db) => db.events.createAlias(
    $_aliasNameGenerator(db.eventsOptions.eventId, db.events.id),
  );

  $$EventsTableProcessedTableManager get eventId {
    final $_column = $_itemColumn<int>('event_id')!;

    final manager = $$EventsTableTableManager(
      $_db,
      $_db.events,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_eventIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $EOptionsTable _optionIdTable(_$AppDatabase db) =>
      db.eOptions.createAlias(
        $_aliasNameGenerator(db.eventsOptions.optionId, db.eOptions.id),
      );

  $$EOptionsTableProcessedTableManager get optionId {
    final $_column = $_itemColumn<int>('option_id')!;

    final manager = $$EOptionsTableTableManager(
      $_db,
      $_db.eOptions,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_optionIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$EventsOptionsTableFilterComposer
    extends Composer<_$AppDatabase, $EventsOptionsTable> {
  $$EventsOptionsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnWithTypeConverterFilters<TestStatus?, TestStatus, String>
  get testStatus => $composableBuilder(
    column: $table.testStatus,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );

  $$EventsTableFilterComposer get eventId {
    final $$EventsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.eventId,
      referencedTable: $db.events,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$EventsTableFilterComposer(
            $db: $db,
            $table: $db.events,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$EOptionsTableFilterComposer get optionId {
    final $$EOptionsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.optionId,
      referencedTable: $db.eOptions,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$EOptionsTableFilterComposer(
            $db: $db,
            $table: $db.eOptions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$EventsOptionsTableOrderingComposer
    extends Composer<_$AppDatabase, $EventsOptionsTable> {
  $$EventsOptionsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get testStatus => $composableBuilder(
    column: $table.testStatus,
    builder: (column) => ColumnOrderings(column),
  );

  $$EventsTableOrderingComposer get eventId {
    final $$EventsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.eventId,
      referencedTable: $db.events,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$EventsTableOrderingComposer(
            $db: $db,
            $table: $db.events,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$EOptionsTableOrderingComposer get optionId {
    final $$EOptionsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.optionId,
      referencedTable: $db.eOptions,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$EOptionsTableOrderingComposer(
            $db: $db,
            $table: $db.eOptions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$EventsOptionsTableAnnotationComposer
    extends Composer<_$AppDatabase, $EventsOptionsTable> {
  $$EventsOptionsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumnWithTypeConverter<TestStatus?, String> get testStatus =>
      $composableBuilder(
        column: $table.testStatus,
        builder: (column) => column,
      );

  $$EventsTableAnnotationComposer get eventId {
    final $$EventsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.eventId,
      referencedTable: $db.events,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$EventsTableAnnotationComposer(
            $db: $db,
            $table: $db.events,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$EOptionsTableAnnotationComposer get optionId {
    final $$EOptionsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.optionId,
      referencedTable: $db.eOptions,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$EOptionsTableAnnotationComposer(
            $db: $db,
            $table: $db.eOptions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$EventsOptionsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $EventsOptionsTable,
          EventOption,
          $$EventsOptionsTableFilterComposer,
          $$EventsOptionsTableOrderingComposer,
          $$EventsOptionsTableAnnotationComposer,
          $$EventsOptionsTableCreateCompanionBuilder,
          $$EventsOptionsTableUpdateCompanionBuilder,
          (EventOption, $$EventsOptionsTableReferences),
          EventOption,
          PrefetchHooks Function({bool eventId, bool optionId})
        > {
  $$EventsOptionsTableTableManager(_$AppDatabase db, $EventsOptionsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$EventsOptionsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$EventsOptionsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$EventsOptionsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> eventId = const Value.absent(),
                Value<int> optionId = const Value.absent(),
                Value<TestStatus?> testStatus = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => EventsOptionsCompanion(
                eventId: eventId,
                optionId: optionId,
                testStatus: testStatus,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required int eventId,
                required int optionId,
                Value<TestStatus?> testStatus = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => EventsOptionsCompanion.insert(
                eventId: eventId,
                optionId: optionId,
                testStatus: testStatus,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$EventsOptionsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({eventId = false, optionId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (eventId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.eventId,
                                referencedTable: $$EventsOptionsTableReferences
                                    ._eventIdTable(db),
                                referencedColumn: $$EventsOptionsTableReferences
                                    ._eventIdTable(db)
                                    .id,
                              )
                              as T;
                    }
                    if (optionId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.optionId,
                                referencedTable: $$EventsOptionsTableReferences
                                    ._optionIdTable(db),
                                referencedColumn: $$EventsOptionsTableReferences
                                    ._optionIdTable(db)
                                    .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$EventsOptionsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $EventsOptionsTable,
      EventOption,
      $$EventsOptionsTableFilterComposer,
      $$EventsOptionsTableOrderingComposer,
      $$EventsOptionsTableAnnotationComposer,
      $$EventsOptionsTableCreateCompanionBuilder,
      $$EventsOptionsTableUpdateCompanionBuilder,
      (EventOption, $$EventsOptionsTableReferences),
      EventOption,
      PrefetchHooks Function({bool eventId, bool optionId})
    >;
typedef $$EventsPartnersTableCreateCompanionBuilder =
    EventsPartnersCompanion Function({
      required int eventId,
      required int partnerId,
      Value<int> partnerOrgasms,
      Value<int> rowid,
    });
typedef $$EventsPartnersTableUpdateCompanionBuilder =
    EventsPartnersCompanion Function({
      Value<int> eventId,
      Value<int> partnerId,
      Value<int> partnerOrgasms,
      Value<int> rowid,
    });

final class $$EventsPartnersTableReferences
    extends BaseReferences<_$AppDatabase, $EventsPartnersTable, EventPartner> {
  $$EventsPartnersTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $EventsTable _eventIdTable(_$AppDatabase db) => db.events.createAlias(
    $_aliasNameGenerator(db.eventsPartners.eventId, db.events.id),
  );

  $$EventsTableProcessedTableManager get eventId {
    final $_column = $_itemColumn<int>('event_id')!;

    final manager = $$EventsTableTableManager(
      $_db,
      $_db.events,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_eventIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $PartnersTable _partnerIdTable(_$AppDatabase db) =>
      db.partners.createAlias(
        $_aliasNameGenerator(db.eventsPartners.partnerId, db.partners.id),
      );

  $$PartnersTableProcessedTableManager get partnerId {
    final $_column = $_itemColumn<int>('partner_id')!;

    final manager = $$PartnersTableTableManager(
      $_db,
      $_db.partners,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_partnerIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$EventsPartnersTableFilterComposer
    extends Composer<_$AppDatabase, $EventsPartnersTable> {
  $$EventsPartnersTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get partnerOrgasms => $composableBuilder(
    column: $table.partnerOrgasms,
    builder: (column) => ColumnFilters(column),
  );

  $$EventsTableFilterComposer get eventId {
    final $$EventsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.eventId,
      referencedTable: $db.events,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$EventsTableFilterComposer(
            $db: $db,
            $table: $db.events,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$PartnersTableFilterComposer get partnerId {
    final $$PartnersTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.partnerId,
      referencedTable: $db.partners,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PartnersTableFilterComposer(
            $db: $db,
            $table: $db.partners,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$EventsPartnersTableOrderingComposer
    extends Composer<_$AppDatabase, $EventsPartnersTable> {
  $$EventsPartnersTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get partnerOrgasms => $composableBuilder(
    column: $table.partnerOrgasms,
    builder: (column) => ColumnOrderings(column),
  );

  $$EventsTableOrderingComposer get eventId {
    final $$EventsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.eventId,
      referencedTable: $db.events,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$EventsTableOrderingComposer(
            $db: $db,
            $table: $db.events,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$PartnersTableOrderingComposer get partnerId {
    final $$PartnersTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.partnerId,
      referencedTable: $db.partners,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PartnersTableOrderingComposer(
            $db: $db,
            $table: $db.partners,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$EventsPartnersTableAnnotationComposer
    extends Composer<_$AppDatabase, $EventsPartnersTable> {
  $$EventsPartnersTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get partnerOrgasms => $composableBuilder(
    column: $table.partnerOrgasms,
    builder: (column) => column,
  );

  $$EventsTableAnnotationComposer get eventId {
    final $$EventsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.eventId,
      referencedTable: $db.events,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$EventsTableAnnotationComposer(
            $db: $db,
            $table: $db.events,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$PartnersTableAnnotationComposer get partnerId {
    final $$PartnersTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.partnerId,
      referencedTable: $db.partners,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PartnersTableAnnotationComposer(
            $db: $db,
            $table: $db.partners,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$EventsPartnersTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $EventsPartnersTable,
          EventPartner,
          $$EventsPartnersTableFilterComposer,
          $$EventsPartnersTableOrderingComposer,
          $$EventsPartnersTableAnnotationComposer,
          $$EventsPartnersTableCreateCompanionBuilder,
          $$EventsPartnersTableUpdateCompanionBuilder,
          (EventPartner, $$EventsPartnersTableReferences),
          EventPartner,
          PrefetchHooks Function({bool eventId, bool partnerId})
        > {
  $$EventsPartnersTableTableManager(
    _$AppDatabase db,
    $EventsPartnersTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$EventsPartnersTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$EventsPartnersTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$EventsPartnersTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> eventId = const Value.absent(),
                Value<int> partnerId = const Value.absent(),
                Value<int> partnerOrgasms = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => EventsPartnersCompanion(
                eventId: eventId,
                partnerId: partnerId,
                partnerOrgasms: partnerOrgasms,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required int eventId,
                required int partnerId,
                Value<int> partnerOrgasms = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => EventsPartnersCompanion.insert(
                eventId: eventId,
                partnerId: partnerId,
                partnerOrgasms: partnerOrgasms,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$EventsPartnersTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({eventId = false, partnerId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (eventId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.eventId,
                                referencedTable: $$EventsPartnersTableReferences
                                    ._eventIdTable(db),
                                referencedColumn:
                                    $$EventsPartnersTableReferences
                                        ._eventIdTable(db)
                                        .id,
                              )
                              as T;
                    }
                    if (partnerId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.partnerId,
                                referencedTable: $$EventsPartnersTableReferences
                                    ._partnerIdTable(db),
                                referencedColumn:
                                    $$EventsPartnersTableReferences
                                        ._partnerIdTable(db)
                                        .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$EventsPartnersTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $EventsPartnersTable,
      EventPartner,
      $$EventsPartnersTableFilterComposer,
      $$EventsPartnersTableOrderingComposer,
      $$EventsPartnersTableAnnotationComposer,
      $$EventsPartnersTableCreateCompanionBuilder,
      $$EventsPartnersTableUpdateCompanionBuilder,
      (EventPartner, $$EventsPartnersTableReferences),
      EventPartner,
      PrefetchHooks Function({bool eventId, bool partnerId})
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$TypesTableTableManager get types =>
      $$TypesTableTableManager(_db, _db.types);
  $$CategoriesTableTableManager get categories =>
      $$CategoriesTableTableManager(_db, _db.categories);
  $$PartnersTableTableManager get partners =>
      $$PartnersTableTableManager(_db, _db.partners);
  $$EventsTableTableManager get events =>
      $$EventsTableTableManager(_db, _db.events);
  $$EventDataTableTableTableManager get eventDataTable =>
      $$EventDataTableTableTableManager(_db, _db.eventDataTable);
  $$EOptionsTableTableManager get eOptions =>
      $$EOptionsTableTableManager(_db, _db.eOptions);
  $$CategoriesTypesTableTableManager get categoriesTypes =>
      $$CategoriesTypesTableTableManager(_db, _db.categoriesTypes);
  $$EventsOptionsTableTableManager get eventsOptions =>
      $$EventsOptionsTableTableManager(_db, _db.eventsOptions);
  $$EventsPartnersTableTableManager get eventsPartners =>
      $$EventsPartnersTableTableManager(_db, _db.eventsPartners);
}
