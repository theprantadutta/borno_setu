import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../converter/presentation/providers/converter_provider.dart';
import '../../domain/entities/history_entry.dart';
import '../../domain/repositories/history_repository.dart';

final historyStreamProvider = StreamProvider<List<HistoryEntry>>((ref) {
  final repo = ref.watch(historyRepositoryProvider);
  return repo.watchAll();
});

class HistoryActionsNotifier extends StateNotifier<void> {
  final HistoryRepository _repository;

  HistoryActionsNotifier(this._repository) : super(null);

  Future<void> deleteEntry(int id) => _repository.deleteEntry(id);

  Future<void> clearAll() => _repository.clearAll();
}

final historyActionsProvider =
    StateNotifierProvider<HistoryActionsNotifier, void>((ref) {
  return HistoryActionsNotifier(ref.watch(historyRepositoryProvider));
});
