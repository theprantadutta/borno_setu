import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../database/app_database.dart';
import '../../../../database/daos/history_dao.dart';
import '../../../history/data/repository_impl/history_repository_impl.dart';
import '../../../history/domain/repositories/history_repository.dart';
import '../../domain/converter/borno_converter.dart';
import '../../domain/entities/conversion_type.dart';

// --- Database providers ---

final appDatabaseProvider = Provider<AppDatabase>((ref) {
  final db = AppDatabase();
  ref.onDispose(() => db.close());
  return db;
});

final historyDaoProvider = Provider<HistoryDao>((ref) {
  return ref.watch(appDatabaseProvider).historyDao;
});

final historyRepositoryProvider = Provider<HistoryRepository>((ref) {
  return HistoryRepositoryImpl(ref.watch(historyDaoProvider));
});

// --- Converter ---

final bornoConverterProvider = Provider<BornoConverter>((ref) {
  return const BornoConverter();
});

// --- Converter state ---

class ConverterState {
  final String inputText;
  final String outputText;
  final ConversionType direction;
  final String? error;

  const ConverterState({
    this.inputText = '',
    this.outputText = '',
    this.direction = ConversionType.bijoyToUnicode,
    this.error,
  });

  ConverterState copyWith({
    String? inputText,
    String? outputText,
    ConversionType? direction,
    String? error,
  }) {
    return ConverterState(
      inputText: inputText ?? this.inputText,
      outputText: outputText ?? this.outputText,
      direction: direction ?? this.direction,
      error: error,
    );
  }
}

class ConverterNotifier extends StateNotifier<ConverterState> {
  final BornoConverter _converter;
  final HistoryRepository _historyRepository;

  ConverterNotifier(this._converter, this._historyRepository)
      : super(const ConverterState());

  void setInput(String text) {
    state = state.copyWith(inputText: text, outputText: '', error: null);
  }

  void convert() {
    if (state.inputText.isEmpty) {
      state = state.copyWith(outputText: '', error: null);
      return;
    }
    try {
      final output = _converter.convert(state.inputText, state.direction);
      state = state.copyWith(outputText: output, error: null);
    } catch (e) {
      state = state.copyWith(error: e.toString());
    }
  }

  void toggleDirection() {
    final newDirection = state.direction == ConversionType.bijoyToUnicode
        ? ConversionType.unicodeToBijoy
        : ConversionType.bijoyToUnicode;
    state = ConverterState(direction: newDirection);
  }

  void swapTexts() {
    final newDirection = state.direction == ConversionType.bijoyToUnicode
        ? ConversionType.unicodeToBijoy
        : ConversionType.bijoyToUnicode;
    state = ConverterState(
      inputText: state.outputText,
      outputText: state.inputText,
      direction: newDirection,
    );
  }

  void clear() {
    state = ConverterState(direction: state.direction);
  }

  Future<void> saveToHistory() async {
    if (state.inputText.isEmpty || state.outputText.isEmpty) return;
    await _historyRepository.insert(
      inputText: state.inputText,
      outputText: state.outputText,
      conversionType: state.direction,
    );
  }

  void loadFromHistory(String input, String output, ConversionType type) {
    state = ConverterState(
      inputText: input,
      outputText: output,
      direction: type,
    );
  }
}

final converterNotifierProvider =
    StateNotifierProvider<ConverterNotifier, ConverterState>((ref) {
  return ConverterNotifier(
    ref.watch(bornoConverterProvider),
    ref.watch(historyRepositoryProvider),
  );
});
