import 'package:flutter/cupertino.dart';

enum ScreenType {
  web,
  mobile,
  tablet,
  desktop,
  watch,
  unknown,
}


extension ScreenTypeExtension on ScreenType {
  static ScreenType fromMediaQueryData(MediaQueryData mediaQueryData) {
    final shortestSide = mediaQueryData.size.width;
    print('shortestSide: $shortestSide');
    if (shortestSide < 500) {
      return ScreenType.mobile;
    } else if (shortestSide < 600) {
      return ScreenType.tablet;
    } else if (shortestSide < 720) {
      return ScreenType.web;
    } else if (shortestSide < 1200) {
      return ScreenType.desktop;
    } else {
      return ScreenType.desktop;
    }
  }
}