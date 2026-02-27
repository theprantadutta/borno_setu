// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'history_dao.dart';

// ignore_for_file: type=lint
mixin _$HistoryDaoMixin on DatabaseAccessor<AppDatabase> {
  $ConversionHistoryTableTable get conversionHistoryTable =>
      attachedDatabase.conversionHistoryTable;
  HistoryDaoManager get managers => HistoryDaoManager(this);
}

class HistoryDaoManager {
  final _$HistoryDaoMixin _db;
  HistoryDaoManager(this._db);
  $$ConversionHistoryTableTableTableManager get conversionHistoryTable =>
      $$ConversionHistoryTableTableTableManager(
        _db.attachedDatabase,
        _db.conversionHistoryTable,
      );
}
