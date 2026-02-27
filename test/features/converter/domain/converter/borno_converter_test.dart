import 'package:borno_setu/features/converter/domain/converter/borno_converter.dart';
import 'package:borno_setu/features/converter/domain/entities/conversion_type.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const converter = BornoConverter();

  group('BornoConverter', () {
    test('empty string returns empty for both directions', () {
      expect(
        converter.convert('', ConversionType.bijoyToUnicode),
        '',
      );
      expect(
        converter.convert('', ConversionType.unicodeToBijoy),
        '',
      );
    });

    test('delegates to BijoyToUnicode', () {
      final result = converter.convert('K', ConversionType.bijoyToUnicode);
      expect(result, 'ক');
    });

    test('delegates to UnicodeToBijoy', () {
      final result = converter.convert('ক', ConversionType.unicodeToBijoy);
      expect(result, 'K');
    });
  });
}
