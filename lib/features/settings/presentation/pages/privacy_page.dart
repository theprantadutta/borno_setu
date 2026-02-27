import 'package:flutter/material.dart';
import 'package:borno_setu/l10n/app_localizations.dart';

class PrivacyPage extends StatelessWidget {
  const PrivacyPage({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.privacyPolicy),
      ),
      body: const SingleChildScrollView(
        padding: EdgeInsets.all(24),
        child: Text(
          'Privacy Policy\n\n'
          '1. Data Collection\n'
          'BornoSetu does not collect or transmit any personal data. '
          'All text processing happens locally on your device.\n\n'
          '2. Local Storage\n'
          'Conversion history is stored locally on your device using a local '
          'database. You can clear this data at any time from the History page.\n\n'
          '3. Preferences\n'
          'Your theme and language preferences are stored locally on your device.\n\n'
          '4. Third-Party Services\n'
          'BornoSetu does not integrate with any third-party analytics, '
          'advertising, or tracking services.\n\n'
          '5. Contact\n'
          'If you have questions about this privacy policy, please contact '
          'the developer.',
        ),
      ),
    );
  }
}
