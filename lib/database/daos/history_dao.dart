import 'package:drift/drift.dart';
import '../app_database.dart';
import '../tables/conversion_history_table.dart';

part 'history_dao.g.dart';

@DriftAccessor(tables: [ConversionHistoryTable])
class HistoryDao extends DatabaseAccessor<AppDatabase> with _$HistoryDaoMixin {
  HistoryDao(super.db);

  Stream<List<ConversionHistoryTableData>> watchAllEntries() {
    return (select(conversionHistoryTable)
          ..orderBy([
            (t) => OrderingTerm.desc(t.createdAt),
          ]))
        .watch();
  }

  Future<List<ConversionHistoryTableData>> getAllEntries() {
    return (select(conversionHistoryTable)
          ..orderBy([
            (t) => OrderingTerm.desc(t.createdAt),
          ]))
        .get();
  }

  Future<int> insertEntry(ConversionHistoryTableCompanion entry) {
    return into(conversionHistoryTable).insert(entry);
  }

  Future<int> deleteEntry(int id) {
    return (delete(conversionHistoryTable)..where((t) => t.id.equals(id)))
        .go();
  }

  Future<int> clearAll() {
    return delete(conversionHistoryTable).go();
  }
}
