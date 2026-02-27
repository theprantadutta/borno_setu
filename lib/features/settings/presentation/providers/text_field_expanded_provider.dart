import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/constants/app_constants.dart';

class TextFieldExpandedNotifier extends StateNotifier<bool> {
  TextFieldExpandedNotifier() : super(false) {
    _load();
  }

  Future<void> _load() async {
    final prefs = await SharedPreferences.getInstance();
    final value = prefs.getBool(AppConstants.textFieldExpandedKey);
    if (value != null) {
      state = value;
    }
  }

  Future<void> toggle() async {
    state = !state;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(AppConstants.textFieldExpandedKey, state);
  }
}

final textFieldExpandedProvider =
    StateNotifierProvider<TextFieldExpandedNotifier, bool>((ref) {
  return TextFieldExpandedNotifier();
});
