import 'package:flutter/material.dart';

class ColorHelper {
  static Color parseColorFromHexString(String hex) {
    // Remove the "#" if present
    final hexCode = hex.replaceFirst('#', '');

    // Parse the hex code and add the opacity (0xFF is fully opaque)
    return Color(int.parse('FF$hexCode', radix: 16));
  }

  static String getRGBString(Color color) {
    final int red = color.red;
    final int green = color.green;
    final int blue = color.blue;

    return "$red, $green, $blue";
  }

  static Map<String, double> getCMYKFromColor(Color color) {
    // Normalize RGB values to the range [0, 1]
    double r = color.red / 255.0;
    double g = color.green / 255.0;
    double b = color.blue / 255.0;

    // Calculate K (black)
    double k = 1 - [r, g, b].reduce((a, b) => a > b ? a : b);

    if (k == 1) {
      // Pure black
      return {'cyan': 0.0, 'magenta': 0.0, 'yellow': 0.0, 'black': 1.0};
    }

    // Calculate CMY values
    double c = (1 - r - k) / (1 - k);
    double m = (1 - g - k) / (1 - k);
    double y = (1 - b - k) / (1 - k);

    return {
      'cyan': c,
      'magenta': m,
      'yellow': y,
      'black': k,
    };
  }

  static String getCMYKString(Color color) {
    Map<String, double> cmyk = getCMYKFromColor(color);

    return "${cmyk["cyan"]?.toStringAsFixed(2)}, ${cmyk["magenta"]?.toStringAsFixed(2)}, ${cmyk["yellow"]?.toStringAsFixed(2)}, ${cmyk["black"]?.toStringAsFixed(2)}";
  }
}
