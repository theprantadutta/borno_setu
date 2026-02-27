import 'package:borno_setu/features/converter/domain/converter/bangla_char_utils.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('BanglaCharUtils', () {
    group('isBanglaPreKar', () {
      test('returns true for pre-kars', () {
        expect(BanglaCharUtils.isBanglaPreKar('ি'), true);
        expect(BanglaCharUtils.isBanglaPreKar('ে'), true);
        expect(BanglaCharUtils.isBanglaPreKar('ৈ'), true);
      });

      test('returns false for non pre-kars', () {
        expect(BanglaCharUtils.isBanglaPreKar('া'), false);
        expect(BanglaCharUtils.isBanglaPreKar('ু'), false);
        expect(BanglaCharUtils.isBanglaPreKar('ক'), false);
        expect(BanglaCharUtils.isBanglaPreKar(''), false);
      });
    });

    group('isBanglaPostKar', () {
      test('returns true for post-kars', () {
        expect(BanglaCharUtils.isBanglaPostKar('া'), true);
        expect(BanglaCharUtils.isBanglaPostKar('ী'), true);
        expect(BanglaCharUtils.isBanglaPostKar('ু'), true);
        expect(BanglaCharUtils.isBanglaPostKar('ূ'), true);
        expect(BanglaCharUtils.isBanglaPostKar('ৃ'), true);
        expect(BanglaCharUtils.isBanglaPostKar('ৗ'), true);
      });

      test('returns false for pre-kars', () {
        expect(BanglaCharUtils.isBanglaPostKar('ি'), false);
        expect(BanglaCharUtils.isBanglaPostKar('ে'), false);
      });
    });

    group('isBanglaConsonant', () {
      test('returns true for consonants', () {
        expect(BanglaCharUtils.isBanglaConsonant('ক'), true);
        expect(BanglaCharUtils.isBanglaConsonant('হ'), true);
        expect(BanglaCharUtils.isBanglaConsonant('ড়'), true);
        expect(BanglaCharUtils.isBanglaConsonant('য়'), true);
        expect(BanglaCharUtils.isBanglaConsonant('ৎ'), true);
      });

      test('returns false for vowels and marks', () {
        expect(BanglaCharUtils.isBanglaConsonant('অ'), false);
        expect(BanglaCharUtils.isBanglaConsonant('া'), false);
        expect(BanglaCharUtils.isBanglaConsonant(''), false);
      });
    });

    group('isBanglaVowel', () {
      test('returns true for vowels', () {
        expect(BanglaCharUtils.isBanglaVowel('অ'), true);
        expect(BanglaCharUtils.isBanglaVowel('আ'), true);
        expect(BanglaCharUtils.isBanglaVowel('ঔ'), true);
      });

      test('returns false for consonants', () {
        expect(BanglaCharUtils.isBanglaVowel('ক'), false);
      });
    });

    group('isBanglaHasanta', () {
      test('returns true for hasanta', () {
        expect(BanglaCharUtils.isBanglaHasanta('্'), true);
      });

      test('returns false for other chars', () {
        expect(BanglaCharUtils.isBanglaHasanta('ক'), false);
        expect(BanglaCharUtils.isBanglaHasanta(''), false);
      });
    });

    group('isBanglaNukta', () {
      test('returns true for chandrabindu', () {
        expect(BanglaCharUtils.isBanglaNukta('ঁ'), true);
      });

      test('returns false for anusvara', () {
        expect(BanglaCharUtils.isBanglaNukta('ং'), false);
      });
    });
  });
}
