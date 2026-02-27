import 'package:flutter/material.dart';
import 'package:borno_setu/l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:share_plus/share_plus.dart';

import '../../../../core/utils/clipboard_helper.dart';
import '../../../settings/presentation/providers/text_field_expanded_provider.dart';

class TextOutputCard extends ConsumerStatefulWidget {
  final String text;
  final VoidCallback onSaveToHistory;

  const TextOutputCard({
    super.key,
    required this.text,
    required this.onSaveToHistory,
  });

  @override
  ConsumerState<TextOutputCard> createState() => _TextOutputCardState();
}

class _TextOutputCardState extends ConsumerState<TextOutputCard> {
  late bool _isExpanded;
  bool _initialized = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_initialized) {
      _isExpanded = ref.read(textFieldExpandedProvider);
      _initialized = true;
    }
  }

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
              constraints: BoxConstraints(
                minHeight: _isExpanded ? 100 : 60,
                maxHeight: _isExpanded ? double.infinity : 100,
              ),
              padding: const EdgeInsets.all(8),
              child: SingleChildScrollView(
                physics: _isExpanded
                    ? const NeverScrollableScrollPhysics()
                    : null,
                child: SelectableText(
                  widget.text.isEmpty ? ' ' : widget.text,
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              ),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                IconButton(
                  onPressed: () => setState(() => _isExpanded = !_isExpanded),
                  icon: Icon(
                    _isExpanded ? Icons.unfold_less : Icons.unfold_more,
                    size: 20,
                  ),
                  tooltip: _isExpanded ? l10n.collapseField : l10n.expandField,
                ),
                const Spacer(),
                IconButton(
                  onPressed: widget.text.isEmpty
                      ? null
                      : () async {
                          await ClipboardHelper.copy(widget.text);
                          if (context.mounted) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                  content: Text(l10n.copiedToClipboard)),
                            );
                          }
                        },
                  icon: const Icon(Icons.copy, size: 20),
                  tooltip: l10n.copyButton,
                ),
                IconButton(
                  onPressed: widget.text.isEmpty
                      ? null
                      : () async {
                          await SharePlus.instance.share(
                            ShareParams(text: widget.text),
                          );
                        },
                  icon: const Icon(Icons.share, size: 20),
                  tooltip: l10n.shareButton,
                ),
                IconButton(
                  onPressed:
                      widget.text.isEmpty ? null : widget.onSaveToHistory,
                  icon: const Icon(Icons.save_outlined, size: 20),
                  tooltip: l10n.saveToHistory,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
