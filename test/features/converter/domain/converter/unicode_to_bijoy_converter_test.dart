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
        expect(converter.convert('হ'), 'n');
        expect(converter.convert('ন'), 'b');
        expect(converter.convert('ব'), 'e');
        expect(converter.convert('ম'), 'g');
      });
    });

    group('vowels', () {
      test('independent vowels', () {
        expect(converter.convert('অ'), 'A');
        expect(converter.convert('আ'), 'Av');
        expect(converter.convert('ই'), 'B');
        expect(converter.convert('এ'), 'G');
        expect(converter.convert('ঐ'), 'H');
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
        expect(converter.convert('কি'), 'wK');
      });

      test('e-kar moves before consonant', () {
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
        expect(converter.convert('ক্ক'), '\u00B0');
      });

      test('ksha', () {
        expect(converter.convert('ক্ষ'), '\u00B6');
      });
    });

    group('composed vowel signs', () {
      test('o-kar decomposes', () {
        final result = converter.convert('কো');
        expect(result, '\u2020Kv');
      });

      test('ou-kar decomposes', () {
        final result = converter.convert('কৌ');
        expect(result, '\u2020K\u0160');
      });
    });

    group('marks', () {
      test('hasanta', () {
        expect(converter.convert('ক্'), 'K&');
      });

      test('anusvara', () {
        expect(converter.convert('কং'), 'Ks');
      });
    });

    group('punctuation', () {
      test('dari to pipe', () {
        expect(converter.convert('।'), '|');
      });
    });
  });
}
