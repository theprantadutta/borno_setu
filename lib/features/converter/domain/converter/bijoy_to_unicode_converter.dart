import 'bangla_char_utils.dart';
import 'bijoy_charset.dart';

/// Converts Bijoy ANSI-encoded text to proper Unicode Bangla.
///
/// Uses a 4-stage pipeline:
/// 1. Pre-processing — fix common Bijoy encoding errors
/// 2. Character mapping — replace Bijoy chars with Unicode equivalents
/// 3. Unicode reordering — fix reph, pre-kar, and nukta positions
/// 4. Post-processing — clean up artifacts
class BijoyToUnicodeConverter {
  const BijoyToUnicodeConverter();

  String convert(String input) {
    if (input.isEmpty) return input;

    var text = input;
    text = _preProcess(text);
    text = _mapCharacters(text);
    text = _midProcess(text);
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
    result = result.replaceAll('\u00AD\u00AD', '\u00AD');

    // Fix hasanta+kar errors
    result = result.replaceAll('y&', 'y');
    result = result.replaceAll('\u201E&', '\u201E');

    // Fix chandrabindu ordering
    result = result.replaceAll('\u2021u', 'u\u2021');
    result = result.replaceAll('wu', 'uw');

    return result;
  }

  /// Stage 2: Replace Bijoy characters with Unicode equivalents.
  /// Processes keys in map order (longest/priority first).
  String _mapCharacters(String text) {
    var result = text;
    for (final entry in BijoyCharset.map.entries) {
      result = result.replaceAll(entry.key, entry.value);
    }
    return result;
  }

  /// Stage 2.5: Collapse doubled hasanta before rearrangement so that
  /// pre-kar reordering sees clean consonant+hasanta clusters.
  String _midProcess(String text) {
    return text.replaceAll('\u09CD\u09CD', '\u09CD');
  }

  /// Stage 3: Reorder Unicode characters to correct positions.
  ///
  /// Three sub-passes (order matters):
  /// (a) Reph repositioning — move reph placeholder before its consonant cluster
  /// (b) Pre-kar reordering — move ি, ে, ৈ after their consonant cluster
  /// (c) Nukta reordering — ensure ঁ follows post-kars
  String _reArrange(String text) {
    var result = text;
    result = _repositionReph(result);
    result = _reorderPreKars(result);
    result = _reorderNukta(result);
    return result;
  }

  /// Reposition reph: find \uFFFD placeholder, scan BACKWARD past the
  /// preceding consonant+hasanta cluster, insert র্ at cluster start,
  /// remove placeholder.
  ///
  /// In Bijoy, reph (©) appears AFTER the consonant it sits on.
  /// After mapping, \uFFFD is therefore AFTER the consonant cluster.
  /// In Unicode, র্ must appear BEFORE the cluster.
  String _repositionReph(String text) {
    final chars = text.split('');
    final result = <String>[];

    for (var i = 0; i < chars.length; i++) {
      if (chars[i] == '\uFFFD') {
        // Scan backward in result to find the preceding consonant+hasanta cluster.
        // Pattern (from end): consonant [hasanta consonant]*
        var insertPos = result.length;

        while (insertPos > 0) {
          if (BanglaCharUtils.isBanglaConsonant(result[insertPos - 1])) {
            insertPos--;
            // Check for hasanta before this consonant
            if (insertPos > 0 &&
                BanglaCharUtils.isBanglaHasanta(result[insertPos - 1])) {
              insertPos--;
              // Continue scanning for more consonant+hasanta pairs
            } else {
              break;
            }
          } else {
            break;
          }
        }

        // Insert র্ at the start of the cluster
        result.insert(insertPos, '\u09B0'); // র
        result.insert(insertPos + 1, '\u09CD'); // ্
      } else {
        result.add(chars[i]);
      }
    }

    return result.join();
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

    // Collapse doubled ZWNJ-hasanta
    result = result.replaceAll('্\u200C্\u200C', '্\u200C');

    // Fix vowel combo: অা → আ
    result = result.replaceAll('\u0985\u09BE', '\u0986');

    // Fix digit+bisarga → digit+colon (Bijoy uses 't' for colon after digits)
    result = result.replaceAll('০ঃ', '০:');
    result = result.replaceAll('১ঃ', '১:');
    result = result.replaceAll('২ঃ', '২:');
    result = result.replaceAll('৩ঃ', '৩:');
    result = result.replaceAll('৪ঃ', '৪:');
    result = result.replaceAll('৫ঃ', '৫:');
    result = result.replaceAll('৬ঃ', '৬:');
    result = result.replaceAll('৭ঃ', '৭:');
    result = result.replaceAll('৮ঃ', '৮:');
    result = result.replaceAll('৯ঃ', '৯:');
    result = result.replaceAll(' ঃ', ':');
    result = result.replaceAll('\nঃ', '\n:');
    result = result.replaceAll(']ঃ', ']:');
    result = result.replaceAll('[ঃ', '[:');

    return result;
  }
}
