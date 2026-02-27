import 'package:flutter/material.dart';
import 'package:borno_setu/l10n/app_localizations.dart';

import '../../../converter/domain/entities/conversion_type.dart';
import '../../domain/entities/history_entry.dart';

class HistoryListTile extends StatelessWidget {
  final HistoryEntry entry;
  final VoidCallback onTap;
  final VoidCallback onDismissed;

  const HistoryListTile({
    super.key,
    required this.entry,
    required this.onTap,
    required this.onDismissed,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final directionLabel = entry.conversionType == ConversionType.bijoyToUnicode
        ? l10n.bijoyToUnicode
        : l10n.unicodeToBijoy;
    final timeAgo = _formatTimeAgo(entry.createdAt, l10n);

    return Dismissible(
      key: ValueKey(entry.id),
      direction: DismissDirection.endToStart,
      onDismissed: (_) => onDismissed(),
      background: Container(
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 16),
        color: Theme.of(context).colorScheme.error,
        child: Icon(
          Icons.delete,
          color: Theme.of(context).colorScheme.onError,
        ),
      ),
      child: ListTile(
        title: Text(
          entry.outputText,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        subtitle: Text('$directionLabel  $timeAgo'),
        onTap: onTap,
        trailing: const Icon(Icons.chevron_right),
      ),
    );
  }

  String _formatTimeAgo(DateTime dateTime, AppLocalizations l10n) {
    final now = DateTime.now();
    final diff = now.difference(dateTime);

    if (diff.inSeconds < 60) return l10n.timeAgo('${diff.inSeconds}s');
    if (diff.inMinutes < 60) return l10n.timeAgo('${diff.inMinutes}m');
    if (diff.inHours < 24) return l10n.timeAgo('${diff.inHours}h');
    if (diff.inDays < 30) return l10n.timeAgo('${diff.inDays}d');
    return l10n.timeAgo('${(diff.inDays / 30).floor()}mo');
  }
}
