import 'package:flutter/material.dart';
import 'package:borno_setu/l10n/app_localizations.dart';

import '../../../../core/utils/clipboard_helper.dart';

class TextInputCard extends StatelessWidget {
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
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: controller,
              maxLines: 6,
              minLines: 4,
              decoration: InputDecoration(
                hintText: hintText,
                border: InputBorder.none,
              ),
              onChanged: onChanged,
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton.icon(
                  onPressed: () async {
                    final text = await ClipboardHelper.paste();
                    if (text != null && text.isNotEmpty) {
                      controller.text = text;
                      onChanged(text);
                    }
                  },
                  icon: const Icon(Icons.paste, size: 18),
                  label: Text(l10n.pasteButton),
                ),
                const SizedBox(width: 8),
                TextButton.icon(
                  onPressed: onClear,
                  icon: const Icon(Icons.clear, size: 18),
                  label: Text(l10n.clearButton),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
