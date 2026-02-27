import 'package:flutter/material.dart';
import 'package:borno_setu/l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/utils/clipboard_helper.dart';
import '../../../settings/presentation/providers/text_field_expanded_provider.dart';

class TextInputCard extends ConsumerStatefulWidget {
  final TextEditingController controller;
  final String hintText;
  final VoidCallback onClear;
  final ValueChanged<String> onChanged;

  const TextInputCard({
    super.key,
    required this.controller,
    required this.hintText,
    required this.onClear,
    required this.onChanged,
  });

  @override
  ConsumerState<TextInputCard> createState() => _TextInputCardState();
}

class _TextInputCardState extends ConsumerState<TextInputCard> {
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
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: widget.controller,
              maxLines: _isExpanded ? 8 : 3,
              minLines: _isExpanded ? 4 : 2,
              decoration: InputDecoration(
                hintText: widget.hintText,
                border: InputBorder.none,
              ),
              onChanged: widget.onChanged,
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
                  onPressed: () async {
                    final text = await ClipboardHelper.paste();
                    if (text != null && text.isNotEmpty) {
                      widget.controller.text = text;
                      widget.onChanged(text);
                    }
                  },
                  icon: const Icon(Icons.paste, size: 20),
                  tooltip: l10n.pasteButton,
                ),
                IconButton(
                  onPressed: widget.onClear,
                  icon: const Icon(Icons.clear, size: 20),
                  tooltip: l10n.clearButton,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
