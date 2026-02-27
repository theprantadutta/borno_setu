import 'package:flutter/material.dart';
import 'package:borno_setu/l10n/app_localizations.dart';

import '../../domain/entities/conversion_type.dart';

class ConversionToggle extends StatelessWidget {
  final ConversionType selected;
  final ValueChanged<ConversionType> onChanged;

  const ConversionToggle({
    super.key,
    required this.selected,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return SegmentedButton<ConversionType>(
      segments: [
        ButtonSegment(
          value: ConversionType.bijoyToUnicode,
          label: Text(l10n.bijoyToUnicode),
        ),
        ButtonSegment(
          value: ConversionType.unicodeToBijoy,
          label: Text(l10n.unicodeToBijoy),
        ),
      ],
      selected: {selected},
      onSelectionChanged: (set) => onChanged(set.first),
    );
  }
}
