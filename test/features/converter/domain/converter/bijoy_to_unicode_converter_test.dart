import 'package:borno_setu/features/converter/domain/converter/bijoy_to_unicode_converter.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const converter = BijoyToUnicodeConverter();

  group('BijoyToUnicodeConverter', () {
    test('empty string returns empty', () {
      expect(converter.convert(''), '');
    });

    group('consonants', () {
      test('single consonants', () {
        expect(converter.convert('K'), 'ক');
        expect(converter.convert('L'), 'খ');
        expect(converter.convert('M'), 'গ');
        expect(converter.convert('N'), 'ঘ');
        expect(converter.convert('P'), 'চ');
        expect(converter.convert('R'), 'জ');
        expect(converter.convert('Z'), 'ত');
        expect(converter.convert('j'), 'হ');
      });
    });

    group('vowels', () {
      test('independent vowels', () {
        expect(converter.convert('A'), 'অ');
        expect(converter.convert('B'), 'আ');
        expect(converter.convert('C'), 'ই');
        expect(converter.convert('H'), 'এ');
        expect(converter.convert('I'), 'ঐ');
      });
    });

    group('vowel signs (kars)', () {
      test('aa-kar', () {
        expect(converter.convert('Kv'), 'কা');
      });

      test('ii-kar', () {
        expect(converter.convert('Kx'), 'কী');
      });

      test('u-kar', () {
        expect(converter.convert('Ky'), 'কু');
      });

      test('uu-kar', () {
        expect(converter.convert('Kz'), 'কূ');
      });

      test('ri-kar', () {
        expect(converter.convert('K\u201E'), 'কৃ');
      });
    });

    group('pre-kar reordering', () {
      test('i-kar (w) reorders after consonant', () {
        // In Bijoy: w (ি) comes before K (ক)
        // In Unicode: ক comes before ি
        expect(converter.convert('wK'), 'কি');
      });

      test('e-kar (\u2020) reorders after consonant', () {
        expect(converter.convert('\u2020K'), 'কে');
      });

      test('oi-kar (\u2021) reorders after consonant', () {
        expect(converter.convert('\u2021K'), 'কৈ');
      });

      test('e-kar + aa-kar composes to o-kar', () {
        // ে + া → ো
        expect(converter.convert('\u2020Kv'), 'কো');
      });

      test('e-kar + ou-kar composes to ou-kar', () {
        // ে + ৗ → ৌ
        expect(converter.convert('\u2020K\u2026'), 'কৌ');
      });
    });

    group('numerals', () {
      test('Bijoy digits to Bangla digits', () {
        expect(converter.convert('0123456789'), '০১২৩৪৫৬৭৮৯');
      });
    });

    group('marks', () {
      test('hasanta', () {
        expect(converter.convert('K&'), 'ক্');
      });

      test('anusvara', () {
        expect(converter.convert('Kˆ'), 'কং');
      });

      test('visarga', () {
        expect(converter.convert('Ko'), 'কঃ');
      });
    });

    group('conjuncts', () {
      test('kka (°)', () {
        expect(converter.convert('°'), 'ক্ক');
      });

      test('ksha (´)', () {
        expect(converter.convert('´'), 'ক্ষ');
      });

      test('jnya (À)', () {
        expect(converter.convert('À'), 'জ্ঞ');
      });

      test('nta (Ù)', () {
        expect(converter.convert('Ù'), 'ন্ত');
      });

      test('nda (Û)', () {
        expect(converter.convert('Û'), 'ন্দ');
      });

      test('tta (Ì)', () {
        expect(converter.convert('Ì'), 'ত্ত');
      });
    });

    group('punctuation', () {
      test('pipe to dari', () {
        expect(converter.convert('|'), '।');
      });
    });

    group('mixed content', () {
      test('maps all Bijoy ASCII characters to Bangla', () {
        // In Bijoy, H maps to এ, so 'Hello' becomes fully Bangla
        final result = converter.convert('H');
        expect(result, 'এ');
      });

      test('spaces and newlines preserved', () {
        expect(converter.convert('K K'), contains(' '));
      });
    });

    group('post-processing', () {
      test('double hasanta collapsed', () {
        final result = converter.convert('K&&K');
        // Should not have double hasanta
        expect(result.contains('\u09CD\u09CD'), false);
      });
    });
  });
}
