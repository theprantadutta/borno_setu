import '../../../converter/domain/entities/conversion_type.dart';

class HistoryEntry {
  final int id;
  final String inputText;
  final String outputText;
  final ConversionType conversionType;
  final DateTime createdAt;

  const HistoryEntry({
    required this.id,
    required this.inputText,
    required this.outputText,
    required this.conversionType,
    required this.createdAt,
  });
}
