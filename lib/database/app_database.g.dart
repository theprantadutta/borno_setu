// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $ConversionHistoryTableTable extends ConversionHistoryTable
    with TableInfo<$ConversionHistoryTableTable, ConversionHistoryTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ConversionHistoryTableTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _inputTextMeta = const VerificationMeta(
    'inputText',
  );
  @override
  late final GeneratedColumn<String> inputText = GeneratedColumn<String>(
    'input_text',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _outputTextMeta = const VerificationMeta(
    'outputText',
  );
  @override
  late final GeneratedColumn<String> outputText = GeneratedColumn<String>(
    'output_text',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _conversionTypeMeta = const VerificationMeta(
    'conversionType',
  );
  @override
  late final GeneratedColumn<String> conversionType = GeneratedColumn<String>(
    'conversion_type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
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
    inputText,
    outputText,
    conversionType,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'conversion_history_table';
  @override
  VerificationContext validateIntegrity(
    Insertable<ConversionHistoryTableData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('input_text')) {
      context.handle(
        _inputTextMeta,
        inputText.isAcceptableOrUnknown(data['input_text']!, _inputTextMeta),
      );
    } else if (isInserting) {
      context.missing(_inputTextMeta);
    }
    if (data.containsKey('output_text')) {
      context.handle(
        _outputTextMeta,
        outputText.isAcceptableOrUnknown(data['output_text']!, _outputTextMeta),
      );
    } else if (isInserting) {
      context.missing(_outputTextMeta);
    }
    if (data.containsKey('conversion_type')) {
      context.handle(
        _conversionTypeMeta,
        conversionType.isAcceptableOrUnknown(
          data['conversion_type']!,
          _conversionTypeMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_conversionTypeMeta);
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
  ConversionHistoryTableData map(
    Map<String, dynamic> data, {
    String? tablePrefix,
  }) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ConversionHistoryTableData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      inputText: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}input_text'],
      )!,
      outputText: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}output_text'],
      )!,
      conversionType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}conversion_type'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $ConversionHistoryTableTable createAlias(String alias) {
    return $ConversionHistoryTableTable(attachedDatabase, alias);
  }
}

