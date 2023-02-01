import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:flutter/material.dart';

class Utils {
  static WindowButtonColors buttonColors = WindowButtonColors(iconNormal: Utils.getIconColor(), mouseOver: Utils.getAccentColor().withOpacity(.4), mouseDown: Utils.getAccentColor(), iconMouseOver: Utils.getIconColor(), iconMouseDown: Utils.getIconColor());

  static WindowButtonColors closeButtonColors = WindowButtonColors(mouseOver: const Color(0xFFD32F2F), mouseDown: const Color(0xFFB71C1C), iconNormal: Utils.getIconColor(), iconMouseOver: Colors.white);

  static Color colorFromHex(String hexColor) {
    final hexCode = hexColor.replaceAll('#', '');
    if (hexColor.length == 6) {
      hexColor = 'FF$hexColor';
    }
    return Color(int.parse('FF$hexCode', radix: 16));
  }

  static Color getPrimaryColor() {
    return colorFromHex('#101010');
  }

  static Color getBGColor() {
    return colorFromHex('#101010');
  }

  static Color getCardColor() {
    return colorFromHex('#1A1A1A');
  }

  static Color getAccentColor() {
    return colorFromHex('#008EFF');
  }

  static Color getWhiteColor() {
    return colorFromHex('#FFFFFF');
  }

  static Color getTextColor() {
    return colorFromHex('#FFFFFF');
  }

  static Color getSubTextColor() {
    return colorFromHex('#FFFFFF').withOpacity(0.5);
  }

  static Color getHintColor() {
    return colorFromHex('#AAAAAA');
  }

  static Color getErrorColor() {
    return colorFromHex('#F44336');
  }

  static Color getIconColor() {
    return colorFromHex('#FFFFFF');
  }

  static String getGreeting() {
    var hour = DateTime.now().hour;
    if (hour < 12) {
      return 'Morning';
    }
    if (hour < 17) {
      return 'Afternoon';
    }
    return 'Evening';
  }
}
