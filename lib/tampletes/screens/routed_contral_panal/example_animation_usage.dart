import 'package:flutter/material.dart';
import 'theam/theam.dart';

/// Example: How to use Animation properties in SideBarNavigationTheames
class AnimationUsageExample {
  
  /// Example 1: LTR (Left-To-Right) Animation - Default
  static SideBarNavigationTheames ltRAnimationTheme() {
    return SideBarNavigationTheames.light(
      layoutDirection: TextDirection.ltr,
      animationDuration: const Duration(milliseconds: 300),
      animationCurve: Curves.easeOutCubic,
      animationSlideDistance: 50.0,
      // الحركة من اليسار إلى اليمين (المقدار السالب في getAnimationOffset)
    );
  }

  /// Example 2: RTL (Right-To-Left) Animation - عربي
  static SideBarNavigationTheames rtLAnimationTheme() {
    return SideBarNavigationTheames.light(
      layoutDirection: TextDirection.rtl,
      animationDuration: const Duration(milliseconds: 300),
      animationCurve: Curves.easeOutCubic,
      animationSlideDistance: 50.0,
      // الحركة من اليمين إلى اليسار (المقدار الموجب في getAnimationOffset)
    );
  }

  /// Example 3: سريع وناعم
  static SideBarNavigationTheames fastSmoothAnimation() {
    return SideBarNavigationTheames.light(
      layoutDirection: TextDirection.rtl,
      animationDuration: const Duration(milliseconds: 200),
      animationCurve: Curves.easeOutQuad,
      animationSlideDistance: 40.0,
      // حركة سريعة وناعمة
    );
  }

  /// Example 4: بطيء وناعم جداً
  static SideBarNavigationTheames smoothSlowAnimation() {
    return SideBarNavigationTheames.light(
      layoutDirection: TextDirection.rtl,
      animationDuration: const Duration(milliseconds: 500),
      animationCurve: Curves.easeInOutCubic,
      animationSlideDistance: 80.0,
      // حركة بطيئة وناعمة جداً مع مسافة كبيرة
    );
  }

  /// Example 5: Dynamic Theme - تبديل حسب اللغة
  static SideBarNavigationTheames dynamicLanguageTheme({
    required bool isArabic,
  }) {
    return SideBarNavigationTheames.light(
      layoutDirection: isArabic ? TextDirection.rtl : TextDirection.ltr,
      animationDuration: const Duration(milliseconds: 350),
      animationCurve: Curves.elasticOut,
      animationSlideDistance: 60.0,
      // تغيير الاتجاه تلقائياً حسب اللغة
    );
  }

  /// Example 6: Dark Theme with RTL Animation
  static SideBarNavigationTheames darkRTLAnimation() {
    return SideBarNavigationTheames.dark(
      layoutDirection: TextDirection.rtl,
      animationDuration: const Duration(milliseconds: 400),
      animationCurve: Curves.easeOutCubic,
      animationSlideDistance: 55.0,
      // ثيم داكن مع حركة RTL
    );
  }

  /// Example 7: Custom animation curve
  static SideBarNavigationTheames customCurveAnimation() {
    return SideBarNavigationTheames.light(
      layoutDirection: TextDirection.rtl,
      animationDuration: const Duration(milliseconds: 600),
      animationCurve: Curves.bounceOut, // حركة ارتدادية
      animationSlideDistance: 70.0,
    );
  }

  /// Example 8: Using copyWith to modify
  static SideBarNavigationTheames modifiedTheme() {
    final baseTheme = SideBarNavigationTheames.light();
    
    return baseTheme.copyWith(
      layoutDirection: TextDirection.rtl,
      animationDuration: const Duration(milliseconds: 250),
      animationCurve: Curves.easeOutQuart,
      animationSlideDistance: 45.0,
    );
  }
}

/// Animation Settings Examples
class AnimationSettings {
  /// سرعات الحركة المختلفة
  static const Map<String, Duration> speeds = {
    'fast': Duration(milliseconds: 200),
    'normal': Duration(milliseconds: 300),
    'slow': Duration(milliseconds: 500),
    'slower': Duration(milliseconds: 800),
  };

  /// منحنيات الحركة المختلفة
  static const Map<String, Curve> curves = {
    'linear': Curves.linear,
    'easeIn': Curves.easeIn,
    'easeOut': Curves.easeOut,
    'easeInOut': Curves.easeInOut,
    'bounce': Curves.bounceOut,
    'elastic': Curves.elasticOut,
    'cubicIn': Curves.easeInCubic,
    'cubicOut': Curves.easeOutCubic,
    'fastOut': Curves.fastOutSlowIn,
  };

  /// مسافات الانزلاق
  static const List<double> slideDistances = [20.0, 40.0, 50.0, 60.0, 80.0, 100.0];

  /// Presets - إعدادات جاهزة
  static final Map<String, SideBarNavigationTheames> presets = {
    'default_ltr': SideBarNavigationTheames.light(
      layoutDirection: TextDirection.ltr,
    ),
    'default_rtl': SideBarNavigationTheames.light(
      layoutDirection: TextDirection.rtl,
    ),
    'fast_ltr': SideBarNavigationTheames.light(
      layoutDirection: TextDirection.ltr,
      animationDuration: const Duration(milliseconds: 200),
      animationCurve: Curves.easeOutQuad,
      animationSlideDistance: 40.0,
    ),
    'fast_rtl': SideBarNavigationTheames.light(
      layoutDirection: TextDirection.rtl,
      animationDuration: const Duration(milliseconds: 200),
      animationCurve: Curves.easeOutQuad,
      animationSlideDistance: 40.0,
    ),
    'smooth_ltr': SideBarNavigationTheames.light(
      layoutDirection: TextDirection.ltr,
      animationDuration: const Duration(milliseconds: 500),
      animationCurve: Curves.easeInOutCubic,
      animationSlideDistance: 60.0,
    ),
    'smooth_rtl': SideBarNavigationTheames.light(
      layoutDirection: TextDirection.rtl,
      animationDuration: const Duration(milliseconds: 500),
      animationCurve: Curves.easeInOutCubic,
      animationSlideDistance: 60.0,
    ),
  };
}
