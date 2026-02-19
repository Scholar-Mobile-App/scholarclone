import 'package:flutter/material.dart';

class AppColor {
  static Color primaryColor = const Color(0xFFf4e022);
  static Color secondaryColor = const Color(0xFF3f98d3);
  static Color greenColor = const Color(0xFF8eba49);
  static Color redColor = const Color(0xFFe52726);
  static Color heliotropeColor = const Color(0xFFb668f3);
  static Color yellowlightColor = const Color(0xFFbab233);
  static Color textColorDark = const Color(0xFF2a3338);
  static Color textColor = const Color(0xFF65665a);
  static Color textColorlight = const Color(0xFF9f9f9f);
  static Color textColorhint = const Color(0xFFdddddd);
  static Color textSubjectName = const Color(0xFFe52826);
  static Color bgColor = const Color(0xFFf5f5f5);
  static Color errorColor = const Color(0xFFd84747);
  static Color pink = const Color(0xFFfd95c6);
  static Color blue = const Color(0xFFad73fb);
  static Color purple = const Color(0xFF5C4AC7);
  static List<Color> primaryGradientColor = [primaryColor, secondaryColor];

  static List<Color> nAGradientColor = [Colors.blueGrey, Colors.grey];
  //Teacher
  static Color tprimaryColor = Colors.blue;
}

class HexColor extends Color {
  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF$hexColor";
    }
    return int.parse(hexColor, radix: 16);
  }

  HexColor(final String hexColor) : super(_getColorFromHex(hexColor));
}
