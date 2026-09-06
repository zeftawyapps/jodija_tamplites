import 'package:flutter/material.dart';
import '../models/app_bar_config.dart';
import '../models/app_shell_data.dart';
import '../theam/theam.dart';

/// ميكسين للوصول المباشر لخصائص القالب التكيفي (App Shell State Mixin)
///
/// يُمكّن أي State في StatefulWidget من القراءة المباشرة لخصائص [AdaptiveAppShell]
/// مثل الثيم، اتجاه النص، أحجام الشاشة، وإعدادات الـ AppBar وحركات الأنيميشن.
///
/// English Description:
/// State mixin granting direct convenience access to [AdaptiveAppShell] runtime configurations,
/// responsive screen checks, layout directions, and animation curves.
mixin AppShellMixin<T extends StatefulWidget> on State<T> {
  
  /// الحصول على بيانات AppShell (يتم إنشاؤها من Singleton)
  AppShellData get appShellData => AppShellData.fromContext(context);
  
  /// الحصول على theme الحالي للسايدبار (غير nullable)
  SideBarNavigationTheames get theme => appShellData.theme;
  
  /// التحقق من حجم الشاشة
  bool get isScreenSmall {
    final screenWidth = MediaQuery.of(context).size.width;
    return screenWidth < 800;
  }
  
  /// الحصول على app bar config للشاشات الصغيرة
  AppBarConfig? get smallScreenAppBarConfig => appShellData.smallScreenAppBar;
  
  /// الحصول على app bar config للشاشات الكبيرة
  AppBarConfig? get largeScreenAppBarConfig => appShellData.largeScreenAppBar;
  
  /// التحقق من عرض app bar في الشاشات الصغيرة
  bool get showAppBarOnSmallScreen => appShellData.showAppBarOnSmallScreen;
  
  /// التحقق من عرض app bar في الشاشات الكبيرة
  bool get showAppBarOnLargeScreen => appShellData.showAppBarOnLargeScreen;
  
  /// الحصول على layout direction
  TextDirection get layoutDirection => appShellData.layoutDirection;
  
  /// الحصول على animation duration
  Duration get animationDuration => appShellData.animationDuration;
  
  /// الحصول على animation curve
  Curve get animationCurve => appShellData.animationCurve;
  
  /// الحصول على animation slide distance
  double get animationSlideDistance => appShellData.animationSlideDistance;
  
  /// الحصول على sidebar header configuration
  dynamic get sidebarHeader => appShellData.sidebarHeader;
  
  /// الحصول على language code
  String get languageCode => appShellData.languageCode;
  
  /// الحصول على dark mode status
  bool get isDarkMode => appShellData.isDarkMode;
  
  /// الحصول على title التطبيق
  String get titleApp => appShellData.titleApp;
  
  /// التحقق من نمط السايدبار (عمودي أو قابل للطي)
  bool get isSidbarInCulomn => appShellData.isSidbarInCulomn;
}
