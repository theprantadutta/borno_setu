import 'package:flutter/material.dart';
import 'package:borno_setu/l10n/app_localizations.dart';

import '../../../../core/utils/clipboard_helper.dart';

class TextOutputCard extends StatelessWidget {
  final String text;
  final VoidCallback onSaveToHistory;

  const TextOutputCard({
    super.key,
    required this.text,
    required this.onSaveToHistory,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final colorScheme = Theme.of(context).colorScheme;

    return Card(
      color: colorScheme.surfaceContainerHighest,
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              constraints: const BoxConstraints(minHeight: 100),
              padding: const EdgeInsets.all(8),
              child: SelectableText(
                text.isEmpty ? ' ' : text,
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton.icon(
                  onPressed: text.isEmpty
                      ? null
                      : () async {
                          await ClipboardHelper.copy(text);
                          if (context.mounted) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text(l10n.copiedToClipboard)),
                            );
                          }
                        },
                  icon: const Icon(Icons.copy, size: 18),
                  label: Text(l10n.copyButton),
                ),
                const SizedBox(width: 8),
                TextButton.icon(
                  onPressed: text.isEmpty ? null : onSaveToHistory,
                  icon: const Icon(Icons.save_outlined, size: 18),
                  label: Text(l10n.saveToHistory),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
