// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Bengali Bangla (`bn`).
class AppLocalizationsBn extends AppLocalizations {
  AppLocalizationsBn([String locale = 'bn']) : super(locale);

  @override
  String get appTitle => 'বর্ণসেতু';

  @override
  String get converterTab => 'রূপান্তর';

  @override
  String get historyTab => 'ইতিহাস';

  @override
  String get settingsTab => 'সেটিংস';

  @override
  String get bijoyToUnicode => 'বিজয় → ইউনিকোড';

  @override
  String get unicodeToBijoy => 'ইউনিকোড → বিজয়';

  @override
  String get inputHintBijoy => 'এখানে বিজয় টেক্সট পেস্ট করুন...';

  @override
  String get inputHintUnicode => 'এখানে ইউনিকোড বাংলা টেক্সট পেস্ট করুন...';

  @override
  String get convertButton => 'রূপান্তর করুন';

  @override
  String get copyButton => 'কপি';

  @override
  String get shareButton => 'শেয়ার';

  @override
  String get pasteButton => 'পেস্ট';

  @override
  String get clearButton => 'মুছুন';

  @override
  String get swapButton => 'বিনিময়';

  @override
  String get saveToHistory => 'ইতিহাসে সংরক্ষণ';

  @override
  String get copiedToClipboard => 'ক্লিপবোর্ডে কপি হয়েছে';

  @override
  String get savedToHistory => 'ইতিহাসে সংরক্ষিত হয়েছে';

  @override
  String get historyTitle => 'ইতিহাস';

  @override
  String get clearAll => 'সব মুছুন';

  @override
  String get clearAllConfirmTitle => 'সমস্ত ইতিহাস মুছবেন?';

  @override
  String get clearAllConfirmMessage => 'এই কাজটি পূর্বাবস্থায় ফেরানো যাবে না।';

  @override
  String get cancel => 'বাতিল';

  @override
  String get delete => 'মুছুন';

  @override
  String get noHistory => 'এখনও কোনো রূপান্তর হয়নি';

  @override
  String get noHistorySubtitle => 'আপনার রূপান্তর ইতিহাস এখানে দেখা যাবে';

  @override
  String timeAgo(String time) {
    return '$time আগে';
  }

  @override
  String get settingsTitle => 'সেটিংস';

  @override
  String get theme => 'থিম';

  @override
  String get themeLight => 'লাইট';

  @override
  String get themeDark => 'ডার্ক';

  @override
  String get themeSystem => 'সিস্টেম';

  @override
  String get language => 'ভাষা';

  @override
  String get aboutApp => 'বর্ণসেতু সম্পর্কে';

  @override
  String get termsAndConditions => 'শর্তাবলী';

  @override
  String get privacyPolicy => 'গোপনীয়তা নীতি';

  @override
  String version(String version) {
    return 'সংস্করণ $version';
  }

  @override
  String get aboutDescription =>
      'বর্ণসেতু একটি বাংলা টাইপিং ইউটিলিটি যা বিজয় ANSI এবং ইউনিকোড বাংলা টেক্সটের মধ্যে রূপান্তর করে।';
}
