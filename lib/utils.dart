import 'dart:ui';

import 'package:flutter/cupertino.dart';

Color getColorFromHex(String hexColor) {
  hexColor = hexColor.replaceAll("#", "");
  if (hexColor.length == 6) {
    hexColor = "FF" + hexColor;
  }
  if (hexColor.length == 8) {
    return Color(int.parse("0x$hexColor"));
  }

  return Color(int.parse("0xFFFFFF"));
}

IconData getIconFromString(String iconString, String iconFontFamily){
  return IconData(
    int.parse(iconString),
    fontFamily:iconFontFamily,
  );  
}