// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'BornoSetu';

  @override
  String get converterTab => 'Converter';

  @override
  String get historyTab => 'History';

  @override
  String get settingsTab => 'Settings';

  @override
  String get bijoyToUnicode => 'Bijoy → Unicode';

  @override
  String get unicodeToBijoy => 'Unicode → Bijoy';

  @override
  String get inputHintBijoy => 'Paste your Bijoy text here...';

  @override
  String get inputHintUnicode => 'Paste your Unicode Bangla text here...';

  @override
  String get convertButton => 'Convert';

  @override
  String get copyButton => 'Copy';

  @override
  String get shareButton => 'Share';

  @override
  String get pasteButton => 'Paste';

  @override
  String get clearButton => 'Clear';

  @override
  String get swapButton => 'Swap';

  @override
  String get saveToHistory => 'Save to History';

  @override
  String get copiedToClipboard => 'Copied to clipboard';

  @override
  String get savedToHistory => 'Saved to history';

  @override
  String get historyTitle => 'History';

  @override
  String get clearAll => 'Clear All';

  @override
  String get clearAllConfirmTitle => 'Clear All History?';

  @override
  String get clearAllConfirmMessage => 'This action cannot be undone.';

  @override
  String get cancel => 'Cancel';

  @override
  String get delete => 'Delete';

  @override
  String get noHistory => 'No conversions yet';

  @override
  String get noHistorySubtitle => 'Your conversion history will appear here';

  @override
  String timeAgo(String time) {
    return '$time ago';
  }

  @override
  String get settingsTitle => 'Settings';

  @override
  String get theme => 'Theme';

  @override
  String get themeLight => 'Light';

  @override
  String get themeDark => 'Dark';

  @override
  String get themeSystem => 'System';

  @override
  String get language => 'Language';

  @override
  String get aboutApp => 'About BornoSetu';

  @override
  String get termsAndConditions => 'Terms & Conditions';

  @override
  String get privacyPolicy => 'Privacy Policy';

  @override
  String version(String version) {
    return 'Version $version';
  }

  @override
  String get aboutDescription =>
      'BornoSetu is a Bangla typing utility that converts between Bijoy ANSI and Unicode Bangla text.';

  @override
  String get keepTextFieldsExpanded => 'Keep text fields expanded';

  @override
  String get expandField => 'Expand';

  @override
  String get collapseField => 'Collapse';
}
