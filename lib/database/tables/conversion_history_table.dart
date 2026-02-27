import 'package:drift/drift.dart';

class ConversionHistoryTable extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get inputText => text()();
  TextColumn get outputText => text()();
  TextColumn get conversionType => text()();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
}
