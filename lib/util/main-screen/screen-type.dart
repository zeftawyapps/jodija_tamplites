import 'package:flutter/cupertino.dart';

/// تصنيف أحجام الشاشات والأجهزة (Screen Breakpoint Viewport Classification)
///
/// يحدد نوع الشاشة الحالي (جوال، تابلت، ديسك توب، ويب) بناءً على عرض الشاشة.
///
/// English Description:
/// Device viewport breakpoint enumeration categorizing screens into mobile, tablet,
/// desktop, and web layouts.
enum ScreenType {
  web,
  mobile,
  tablet,
  desktop,
  watch,
  unknown,
}

extension ScreenTypeExtension on ScreenType {
  /// استنتاج تصنيف الشاشة من بيانات MediaQuery
  /// Resolves [ScreenType] dynamically from [MediaQueryData] dimensions.
  static ScreenType fromMediaQueryData(MediaQueryData mediaQueryData) {
    final shortestSide = mediaQueryData.size.width;
    if (shortestSide < 500) {
      return ScreenType.mobile;
    } else if (shortestSide < 600) {
      return ScreenType.tablet;
    } else if (shortestSide < 720) {
      return ScreenType.desktop;
    } else {
      return ScreenType.web;
    }
  }
}