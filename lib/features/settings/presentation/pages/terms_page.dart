import 'package:flutter/material.dart';
import 'package:borno_setu/l10n/app_localizations.dart';

class TermsPage extends StatelessWidget {
  const TermsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.termsAndConditions),
      ),
      body: const SingleChildScrollView(
        padding: EdgeInsets.all(24),
        child: Text(
          'Terms and Conditions\n\n'
          '1. Acceptance of Terms\n'
          'By using BornoSetu, you agree to these terms and conditions.\n\n'
          '2. Use of Service\n'
          'BornoSetu is provided as a free utility for converting between '
          'Bijoy ANSI and Unicode Bangla text. The service is provided "as is" '
          'without any warranties.\n\n'
          '3. Accuracy\n'
          'While we strive for accuracy in text conversion, we cannot guarantee '
          'perfect results for all input text. Users should verify converted text '
          'for critical applications.\n\n'
          '4. Data\n'
          'All text conversion is performed locally on your device. '
          'No text data is transmitted to external servers.\n\n'
          '5. Changes\n'
          'We reserve the right to modify these terms at any time.',
        ),
      ),
    );
  }
}
