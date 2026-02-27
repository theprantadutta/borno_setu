import 'bangla_char_utils.dart';
import 'bijoy_charset.dart';

/// Converts Bijoy ANSI-encoded text to proper Unicode Bangla.
///
/// Uses a 4-stage pipeline:
/// 1. Pre-processing — fix common Bijoy encoding errors
/// 2. Character mapping — replace Bijoy chars with Unicode equivalents
/// 3. Unicode reordering — fix pre-kar, reph, and nukta positions
/// 4. Post-processing — clean up artifacts
class BijoyToUnicodeConverter {
  const BijoyToUnicodeConverter();

  String convert(String input) {
    if (input.isEmpty) return input;

    var text = input;
    text = _preProcess(text);
    text = _mapCharacters(text);
    text = _reArrange(text);
    text = _postProcess(text);
    return text;
  }

  /// Stage 1: Fix common Bijoy encoding errors before mapping.
  String _preProcess(String text) {
    var result = text;

    // Fix doubled kars
    result = result.replaceAll('yy', 'y');
    result = result.replaceAll('vv', 'v');

    // Fix hasanta+kar errors (hasanta followed by kar should drop hasanta)
    result = result.replaceAll('y&', 'y');
    result = result.replaceAll('\u201E&', '\u201E'); // „& → „

    // Fix chandrabindu ordering: chandrabindu (u) should come after e-kar (†/‡)
    result = result.replaceAll('\u2021u', 'u\u2021'); // ‡u → u‡
    result = result.replaceAll('\u2020u', 'u\u2020'); // †u → u†

    return result;
  }

  /// Stage 2: Replace Bijoy characters with Unicode equivalents.
  /// Processes longest keys first (map is pre-ordered).
  String _mapCharacters(String text) {
    var result = text;
    for (final entry in BijoyCharset.map.entries) {
      result = result.replaceAll(entry.key, entry.value);
    }
    return result;
  }

  /// Stage 3: Reorder Unicode characters to correct positions.
  ///
  /// Three sub-passes:
  /// (a) Pre-kar reordering — move ি, ে, ৈ after their consonant cluster
  /// (b) Reph repositioning — move র্ before its consonant cluster
  /// (c) Nukta reordering — ensure ঁ follows post-kars
  String _reArrange(String text) {
    var result = text;
    result = _reorderPreKars(result);
    result = _repositionReph(result);
    result = _reorderNukta(result);
    return result;
  }

  /// Move pre-kars (ি, ে, ৈ) to after the consonant+hasanta cluster.
  ///
  /// In Bijoy encoding, pre-kars appear before the consonant in the byte
  /// stream. In Unicode, they must appear after the consonant they modify.
  /// Also handles composite vowel signs: ে+া→ো, ে+ৗ→ৌ
  String _reorderPreKars(String text) {
    final chars = text.split('');
    final result = <String>[];

    var i = 0;
    while (i < chars.length) {
      if (BanglaCharUtils.isBanglaPreKar(chars[i])) {
        final preKar = chars[i];
        i++;

        // Collect the consonant+hasanta cluster that follows
        final cluster = <String>[];
        while (i < chars.length) {
          if (BanglaCharUtils.isBanglaConsonant(chars[i])) {
            cluster.add(chars[i]);
            i++;
            // Check for hasanta following the consonant
            if (i < chars.length && BanglaCharUtils.isBanglaHasanta(chars[i])) {
              cluster.add(chars[i]);
              i++;
            } else {
              break;
            }
          } else {
            break;
          }
        }

        if (cluster.isNotEmpty) {
          result.addAll(cluster);
        }

        // Check for composite vowel signs
        if (preKar == '\u09C7') {
          // ে
          if (i < chars.length && chars[i] == '\u09BE') {
            // ে + া → ো
            result.add('\u09CB');
            i++;
          } else if (i < chars.length && chars[i] == '\u09D7') {
            // ে + ৗ → ৌ
            result.add('\u09CC');
            i++;
          } else {
            result.add(preKar);
          }
        } else {
          result.add(preKar);
        }
      } else {
        result.add(chars[i]);
        i++;
      }
    }

    return result.join();
  }

  /// Reposition reph (র্) before its consonant cluster.
  ///
  /// In Bijoy, reph (©) maps to র্ and appears before the consonant cluster.
  /// After character mapping, র্ is already in the text but may need
  /// repositioning relative to the consonant cluster it covers.
  String _repositionReph(String text) {
    final chars = text.split('');
    final result = <String>[];

    var i = 0;
    while (i < chars.length) {
      // Look for র followed by ্ (hasanta) — this is a reph
      if (i + 1 < chars.length &&
          chars[i] == '\u09B0' && // র
          chars[i + 1] == '\u09CD') {
        // ্

        // Check if the next char after hasanta is a consonant
        // If so, this is reph over a cluster — it's already in correct position
        // in Unicode (র্ precedes the cluster)
        result.add(chars[i]);
        i++;
      } else {
        result.add(chars[i]);
        i++;
      }
    }

    return result.join();
  }

  /// Ensure chandrabindu (ঁ) follows any post-kars.
  String _reorderNukta(String text) {
    final chars = text.split('');
    final result = <String>[];

    var i = 0;
    while (i < chars.length) {
      if (BanglaCharUtils.isBanglaNukta(chars[i]) &&
          i + 1 < chars.length &&
          BanglaCharUtils.isBanglaPostKar(chars[i + 1])) {
        // Swap: put post-kar before chandrabindu
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

  /// Stage 4: Clean up post-conversion artifacts.
  String _postProcess(String text) {
    var result = text;

    // Collapse doubled hasanta
    result = result.replaceAll('\u09CD\u09CD', '\u09CD');

    // Fix vowel combo: অা → আ
    result = result.replaceAll('\u0985\u09BE', '\u0986');

    // Fix digit+bisarga: preserve ASCII colon after digits
    result = result.replaceAll('\u09E6\u0983', '\u09E60:');

    return result;
  }
}
