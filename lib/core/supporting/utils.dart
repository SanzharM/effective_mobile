import 'package:flutter/foundation.dart';
import 'package:flutter/painting.dart';

class Utils {
  static Color? getColorFromHex(String hex) {
    try {
      final value = hex.replaceAll('#', '');
      return Color(int.parse('0xff$value'));
    } catch (e) {
      debugPrint('Unable to parse Hex from $hex: $e');
    }
    return null;
  }

  static String toFormattedPrice(double? price, {String currency = '\$'}) {
    return '$currency$price';
  }
}
