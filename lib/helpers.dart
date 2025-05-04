import 'package:flutter/material.dart';

class Helpers {
  static String getWeightText(FontWeight fontWeight) {
    switch (fontWeight) {
      case FontWeight.w100:
        return "Thin 100";
      case FontWeight.w200:
        return "ExtraLight 200";
      case FontWeight.w300:
        return "Light 300";
      case FontWeight.w400:
        return "Regular 400";
      case FontWeight.w500:
        return "Medium 500";
      case FontWeight.w600:
        return "SemiBold 600";
      case FontWeight.w700:
        return "Bold 700";
      case FontWeight.w800:
        return "ExtraBold 800";
      case FontWeight.w900:
        return "Black 900";
      default:
        return "Regular 400";
    }
  }
}
