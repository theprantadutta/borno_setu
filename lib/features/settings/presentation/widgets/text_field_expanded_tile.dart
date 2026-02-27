import 'package:flutter/material.dart';
import 'package:borno_setu/l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/text_field_expanded_provider.dart';

class TextFieldExpandedTile extends ConsumerWidget {
  const TextFieldExpandedTile({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final isExpanded = ref.watch(textFieldExpandedProvider);

    return SwitchListTile(
      secondary: const Icon(Icons.expand_outlined),
      title: Text(l10n.keepTextFieldsExpanded),
      value: isExpanded,
      onChanged: (_) {
        ref.read(textFieldExpandedProvider.notifier).toggle();
      },
    );
  }
}
