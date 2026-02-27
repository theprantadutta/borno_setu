import 'package:borno_setu/features/converter/domain/converter/unicode_to_bijoy_converter.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const converter = UnicodeToBijoyConverter();

  group('UnicodeToBijoyConverter', () {
    test('empty string returns empty', () {
      expect(converter.convert(''), '');
    });

    group('consonants', () {
      test('single consonants', () {
        expect(converter.convert('ক'), 'K');
        expect(converter.convert('খ'), 'L');
        expect(converter.convert('গ'), 'M');
        expect(converter.convert('ত'), 'Z');
        expect(converter.convert('হ'), 'j');
      });
    });

    group('vowels', () {
      test('independent vowels', () {
        expect(converter.convert('অ'), 'A');
        expect(converter.convert('ই'), 'C');
        expect(converter.convert('এ'), 'H');
      });
    });

    group('vowel signs', () {
      test('aa-kar', () {
        expect(converter.convert('কা'), 'Kv');
      });

      test('ii-kar', () {
        expect(converter.convert('কী'), 'Kx');
      });
    });

    group('pre-kar reverse reordering', () {
      test('i-kar moves before consonant', () {
        // Unicode: কি → Bijoy: wK
        expect(converter.convert('কি'), 'wK');
      });

      test('e-kar moves before consonant', () {
        // Unicode: কে → Bijoy: †K  (†=\u2020)
        expect(converter.convert('কে'), '\u2020K');
      });
    });

    group('numerals', () {
      test('Bangla digits to Bijoy', () {
        expect(converter.convert('০১২৩৪৫৬৭৮৯'), '0123456789');
      });
    });

    group('conjuncts', () {
      test('kka', () {
        expect(converter.convert('ক্ক'), '°');
      });

      test('ksha', () {
        expect(converter.convert('ক্ষ'), '´');
      });

      test('nta', () {
        expect(converter.convert('ন্ত'), 'Ù');
      });
    });

    group('composed vowel signs', () {
      test('o-kar decomposes', () {
        // ো = ে + া
        final result = converter.convert('কো');
        // Should produce Bijoy e-kar before K, then aa-kar after
        expect(result, '\u2020Kv');
      });

      test('ou-kar decomposes', () {
        // ৌ = ে + ৗ
        final result = converter.convert('কৌ');
        expect(result, '\u2020K\u2026');
      });
    });

    group('marks', () {
      test('hasanta', () {
        expect(converter.convert('ক্'), 'K&');
      });

      test('anusvara', () {
        expect(converter.convert('কং'), 'Kˆ');
      });
    });

    group('punctuation', () {
      test('dari to pipe', () {
        expect(converter.convert('।'), '|');
      });
    });
  });
}