class ConversionHistoryTableData extends DataClass
    implements Insertable<ConversionHistoryTableData> {
  final int id;
  final String inputText;
  final String outputText;
  final String conversionType;
  final DateTime createdAt;
  const ConversionHistoryTableData({
    required this.id,
    required this.inputText,
    required this.outputText,
    required this.conversionType,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['input_text'] = Variable<String>(inputText);
    map['output_text'] = Variable<String>(outputText);
    map['conversion_type'] = Variable<String>(conversionType);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  ConversionHistoryTableCompanion toCompanion(bool nullToAbsent) {
    return ConversionHistoryTableCompanion(
      id: Value(id),
      inputText: Value(inputText),
      outputText: Value(outputText),
      conversionType: Value(conversionType),
      createdAt: Value(createdAt),
    );
  }

  factory ConversionHistoryTableData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ConversionHistoryTableData(
      id: serializer.fromJson<int>(json['id']),
      inputText: serializer.fromJson<String>(json['inputText']),
      outputText: serializer.fromJson<String>(json['outputText']),
      conversionType: serializer.fromJson<String>(json['conversionType']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'inputText': serializer.toJson<String>(inputText),
      'outputText': serializer.toJson<String>(outputText),
      'conversionType': serializer.toJson<String>(conversionType),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  ConversionHistoryTableData copyWith({
    int? id,
    String? inputText,
    String? outputText,
    String? conversionType,
    DateTime? createdAt,
  }) => ConversionHistoryTableData(
    id: id ?? this.id,
    inputText: inputText ?? this.inputText,
    outputText: outputText ?? this.outputText,
    conversionType: conversionType ?? this.conversionType,
    createdAt: createdAt ?? this.createdAt,
  );
  ConversionHistoryTableData copyWithCompanion(
    ConversionHistoryTableCompanion data,
  ) {
    return ConversionHistoryTableData(
      id: data.id.present ? data.id.value : this.id,
      inputText: data.inputText.present ? data.inputText.value : this.inputText,
      outputText: data.outputText.present
          ? data.outputText.value
          : this.outputText,
      conversionType: data.conversionType.present
          ? data.conversionType.value
          : this.conversionType,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ConversionHistoryTableData(')
          ..write('id: $id, ')
          ..write('inputText: $inputText, ')
          ..write('outputText: $outputText, ')
          ..write('conversionType: $conversionType, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, inputText, outputText, conversionType, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ConversionHistoryTableData &&
          other.id == this.id &&
          other.inputText == this.inputText &&
          other.outputText == this.outputText &&
          other.conversionType == this.conversionType &&
          other.createdAt == this.createdAt);
}

class ConversionHistoryTableCompanion
    extends UpdateCompanion<ConversionHistoryTableData> {
  final Value<int> id;
  final Value<String> inputText;
  final Value<String> outputText;
  final Value<String> conversionType;
  final Value<DateTime> createdAt;
  const ConversionHistoryTableCompanion({
    this.id = const Value.absent(),
    this.inputText = const Value.absent(),
    this.outputText = const Value.absent(),
    this.conversionType = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  ConversionHistoryTableCompanion.insert({
    this.id = const Value.absent(),
    required String inputText,
    required String outputText,
    required String conversionType,
    this.createdAt = const Value.absent(),
  }) : inputText = Value(inputText),
       outputText = Value(outputText),
       conversionType = Value(conversionType);
  static Insertable<ConversionHistoryTableData> custom({
    Expression<int>? id,
    Expression<String>? inputText,
    Expression<String>? outputText,
    Expression<String>? conversionType,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (inputText != null) 'input_text': inputText,
      if (outputText != null) 'output_text': outputText,
      if (conversionType != null) 'conversion_type': conversionType,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  ConversionHistoryTableCompanion copyWith({
    Value<int>? id,
    Value<String>? inputText,
    Value<String>? outputText,
    Value<String>? conversionType,
    Value<DateTime>? createdAt,
  }) {
    return ConversionHistoryTableCompanion(
      id: id ?? this.id,
      inputText: inputText ?? this.inputText,
      outputText: outputText ?? this.outputText,
      conversionType: conversionType ?? this.conversionType,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (inputText.present) {
      map['input_text'] = Variable<String>(inputText.value);
    }
    if (outputText.present) {
      map['output_text'] = Variable<String>(outputText.value);
    }
    if (conversionType.present) {
      map['conversion_type'] = Variable<String>(conversionType.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ConversionHistoryTableCompanion(')
          ..write('id: $id, ')
          ..write('inputText: $inputText, ')
          ..write('outputText: $outputText, ')
          ..write('conversionType: $conversionType, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $ConversionHistoryTableTable conversionHistoryTable =
      $ConversionHistoryTableTable(this);
  late final HistoryDao historyDao = HistoryDao(this as AppDatabase);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [conversionHistoryTable];
}

typedef $$ConversionHistoryTableTableCreateCompanionBuilder =
    ConversionHistoryTableCompanion Function({
      Value<int> id,
      required String inputText,
      required String outputText,
      required String conversionType,
      Value<DateTime> createdAt,
    });
typedef $$ConversionHistoryTableTableUpdateCompanionBuilder =
    ConversionHistoryTableCompanion Function({
      Value<int> id,
      Value<String> inputText,
      Value<String> outputText,
      Value<String> conversionType,
      Value<DateTime> createdAt,
    });

class $$ConversionHistoryTableTableFilterComposer
    extends Composer<_$AppDatabase, $ConversionHistoryTableTable> {
  $$ConversionHistoryTableTableFilterComposer({
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

  ColumnFilters<String> get inputText => $composableBuilder(
    column: $table.inputText,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get outputText => $composableBuilder(
    column: $table.outputText,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get conversionType => $composableBuilder(
    column: $table.conversionType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$ConversionHistoryTableTableOrderingComposer
    extends Composer<_$AppDatabase, $ConversionHistoryTableTable> {
  $$ConversionHistoryTableTableOrderingComposer({
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

  ColumnOrderings<String> get inputText => $composableBuilder(
    column: $table.inputText,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get outputText => $composableBuilder(
    column: $table.outputText,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get conversionType => $composableBuilder(
    column: $table.conversionType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$ConversionHistoryTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $ConversionHistoryTableTable> {
  $$ConversionHistoryTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get inputText =>
      $composableBuilder(column: $table.inputText, builder: (column) => column);

  GeneratedColumn<String> get outputText => $composableBuilder(
    column: $table.outputText,
    builder: (column) => column,
  );

  GeneratedColumn<String> get conversionType => $composableBuilder(
    column: $table.conversionType,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);
}

class $$ConversionHistoryTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ConversionHistoryTableTable,
          ConversionHistoryTableData,
          $$ConversionHistoryTableTableFilterComposer,
          $$ConversionHistoryTableTableOrderingComposer,
          $$ConversionHistoryTableTableAnnotationComposer,
          $$ConversionHistoryTableTableCreateCompanionBuilder,
          $$ConversionHistoryTableTableUpdateCompanionBuilder,
          (
            ConversionHistoryTableData,
            BaseReferences<
              _$AppDatabase,
              $ConversionHistoryTableTable,
              ConversionHistoryTableData
            >,
          ),
          ConversionHistoryTableData,
          PrefetchHooks Function()
        > {
  $$ConversionHistoryTableTableTableManager(
    _$AppDatabase db,
    $ConversionHistoryTableTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ConversionHistoryTableTableFilterComposer(
                $db: db,
                $table: table,
              ),
          createOrderingComposer: () =>
              $$ConversionHistoryTableTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              $$ConversionHistoryTableTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> inputText = const Value.absent(),
                Value<String> outputText = const Value.absent(),
                Value<String> conversionType = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => ConversionHistoryTableCompanion(
                id: id,
                inputText: inputText,
                outputText: outputText,
                conversionType: conversionType,
                createdAt: createdAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String inputText,
                required String outputText,
                required String conversionType,
                Value<DateTime> createdAt = const Value.absent(),
              }) => ConversionHistoryTableCompanion.insert(
                id: id,
                inputText: inputText,
                outputText: outputText,
                conversionType: conversionType,
                createdAt: createdAt,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$ConversionHistoryTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ConversionHistoryTableTable,
      ConversionHistoryTableData,
      $$ConversionHistoryTableTableFilterComposer,
      $$ConversionHistoryTableTableOrderingComposer,
      $$ConversionHistoryTableTableAnnotationComposer,
      $$ConversionHistoryTableTableCreateCompanionBuilder,
      $$ConversionHistoryTableTableUpdateCompanionBuilder,
      (
        ConversionHistoryTableData,
        BaseReferences<
          _$AppDatabase,
          $ConversionHistoryTableTable,
          ConversionHistoryTableData
        >,
      ),
      ConversionHistoryTableData,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$ConversionHistoryTableTableTableManager get conversionHistoryTable =>
      $$ConversionHistoryTableTableTableManager(
        _db,
        _db.conversionHistoryTable,
      );
}
