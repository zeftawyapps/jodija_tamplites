import 'package:flutter/material.dart';
import '../laaunser.dart';
import '../theam/theam.dart';
import '../utils/app_shell_utils.dart';
import 'app_bar_config.dart';
import 'sidebar_header_config.dart';

/// كائن وسيط يحمل الحالة المجمعة لبيانات القالب التكيفي (App Shell Runtime Data)
///
/// يستخرج البيانات المجمعة من [AdaptiveAppShell] ويتيح قراءتها وتمريرها بسهولة
/// عبر الودجات والشاشات الداخلية دون الحاجة لتهيئة متكررة.
///
/// English Description:
/// Immutable runtime state snapshot holding theme configurations, app bar models,
/// text directions, animation parameters, and locale metadata for [AdaptiveAppShell].
class AppShellData {
  // Theme
  final SideBarNavigationTheames theme;

  // App bar configuration
  final AppBarConfig? smallScreenAppBar;
  final AppBarConfig? largeScreenAppBar;
  final bool showAppBarOnSmallScreen;
  final bool showAppBarOnLargeScreen;

  // Sidebar configuration
  final SidebarHeaderConfig? sidebarHeader;

  // Layout & Animation
  final TextDirection layoutDirection;
  final Duration animationDuration;
  final Curve animationCurve;
  final double animationSlideDistance;

  // App settings
  final String languageCode;
  final bool isDarkMode;
  final String titleApp;
  final bool isSidbarInCulomn;

  AppShellData._({
    required this.theme,
    required this.smallScreenAppBar,
    required this.largeScreenAppBar,
    required this.showAppBarOnSmallScreen,
    required this.showAppBarOnLargeScreen,
    required this.sidebarHeader,
    required this.layoutDirection,
    required this.animationDuration,
    required this.animationCurve,
    required this.animationSlideDistance,
    required this.languageCode,
    required this.isDarkMode,
    required this.titleApp,
    required this.isSidbarInCulomn,
  });

  /// إنشاء AppShellData من AdaptiveAppShell instance
  factory AppShellData.fromAppShell(
      AdaptiveAppShell appShell, BuildContext? context) {
    return AppShellData._(
      theme: appShell.createSidebarTheme(),
      smallScreenAppBar: appShell.smallScreenAppBar,
      largeScreenAppBar: appShell.largeScreenAppBar,
      showAppBarOnSmallScreen: appShell.showAppBarOnSmallScreen,
      showAppBarOnLargeScreen: appShell.showAppBarOnLargeScreen,
      sidebarHeader: appShell.sidebarHeader,
      layoutDirection: context != null
          ? AdaptiveAppShell.getLayoutDirection(context)
          : AppShellUtils.getLayoutDirection(appShell.languageCode),
      animationDuration: appShell.animationDuration,
      animationCurve: appShell.animationCurve,
      animationSlideDistance: appShell.animationSlideDistance,
      languageCode: appShell.languageCode,
      isDarkMode: appShell.isDarkMode,
      titleApp: appShell.titleApp,
      isSidbarInCulomn: appShell.isSidbarInCulomn,
    );
  }

  /// إنشاء instance من Singleton (يتطلب context)
  static AppShellData fromContext(BuildContext context) {
    return AppShellData.fromAppShell(AdaptiveAppShell.instance, context);
  }

  /// إنشاء instance من Singleton بدون context
  static AppShellData get instance {
    return AppShellData.fromAppShell(AdaptiveAppShell.instance, null);
  }
}
