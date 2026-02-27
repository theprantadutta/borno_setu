import 'package:flutter/material.dart';
import 'package:borno_setu/l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../converter/presentation/providers/converter_provider.dart';
import '../providers/history_provider.dart';
import '../widgets/empty_history_widget.dart';
import '../widgets/history_list_tile.dart';

class HistoryPage extends ConsumerWidget {
  const HistoryPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final historyAsync = ref.watch(historyStreamProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.historyTitle),
        actions: [
          historyAsync.whenOrNull(
                data: (entries) => entries.isNotEmpty
                    ? TextButton(
                        onPressed: () => _showClearAllDialog(context, ref),
                        child: Text(l10n.clearAll),
                      )
                    : null,
              ) ??
              const SizedBox.shrink(),
        ],
      ),
      body: historyAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text(e.toString())),
        data: (entries) {
          if (entries.isEmpty) return const EmptyHistoryWidget();

          return ListView.separated(
            itemCount: entries.length,
            separatorBuilder: (_, _) => const Divider(height: 1),
            itemBuilder: (context, index) {
              final entry = entries[index];
              return HistoryListTile(
                entry: entry,
                onTap: () {
                  ref.read(converterNotifierProvider.notifier).loadFromHistory(
                        entry.inputText,
                        entry.outputText,
                        entry.conversionType,
                      );
                  context.go('/converter');
                },
                onDismissed: () {
                  ref.read(historyActionsProvider.notifier).deleteEntry(entry.id);
                },
              );
            },
          );
        },
      ),
    );
  }

  void _showClearAllDialog(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(l10n.clearAllConfirmTitle),
        content: Text(l10n.clearAllConfirmMessage),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(l10n.cancel),
          ),
          TextButton(
            onPressed: () {
              ref.read(historyActionsProvider.notifier).clearAll();
              Navigator.pop(context);
            },
            child: Text(
              l10n.delete,
              style: TextStyle(color: Theme.of(context).colorScheme.error),
            ),
          ),
        ],
      ),
    );
  }
}
