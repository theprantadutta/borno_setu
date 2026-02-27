import 'package:flutter/material.dart';
import 'package:borno_setu/l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/locale_provider.dart';

class LanguageSelectorTile extends ConsumerWidget {
  const LanguageSelectorTile({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final currentLocale = ref.watch(localeProvider);

    return ListTile(
      leading: const Icon(Icons.language),
      title: Text(l10n.language),
      trailing: DropdownButton<Locale?>(
        value: currentLocale,
        underline: const SizedBox.shrink(),
        onChanged: (locale) {
          ref.read(localeProvider.notifier).setLocale(locale);
        },
        items: const [
          DropdownMenuItem(
            value: null,
            child: Text('System'),
          ),
          DropdownMenuItem(
            value: Locale('en'),
            child: Text('English'),
          ),
          DropdownMenuItem(
            value: Locale('bn'),
            child: Text('বাংলা'),
          ),
        ],
      ),
    );
  }
}
