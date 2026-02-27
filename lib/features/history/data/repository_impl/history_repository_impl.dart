import '../../../../database/app_database.dart';
import '../../../../database/daos/history_dao.dart';
import '../../../converter/domain/entities/conversion_type.dart';
import '../../domain/entities/history_entry.dart';
import '../../domain/repositories/history_repository.dart';

class HistoryRepositoryImpl implements HistoryRepository {
  final HistoryDao _dao;

  HistoryRepositoryImpl(this._dao);

  @override
  Stream<List<HistoryEntry>> watchAll() {
    return _dao.watchAllEntries().map(
          (rows) => rows.map(_mapToEntity).toList(),
        );
  }

  @override
  Future<void> insert({
    required String inputText,
    required String outputText,
    required ConversionType conversionType,
  }) {
    return _dao.insertEntry(
      ConversionHistoryTableCompanion.insert(
        inputText: inputText,
        outputText: outputText,
        conversionType: conversionType.name,
      ),
    );
  }

  @override
  Future<void> deleteEntry(int id) => _dao.deleteEntry(id);

  @override
  Future<void> clearAll() => _dao.clearAll();

  HistoryEntry _mapToEntity(ConversionHistoryTableData row) {
    return HistoryEntry(
      id: row.id,
      inputText: row.inputText,
      outputText: row.outputText,
      conversionType: ConversionType.values.byName(row.conversionType),
      createdAt: row.createdAt,
    );
  }
}
