import '../../../converter/domain/entities/conversion_type.dart';
import '../entities/history_entry.dart';

abstract class HistoryRepository {
  Stream<List<HistoryEntry>> watchAll();
  Future<void> insert({
    required String inputText,
    required String outputText,
    required ConversionType conversionType,
  });
  Future<void> deleteEntry(int id);
  Future<void> clearAll();
}
