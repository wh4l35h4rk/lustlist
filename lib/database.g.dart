// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// ignore_for_file: type=lint
class $PartnerTable extends Partners with TableInfo<$PartnerTable, PartnerData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PartnerTable(this.attachedDatabase, [this._alias]);
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
      ).withConverter<Gender>($PartnerTable.$convertergender);
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
  @override
  List<GeneratedColumn> get $columns => [id, name, gender, birthday, createdAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'partner';
  @override
  VerificationContext validateIntegrity(
    Insertable<PartnerData> instance, {
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
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  PartnerData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return PartnerData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      gender: $PartnerTable.$convertergender.fromSql(
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
    );
  }

  @override
  $PartnerTable createAlias(String alias) {
    return $PartnerTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<Gender, int, int> $convertergender =
      const EnumIndexConverter<Gender>(Gender.values);
}

class PartnerData extends DataClass implements Insertable<PartnerData> {
  final int id;
  final String name;
  final Gender gender;
  final DateTime? birthday;
  final DateTime createdAt;
  const PartnerData({
    required this.id,
    required this.name,
    required this.gender,
    this.birthday,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    {
      map['gender'] = Variable<int>(
        $PartnerTable.$convertergender.toSql(gender),
      );
    }
    if (!nullToAbsent || birthday != null) {
      map['birthday'] = Variable<DateTime>(birthday);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  PartnerCompanion toCompanion(bool nullToAbsent) {
    return PartnerCompanion(
      id: Value(id),
      name: Value(name),
      gender: Value(gender),
      birthday: birthday == null && nullToAbsent
          ? const Value.absent()
          : Value(birthday),
      createdAt: Value(createdAt),
    );
  }

  factory PartnerData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return PartnerData(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      gender: $PartnerTable.$convertergender.fromJson(
        serializer.fromJson<int>(json['gender']),
      ),
      birthday: serializer.fromJson<DateTime?>(json['birthday']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'gender': serializer.toJson<int>(
        $PartnerTable.$convertergender.toJson(gender),
      ),
      'birthday': serializer.toJson<DateTime?>(birthday),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  PartnerData copyWith({
    int? id,
    String? name,
    Gender? gender,
    Value<DateTime?> birthday = const Value.absent(),
    DateTime? createdAt,
  }) => PartnerData(
    id: id ?? this.id,
    name: name ?? this.name,
    gender: gender ?? this.gender,
    birthday: birthday.present ? birthday.value : this.birthday,
    createdAt: createdAt ?? this.createdAt,
  );
  PartnerData copyWithCompanion(PartnerCompanion data) {
    return PartnerData(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      gender: data.gender.present ? data.gender.value : this.gender,
      birthday: data.birthday.present ? data.birthday.value : this.birthday,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('PartnerData(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('gender: $gender, ')
          ..write('birthday: $birthday, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name, gender, birthday, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PartnerData &&
          other.id == this.id &&
          other.name == this.name &&
          other.gender == this.gender &&
          other.birthday == this.birthday &&
          other.createdAt == this.createdAt);
}

class PartnerCompanion extends UpdateCompanion<PartnerData> {
  final Value<int> id;
  final Value<String> name;
  final Value<Gender> gender;
  final Value<DateTime?> birthday;
  final Value<DateTime> createdAt;
  const PartnerCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.gender = const Value.absent(),
    this.birthday = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  PartnerCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    required Gender gender,
    this.birthday = const Value.absent(),
    this.createdAt = const Value.absent(),
  }) : name = Value(name),
       gender = Value(gender);
  static Insertable<PartnerData> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<int>? gender,
    Expression<DateTime>? birthday,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (gender != null) 'gender': gender,
      if (birthday != null) 'birthday': birthday,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  PartnerCompanion copyWith({
    Value<int>? id,
    Value<String>? name,
    Value<Gender>? gender,
    Value<DateTime?>? birthday,
    Value<DateTime>? createdAt,
  }) {
    return PartnerCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      gender: gender ?? this.gender,
      birthday: birthday ?? this.birthday,
      createdAt: createdAt ?? this.createdAt,
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
        $PartnerTable.$convertergender.toSql(gender.value),
      );
    }
    if (birthday.present) {
      map['birthday'] = Variable<DateTime>(birthday.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PartnerCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('gender: $gender, ')
          ..write('birthday: $birthday, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $PartnerTable partner = $PartnerTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [partner];
  @override
  DriftDatabaseOptions get options =>
      const DriftDatabaseOptions(storeDateTimeAsText: true);
}

typedef $$PartnerTableCreateCompanionBuilder =
    PartnerCompanion Function({
      Value<int> id,
      required String name,
      required Gender gender,
      Value<DateTime?> birthday,
      Value<DateTime> createdAt,
    });
typedef $$PartnerTableUpdateCompanionBuilder =
    PartnerCompanion Function({
      Value<int> id,
      Value<String> name,
      Value<Gender> gender,
      Value<DateTime?> birthday,
      Value<DateTime> createdAt,
    });

class $$PartnerTableFilterComposer
    extends Composer<_$AppDatabase, $PartnerTable> {
  $$PartnerTableFilterComposer({
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
}

class $$PartnerTableOrderingComposer
    extends Composer<_$AppDatabase, $PartnerTable> {
  $$PartnerTableOrderingComposer({
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
}

class $$PartnerTableAnnotationComposer
    extends Composer<_$AppDatabase, $PartnerTable> {
  $$PartnerTableAnnotationComposer({
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
}

class $$PartnerTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $PartnerTable,
          PartnerData,
          $$PartnerTableFilterComposer,
          $$PartnerTableOrderingComposer,
          $$PartnerTableAnnotationComposer,
          $$PartnerTableCreateCompanionBuilder,
          $$PartnerTableUpdateCompanionBuilder,
          (
            PartnerData,
            BaseReferences<_$AppDatabase, $PartnerTable, PartnerData>,
          ),
          PartnerData,
          PrefetchHooks Function()
        > {
  $$PartnerTableTableManager(_$AppDatabase db, $PartnerTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PartnerTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$PartnerTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$PartnerTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<Gender> gender = const Value.absent(),
                Value<DateTime?> birthday = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => PartnerCompanion(
                id: id,
                name: name,
                gender: gender,
                birthday: birthday,
                createdAt: createdAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String name,
                required Gender gender,
                Value<DateTime?> birthday = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => PartnerCompanion.insert(
                id: id,
                name: name,
                gender: gender,
                birthday: birthday,
                createdAt: createdAt,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$PartnerTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $PartnerTable,
      PartnerData,
      $$PartnerTableFilterComposer,
      $$PartnerTableOrderingComposer,
      $$PartnerTableAnnotationComposer,
      $$PartnerTableCreateCompanionBuilder,
      $$PartnerTableUpdateCompanionBuilder,
      (PartnerData, BaseReferences<_$AppDatabase, $PartnerTable, PartnerData>),
      PartnerData,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$PartnerTableTableManager get partner =>
      $$PartnerTableTableManager(_db, _db.partner);
}
