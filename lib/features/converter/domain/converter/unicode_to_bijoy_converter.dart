import 'bangla_char_utils.dart';
import 'unicode_charset.dart';

/// Converts Unicode Bangla text to Bijoy ANSI encoding.
///
/// Uses a 4-stage pipeline (reverse of Bijoy→Unicode):
/// 1. Pre-processing — decompose composed chars, extract reph
/// 2. Reverse reordering — move pre-kars before consonant clusters
/// 3. Character mapping — replace Unicode chars with Bijoy equivalents
/// 4. Post-processing — cleanup
class UnicodeToBijoyConverter {
  const UnicodeToBijoyConverter();

  String convert(String input) {
    if (input.isEmpty) return input;

    var text = input;
    text = _preProcess(text);
    text = _reverseReorder(text);
    text = _mapCharacters(text);
    text = _postProcess(text);
    return text;
  }

  /// Stage 1: Decompose composed Unicode characters.
  String _preProcess(String text) {
    var result = text;

    // Decompose composed vowel signs
    result = result.replaceAll('\u09CB', '\u09C7\u09BE'); // ো → ে + া
    result = result.replaceAll('\u09CC', '\u09C7\u09D7'); // ৌ → ে + ৗ

    // Normalize আ to অ + া for consistent mapping
    result = result.replaceAll('\u0986', '\u0985\u09BE'); // আ → অ + া

    return result;
  }

  /// Stage 2: Move pre-kars before their consonant clusters and
  /// convert reph (র্) to placeholder for correct positioning.
  String _reverseReorder(String text) {
    var result = text;
    result = _reverseReph(result);
    result = _movePreKarsBefore(result);
    result = _reverseNukta(result);
    return result;
  }

  /// Convert র্ + consonant cluster to placeholder + cluster.
  /// This reverses the reph repositioning done in Bijoy→Unicode.
  String _reverseReph(String text) {
    final chars = text.split('');
    final result = <String>[];

    var i = 0;
    while (i < chars.length) {
      // Look for র followed by ্ (hasanta) followed by a consonant
      if (i + 2 < chars.length &&
          chars[i] == '\u09B0' &&
          chars[i + 1] == '\u09CD' &&
          BanglaCharUtils.isBanglaConsonant(chars[i + 2])) {
        // This is reph — replace with placeholder
        result.add('\uFFFD');
        i += 2; // Skip র্, keep the consonant for next iteration
      } else {
        result.add(chars[i]);
        i++;
      }
    }

    return result.join();
  }

  /// Move pre-kars to before their consonant+hasanta cluster.
  String _movePreKarsBefore(String text) {
    final chars = text.split('');
    final result = <String>[];

    var i = 0;
    while (i < chars.length) {
      if (BanglaCharUtils.isBanglaConsonant(chars[i])) {
        final clusterStart = result.length;
        result.add(chars[i]);
        i++;

        while (i + 1 < chars.length &&
            BanglaCharUtils.isBanglaHasanta(chars[i]) &&
            BanglaCharUtils.isBanglaConsonant(chars[i + 1])) {
          result.add(chars[i]);
          result.add(chars[i + 1]);
          i += 2;
        }

        if (i < chars.length && BanglaCharUtils.isBanglaPreKar(chars[i])) {
          final preKar = chars[i];
          result.insert(clusterStart, preKar);
          i++;
        }
      } else {
        result.add(chars[i]);
        i++;
      }
    }

    return result.join();
  }

  /// Reverse nukta (chandrabindu) ordering — move before post-kars.
  String _reverseNukta(String text) {
    final chars = text.split('');
    final result = <String>[];

    var i = 0;
    while (i < chars.length) {
      if (BanglaCharUtils.isBanglaPostKar(chars[i]) &&
          i + 1 < chars.length &&
          BanglaCharUtils.isBanglaNukta(chars[i + 1])) {
        result.add(chars[i + 1]);
        result.add(chars[i]);
        i += 2;
      } else {
        result.add(chars[i]);
        i++;
      }
    }

    return result.join();
  }

  /// Stage 3: Replace Unicode characters with Bijoy equivalents.
  String _mapCharacters(String text) {
    var result = text;
    for (final entry in UnicodeCharset.map.entries) {
      result = result.replaceAll(entry.key, entry.value);
    }
    return result;
  }

  /// Stage 4: Clean up post-conversion.
  String _postProcess(String text) {
    return text;
  }
}
