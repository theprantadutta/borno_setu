import '../entities/conversion_type.dart';
import 'bijoy_to_unicode_converter.dart';
import 'unicode_to_bijoy_converter.dart';

/// Facade for Bangla text conversion between Bijoy ANSI and Unicode.
///
/// Delegates to the appropriate directional converter based on the
/// specified [ConversionType].
class BornoConverter {
  const BornoConverter();

  static const _bijoyToUnicode = BijoyToUnicodeConverter();
  static const _unicodeToBijoy = UnicodeToBijoyConverter();

  /// Convert [input] text in the direction specified by [type].
  String convert(String input, ConversionType type) {
    if (input.isEmpty) return input;

    return switch (type) {
      ConversionType.bijoyToUnicode => _bijoyToUnicode.convert(input),
      ConversionType.unicodeToBijoy => _unicodeToBijoy.convert(input),
    };
  }
}
