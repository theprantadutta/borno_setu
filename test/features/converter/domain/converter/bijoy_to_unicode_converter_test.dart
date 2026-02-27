import 'package:borno_setu/features/converter/domain/converter/bijoy_to_unicode_converter.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const converter = BijoyToUnicodeConverter();

  group('BijoyToUnicodeConverter', () {
    test('empty string returns empty', () {
      expect(converter.convert(''), '');
    });

    group('consonants', () {
      test('uppercase consonants K-Z', () {
        expect(converter.convert('K'), 'ক');
        expect(converter.convert('L'), 'খ');
        expect(converter.convert('M'), 'গ');
        expect(converter.convert('N'), 'ঘ');
        expect(converter.convert('O'), 'ঙ');
        expect(converter.convert('P'), 'চ');
        expect(converter.convert('Q'), 'ছ');
        expect(converter.convert('R'), 'জ');
        expect(converter.convert('S'), 'ঝ');
        expect(converter.convert('T'), 'ঞ');
        expect(converter.convert('U'), 'ট');
        expect(converter.convert('V'), 'ঠ');
        expect(converter.convert('W'), 'ড');
        expect(converter.convert('X'), 'ঢ');
        expect(converter.convert('Y'), 'ণ');
        expect(converter.convert('Z'), 'ত');
      });

      test('lowercase consonants _-n', () {
        expect(converter.convert('_'), 'থ');
        expect(converter.convert('`'), 'দ');
        expect(converter.convert('a'), 'ধ');
        expect(converter.convert('b'), 'ন');
        expect(converter.convert('c'), 'প');
        expect(converter.convert('d'), 'ফ');
        expect(converter.convert('e'), 'ব');
        expect(converter.convert('f'), 'ভ');
        expect(converter.convert('g'), 'ম');
        expect(converter.convert('h'), 'য');
        expect(converter.convert('i'), 'র');
        expect(converter.convert('j'), 'ল');
        expect(converter.convert('k'), 'শ');
        expect(converter.convert('l'), 'ষ');
        expect(converter.convert('m'), 'স');
        expect(converter.convert('n'), 'হ');
      });

      test('additional consonants o-r', () {
        expect(converter.convert('o'), '\u09DC'); // ড় composed
        expect(converter.convert('p'), '\u09DD'); // ঢ় composed
        expect(converter.convert('q'), '\u09DF'); // য় composed
        expect(converter.convert('r'), 'ৎ');
      });

      test('marks s-u', () {
        expect(converter.convert('s'), 'ং');
        expect(converter.convert('t'), 'ঃ');
        expect(converter.convert('u'), 'ঁ');
      });
    });

    group('vowels', () {
      test('independent vowels', () {
        expect(converter.convert('A'), 'অ');
        expect(converter.convert('Av'), 'আ');
        expect(converter.convert('B'), 'ই');
        expect(converter.convert('C'), 'ঈ');
        expect(converter.convert('D'), 'উ');
        expect(converter.convert('E'), 'ঊ');
        expect(converter.convert('F'), 'ঋ');
        expect(converter.convert('G'), 'এ');
        expect(converter.convert('H'), 'ঐ');
        expect(converter.convert('I'), 'ও');
        expect(converter.convert('J'), 'ঔ');
      });
    });

    group('vowel signs (kars)', () {
      test('aa-kar', () {
        expect(converter.convert('Kv'), 'কা');
      });

      test('i-kar reordered', () {
        expect(converter.convert('wK'), 'কি');
      });

      test('ii-kar', () {
        expect(converter.convert('Kx'), 'কী');
      });

      test('u-kar (y)', () {
        expect(converter.convert('Ky'), 'কু');
      });

      test('u-kar (z alternate)', () {
        expect(converter.convert('Kz'), 'কু');
      });

      test('uu-kar (~)', () {
        expect(converter.convert('K~'), 'কূ');
      });

      test('ri-kar', () {
        expect(converter.convert('K\u201E'), 'কৃ');
      });

      test('e-kar reordered', () {
        expect(converter.convert('\u2020K'), 'কে');
      });

      test('oi-kar reordered', () {
        expect(converter.convert('\u02C6K'), 'কৈ');
      });
    });

    group('pre-kar reordering', () {
      test('e-kar + aa-kar composes to o-kar', () {
        expect(converter.convert('\u2020Kv'), 'কো');
      });

      test('e-kar + ou-kar composes to ou-kar', () {
        expect(converter.convert('\u2020K\u0160'), 'কৌ');
      });
    });

    group('numerals', () {
      test('Bijoy digits to Bangla digits', () {
        expect(converter.convert('0123456789'), '০১২৩৪৫৬৭৮৯');
      });
    });

    group('marks', () {
      test('anusvara', () {
        expect(converter.convert('Ks'), 'কং');
      });

      test('visarga', () {
        expect(converter.convert('Kt'), 'কঃ');
      });
    });

    group('conjuncts', () {
      test('kka (°)', () {
        expect(converter.convert('\u00B0'), 'ক্ক');
      });

      test('ksha (¶)', () {
        expect(converter.convert('\u00B6'), 'ক্ষ');
      });

      test('jnya (Á)', () {
        expect(converter.convert('\u00C1'), 'জ্ঞ');
      });

      test('tto (Ë)', () {
        expect(converter.convert('\u00CB'), 'ত্ত');
      });

      test('ddo (Ï)', () {
        expect(converter.convert('\u00CF'), 'দ্দ');
      });
    });

    group('pre-symbols', () {
      test('sho-hasanta (®) combines with next', () {
        expect(converter.convert('\u00AEY'), 'ষ্ণ');
      });

      test('no-hasanta (š) combines with next', () {
        expect(converter.convert('\u0161Z'), 'ন্ত');
      });
    });

    group('post-symbols', () {
      test('ja-phala (¨)', () {
        expect(converter.convert('K\u00A8'), 'ক্য');
      });

      test('ra-fola (ª)', () {
        expect(converter.convert('K\u00AA'), 'ক্র');
      });

      test('ba-fola (^)', () {
        expect(converter.convert('K^'), 'ক্ব');
      });
    });

    group('reph (backward scan)', () {
      test('reph after single consonant', () {
        // b© = ন+reph → র্ন
        expect(converter.convert('b\u00A9'), 'র্ন');
      });

      test('reph in দুর্নীতিতে', () {
        // ` = দ, y = ু, b = ন, © = reph, x = ী, w = ি(pre-kar), Z = ত,
        // \u2021 = ে(pre-kar), Z = ত
        expect(converter.convert('`yb\u00A9xwZ\u2021Z'), 'দুর্নীতিতে');
      });

      test('reph in অর্থই', () {
        // A = অ, _ = থ, © = reph, B = ই
        expect(converter.convert('A_\u00A9B'), 'অর্থই');
      });
    });

    group('punctuation', () {
      test('pipe to dari', () {
        expect(converter.convert('|'), '।');
      });

      test('quote marks', () {
        expect(converter.convert('\u00D2'), '\u201C');
        expect(converter.convert('\u00D3'), '\u201D');
        expect(converter.convert('\u00D4'), '\u2018');
        expect(converter.convert('\u00D5'), '\u2019');
      });
    });

    group('mixed content', () {
      test('spaces and newlines preserved', () {
        expect(converter.convert('K K'), contains(' '));
      });
    });

    group('post-processing', () {
      test('অা becomes আ', () {
        expect(converter.convert('Av'), 'আ');
      });
    });

    group('Bug 2: ÿ (\\u00FF) → ক্ষ', () {
      test('ÿ maps to ক্ষ', () {
        expect(converter.convert('\u00FF'), 'ক্ষ');
      });

      test('ÿ in context', () {
        // j = ল, \u2021 = ে (pre-kar before ক্ষ্য),
        // \u00FF = ক্ষ, \u00A8 = ্য
        expect(converter.convert('j\u2021\u00FF\u00A8'), 'লক্ষ্যে');
      });
    });

    group('Bug 3: ASCII double quote → চ্', () {
      test('" maps to চ্', () {
        expect(converter.convert('"Q'), 'চ্ছ');
      });

      test('" in উচ্ছ', () {
        // D = উ, " = চ্, Q = ছ
        expect(converter.convert('D"Q'), 'উচ্ছ');
      });
    });

    group('Bug 4: \\u00CD → ত (not ত্ম)', () {
      test('\\u00CD maps to ত', () {
        expect(converter.convert('\u00CD'), 'ত');
      });

      test('স্তার via ¯Í', () {
        // \u00AF = স্, \u00CD = ত, v = া, i = র
        expect(converter.convert('\u00AF\u00CDvi'), 'স্তার');
      });
    });

    group('Bug 5: \\u00E6 → ু (not ম্ন)', () {
      test('\\u00E6 maps to ু', () {
        expect(converter.convert('K\u00E6'), 'কু');
      });

      test('শুরু via ïiæ', () {
        // \u00EF = শু, i = র, \u00E6 = ু
        expect(converter.convert('\u00EFi\u00E6'), 'শুরু');
      });

      test('বিরুদ্ধে', () {
        // w = ি (pre-kar), e = ব, i = র, \u00E6 = ু,
        // \u2021 = ে (pre-kar), \u00D7 = দ্ধ (conjunct)
        expect(converter.convert('wei\u00E6\u2021\u00D7'), 'বিরুদ্ধে');
      });
    });

    group('Bug 6: \\u00F8 → ্ল (not স্ন)', () {
      test('\\u00F8 maps to ্ল (la-fola)', () {
        // j = ল, \u00F8 = ্ল → ল্ল
        expect(converter.convert('j\u00F8'), 'ল্ল');
      });

      test('উল্লেখ্য', () {
        // D = উ, \u2021 = ে (pre-kar before ল্ল cluster),
        // j = ল, \u00F8 = ্ল, L = খ, \u00A8 = ্য
        expect(converter.convert('D\u2021j\u00F8L\u00A8'), 'উল্লেখ্য');
      });
    });

    group('Bug 7: composed ড়, ঢ়, য়', () {
      test('o maps to composed ড় (\\u09DC)', () {
        expect(converter.convert('o'), '\u09DC');
      });

      test('p maps to composed ঢ় (\\u09DD)', () {
        expect(converter.convert('p'), '\u09DD');
      });

      test('q maps to composed য় (\\u09DF)', () {
        expect(converter.convert('q'), '\u09DF');
      });

      test('হয়ে — pre-kar reordering works with composed য়', () {
        // n = হ, \u2021 = ে (pre-kar), q = য় → হয়ে
        expect(converter.convert('n\u2021q'), '\u09B9\u09DF\u09C7');
      });

      test('পড়ে — pre-kar reordering works with composed ড়', () {
        // c = প, \u2021 = ে (pre-kar), o = ড় → পড়ে
        expect(converter.convert('c\u2021o'), '\u09AA\u09DC\u09C7');
      });
    });

    group('Bug 8: double-hasanta collapse before rearrangement', () {
      test('pre-symbol + post-symbol produces clean cluster', () {
        // \u00A4 = ম্, \u00FA = ্প → ম্প (not ম্্প)
        expect(converter.convert('\u00A4\u00FA'), 'ম্প');
      });

      test('কম্পিশন — pre-kar reorders correctly after collapse', () {
        // K = ক, w = ি (pre-kar), \u00A4 = ম্, \u00FA = ্প, k = শ, b = ন
        // Without midProcess: ম্্প has double hasanta, ি gets stuck
        // With midProcess: ম্প clean cluster, ি reorders correctly
        expect(converter.convert('Kw\u00A4\u00FAkb'), 'কম্পিশন');
      });
    });
  });
}
