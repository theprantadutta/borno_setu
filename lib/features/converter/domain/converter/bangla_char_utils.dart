abstract final class BanglaCharUtils {
  /// Pre-kars: vowel signs that visually appear before the consonant
  /// but logically follow it in Unicode.
  static bool isBanglaPreKar(String ch) {
    if (ch.isEmpty) return false;
    final code = ch.codeUnitAt(0);
    // ি (0x09BF), ে (0x09C7), ৈ (0x09C8)
    return code == 0x09BF || code == 0x09C7 || code == 0x09C8;
  }

  /// Post-kars: vowel signs that appear after the consonant both
  /// visually and logically.
  static bool isBanglaPostKar(String ch) {
    if (ch.isEmpty) return false;
    final code = ch.codeUnitAt(0);
    // া (0x09BE), ী (0x09C0), ু (0x09C1), ূ (0x09C2), ৃ (0x09C3), ৗ (0x09D7)
    return code == 0x09BE ||
        code == 0x09C0 ||
        code == 0x09C1 ||
        code == 0x09C2 ||
        code == 0x09C3 ||
        code == 0x09D7;
  }

  /// Bangla consonants: ক-হ range plus ড়, ঢ়, য়, ৎ
  static bool isBanglaConsonant(String ch) {
    if (ch.isEmpty) return false;
    final code = ch.codeUnitAt(0);
    // ক (0x0995) to হ (0x09B9)
    if (code >= 0x0995 && code <= 0x09B9) return true;
    // ড় (0x09DC), ঢ় (0x09DD), য় (0x09DF), ৎ (0x09CE)
    return code == 0x09DC ||
        code == 0x09DD ||
        code == 0x09DF ||
        code == 0x09CE;
  }

  /// Bangla vowels: অ-ঔ range
  static bool isBanglaVowel(String ch) {
    if (ch.isEmpty) return false;
    final code = ch.codeUnitAt(0);
    // অ (0x0985) to ঔ (0x0994)
    return code >= 0x0985 && code <= 0x0994;
  }

  /// Hasanta (virama): ্ (U+09CD)
  static bool isBanglaHasanta(String ch) {
    if (ch.isEmpty) return false;
    return ch.codeUnitAt(0) == 0x09CD;
  }

  /// Chandrabindu: ঁ (U+0981)
  static bool isBanglaNukta(String ch) {
    if (ch.isEmpty) return false;
    return ch.codeUnitAt(0) == 0x0981;
  }

  /// Any Bangla kar (vowel sign)
  static bool isBanglaKar(String ch) {
    return isBanglaPreKar(ch) || isBanglaPostKar(ch);
  }
}
