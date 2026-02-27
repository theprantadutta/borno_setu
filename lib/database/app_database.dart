import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';
import '../core/constants/app_constants.dart';
import 'daos/history_dao.dart';
import 'tables/conversion_history_table.dart';

part 'app_database.g.dart';

@DriftDatabase(tables: [ConversionHistoryTable], daos: [HistoryDao])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  static QueryExecutor _openConnection() {
    return driftDatabase(name: AppConstants.databaseName);
  }
}
