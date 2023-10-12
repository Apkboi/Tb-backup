import 'dart:ui';

class UtilColor {
  static Color? fromStringRepresentation(String colorValue) {
    if (colorValue.startsWith("#")) {
      return fromHex(colorValue);
    }
    return null;
  }

  static Color fromHex(String hexString) {
    hexString = hexString.trim();
    if (hexString.length == 4) {
      // convert for example #f00 to #ff0000
      hexString =
          "#" + (hexString[1] * 2) + (hexString[2] * 2) + (hexString[3] * 2);
    }
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
    buffer.write(hexString.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }
}
