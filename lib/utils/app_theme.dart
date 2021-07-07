import 'package:flutter/material.dart';

class AppTheme {
  static Color colorPrimary = HexColor("#253c90");
  static Color colorBackground = HexColor("#FCFBFE");
  static Color colorCard = Colors.white;
  static Color colorAppBarText = Colors.white;

  static Color colorGreen = HexColor("#6db28a");
  static Color colorRed = HexColor("#c63943");
  static Color colorYellow = HexColor("#f1cb4f");
  static Color colorSubTitle = HexColor('#1b2738');
  static Color colorTextFieldTextColor = Colors.grey;
  static Color colorDarkGrey = Colors.black12;
  static Color colorTextBlack = Colors.black;
  static Color colorButtonText = Colors.white;
}

class HexColor extends Color {
  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF" + hexColor;
    }
    return int.parse(hexColor, radix: 16);
  }

  HexColor(final String hexColor) : super(_getColorFromHex(hexColor));

  @override
  String toString() {
    // TODO: implement toString
    return super.toString();
  }
}
