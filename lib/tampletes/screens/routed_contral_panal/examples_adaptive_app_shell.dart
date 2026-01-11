import 'package:flutter/material.dart';
import 'laaunser.dart';

/// أمثلة على كيفية استخدام خصائص الحركة في AdaptiveAppShell

class AdaptiveAppShellUsageExamples {
  
  /// مثال 1: الإعدادات الافتراضية (LTR)
  static Widget example1_DefaultLTR() {
    return AdaptiveAppShell(
      // Using default light theme
      loclizationLangs: {},
      // الخصائص الافتراضية:
      // languageCode: 'en' → layoutDirection: ltr (تلقائي)
      // animationDuration: Duration(milliseconds: 300),
      // animationCurve: Curves.easeOutCubic,
      // animationSlideDistance: 50.0,
    );
  }

  /// مثال 2: للعربية (RTL) - يتم حسابها تلقائياً من languageCode
  static Widget example2_ArabicRTL() {
    return AdaptiveAppShell(
      // Using default light theme
      loclizationLangs: {},
      languageCode: 'ar',  // ✅ layoutDirection يُحسب تلقائياً → RTL
      
      // خصائص الحركة:
      // layoutDirection: يُحسب من languageCode (داخلي)
      animationDuration: const Duration(milliseconds: 300),
      animationCurve: Curves.easeOutCubic,
      animationSlideDistance: 50.0,
    );
  }

  /// مثال 3: حركة سريعة جداً
  static Widget example3_FastAnimation() {
    return AdaptiveAppShell(
      // Using default light theme
      loclizationLangs: {},
      languageCode: 'ar',  // ✅ RTL تلقائياً
      
      animationDuration: const Duration(milliseconds: 150),  // سريع جداً
      animationCurve: Curves.easeOutQuad,
      animationSlideDistance: 30.0,  // حركة قليلة
    );
  }

  /// مثال 4: حركة بطيئة وناعمة جداً
  static Widget example4_SmoothSlowAnimation() {
    return AdaptiveAppShell(
      // Using default light theme
      loclizationLangs: {},
      languageCode: 'ar',  // ✅ RTL تلقائياً
      
      animationDuration: const Duration(milliseconds: 600),  // بطيء جداً
      animationCurve: Curves.easeInOutCubic,  // ناعم جداً
      animationSlideDistance: 80.0,  // حركة كبيرة
    );
  }

  /// مثال 5: حركة ارتدادية (مرحة)
  static Widget example5_BounceAnimation() {
    return AdaptiveAppShell(
      // Using default light theme
      loclizationLangs: {},
      languageCode: 'ar',  // ✅ RTL تلقائياً
      
      animationDuration: const Duration(milliseconds: 500),
      animationCurve: Curves.bounceOut,  // ارتدادية
      animationSlideDistance: 70.0,
    );
  }

  /// مثال 6: حركة مرنة (elasticOut)
  static Widget example6_ElasticAnimation() {
    return AdaptiveAppShell(
      // Using default light theme
      loclizationLangs: {},
      languageCode: 'ar',  // ✅ RTL تلقائياً
      
      animationDuration: const Duration(milliseconds: 700),
      animationCurve: Curves.elasticOut,  // مرنة
      animationSlideDistance: 60.0,
    );
  }

  /// مثال 7: ثيم داكن مع حركة RTL (من العربية)
  static Widget example7_DarkThemeRTL() {
    return AdaptiveAppShell(
      isDarkMode: true,
      loclizationLangs: {},
      languageCode: 'ar',  // ✅ RTL تلقائياً
      
      animationDuration: const Duration(milliseconds: 350),
      animationCurve: Curves.easeOutCubic,
      animationSlideDistance: 55.0,
    );
  }

  /// مثال 8: حركة خطية (بدون تسارع)
  static Widget example8_LinearAnimation() {
    return AdaptiveAppShell(
      // Using default light theme
      loclizationLangs: {},
      languageCode: 'ar',  // ✅ RTL تلقائياً
      
      animationDuration: const Duration(milliseconds: 400),
      animationCurve: Curves.linear,  // خطية
      animationSlideDistance: 50.0,
    );
  }

  /// مثال 9: كل الخيارات مع appbar و sidebar
  static Widget example9_CompleteSetup() {
    return AdaptiveAppShell(
      // Using default light theme
      loclizationLangs: {},
      languageCode: 'ar',  // ✅ layoutDirection: RTL تلقائياً
      isSidbarInCulomn: false,
      
      // Animation properties (layoutDirection حسابي تلقائياً)
      animationDuration: const Duration(milliseconds: 350),
      animationCurve: Curves.easeOutCubic,
      animationSlideDistance: 60.0,
      
      // AppBar configuration
      showAppBarOnLargeScreen: true,
      
      // Sidebar header
      // sidebarHeader: SidebarHeaderConfig(...),
      
      // Error screen
      // errorScreen: YourErrorWidget(),
    );
  }

  /// مثال 10: Dynamic animation based on locale
  static Widget example10_DynamicLocale({required bool isArabic}) {
    return AdaptiveAppShell(
      // Using default light theme
      loclizationLangs: {},
      languageCode: isArabic ? 'ar' : 'en',
      // ✅ layoutDirection يُحسب تلقائياً من اللغة
      
      animationDuration: const Duration(milliseconds: 300),
      animationCurve: Curves.easeOutCubic,
      animationSlideDistance: 50.0,
    );
  }
}

/// استخدام في main.dart
void main() {
  runApp(
    MaterialApp(
      home: Scaffold(
        body: AdaptiveAppShellUsageExamples.example2_ArabicRTL(),
      ),
    ),
  );
}

/// الخصائص المتاحة للتحكم:
/// 
/// 1. layoutDirection (TextDirection)
///    - TextDirection.ltr: حركة من اليسار لليمين
///    - TextDirection.rtl: حركة من اليمين لليسار
///
/// 2. animationDuration (Duration)
///    - مدة الحركة الإجمالية
///    - مثال: Duration(milliseconds: 300)
///
/// 3. animationCurve (Curve)
///    - Curves.easeOutCubic: سريع ثم بطيء (موصى به)
///    - Curves.linear: منتظم
///    - Curves.easeIn: بطيء ثم سريع
///    - Curves.easeOut: سريع ثم بطيء
///    - Curves.easeInOut: ناعم جداً
///    - Curves.bounceOut: ارتدادي
///    - Curves.elasticOut: مرن
///
/// 4. animationSlideDistance (double)
///    - مسافة الانزلاق الأفقي
///    - 30: قليل
///    - 50: متوسط (افتراضي)
///    - 80: كبير
///    - 100+: كبير جداً
