import 'package:JoDija_tamplites/tampletes/screens/routed_contral_panal/models/route_item.dart';
import 'package:JoDija_tamplites/tampletes/screens/routed_contral_panal/providers/status_provider.dart';
import 'package:JoDija_tamplites/util/localization/loaclized_init.dart';
import 'package:JoDija_tamplites/util/localization/loclization/laoclization.inits.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/sidebar_provider.dart';
import 'providers/settings_provider.dart';
import 'theam/theam.dart';
import 'models/app_bar_config.dart';
import 'models/sidebar_header_config.dart';
import 'utils/app_shell_utils.dart';

/// Adaptive Application Shell - يتكيف مع أحجام الشاشات المختلفة
class AdaptiveAppShell extends StatelessWidget {
  // Singleton pattern
  static AdaptiveAppShell? _instance;
  static AdaptiveAppShell get instance {
    if (_instance == null) {
      throw Exception(
          'AdaptiveAppShell not initialized. Please create an instance first.');
    }
    return _instance!;
  }

  final List<RouteItem>? sidebarItems;

  // Theme configuration
  final ThemeData? lightTheme;
  final ThemeData? darkTheme;
  final bool isDarkMode;

  // App bar configuration
  final bool showAppBarOnSmallScreen;
  final bool showAppBarOnLargeScreen;
  final AppBarConfig? smallScreenAppBar;
  final AppBarConfig? largeScreenAppBar;
  final bool isSidbarInCulomn;
  final String? initRouter;
  final bool isInBottomNavBar;
  final bool debugShowCheckedModeBanner;

  // Sidebar header configuration
  final SidebarHeaderConfig? sidebarHeader;
  final Widget? errorScreen;

  final String languageCode;
  final Map<String, AppLocalizationsInit> loclizationLangs;
  final List<LocalizationsDelegate<dynamic>>? extraLocalizationsDelegates;

  // Sidebar styling properties
  final Color? sidebarBackgroundColor;
  final Color? sidebarSelectedColor;
  final Color? sidebarHoverColor;

  // Text colors for different states
  final Color? sidebarTextColor;
  final Color? sidebarSelectedTextColor;
  final Color? sidebarHoverTextColor;

  // Icon colors for different states
  final Color? sidebarIconColor;
  final Color? sidebarSelectedIconColor;
  final Color? sidebarHoverIconColor;

  // Expanded state colors for ExpansionTile
  final Color? sidebarExpandedBackgroundColor;
  final Color? sidebarExpandedTextColor;
  final Color? sidebarExpandedIconColor;
  final Color? sidebarExpandedArrowColor;

  final double? sidebarItemHeight;
  final double? sidebarFontSize;
  final String titleApp;

  // Animation properties
  final Duration animationDuration;
  final Curve animationCurve;
  final double animationSlideDistance;
  final SidBarAnimationType animationType;

  // Internal layout direction (calculated from languageCode)
  late final TextDirection _layoutDirection;

  // Constructor
  AdaptiveAppShell({
    super.key,
    this.titleApp = "تطبيقي",
    this.sidebarItems,
    this.isInBottomNavBar = false,
    this.languageCode = 'ar',
    this.isSidbarInCulomn = false,
    this.debugShowCheckedModeBanner = false,
    this.initRouter,
    this.errorScreen,
    required this.loclizationLangs,
    this.extraLocalizationsDelegates,

    // Theme configuration
    this.lightTheme,
    this.darkTheme,
    this.isDarkMode = false,

    // App bar configuration
    this.showAppBarOnSmallScreen = true,
    this.showAppBarOnLargeScreen = false,
    this.smallScreenAppBar,
    this.largeScreenAppBar,

    // Sidebar header configuration
    this.sidebarHeader,

    // Sidebar styling
    this.sidebarBackgroundColor,
    this.sidebarSelectedColor,
    this.sidebarHoverColor,

    // Text colors
    this.sidebarTextColor,
    this.sidebarSelectedTextColor,
    this.sidebarHoverTextColor,

    // Icon colors
    this.sidebarIconColor,
    this.sidebarSelectedIconColor,
    this.sidebarHoverIconColor,

    // Expanded colors
    this.sidebarExpandedBackgroundColor,
    this.sidebarExpandedTextColor,
    this.sidebarExpandedIconColor,
    this.sidebarExpandedArrowColor,
    this.sidebarItemHeight,
    this.sidebarFontSize,

    // Animation properties
    this.animationDuration = const Duration(milliseconds: 300),
    this.animationCurve = Curves.easeOutCubic,
    this.animationSlideDistance = 50.0,
    this.animationType = SidBarAnimationType.slideAndFade,
  }) {
    // Calculate layoutDirection from languageCode using utility
    _layoutDirection = AppShellUtils.getLayoutDirection(languageCode);
    // Save instance as singleton
    _instance = this;
  }

  // Method to get the current theme (light or dark)
  ThemeData getCurrentTheme(BuildContext context) {
    bool isDarkMode =
        Provider.of<SettingsProvider>(context, listen: false).isDarkMode;
    if (isDarkMode) {
      return darkTheme ?? ThemeData.dark(useMaterial3: true);
    } else {
      return lightTheme ?? ThemeData.light(useMaterial3: true);
    }
  }

  // Method to create SideBarNavigationTheames from current settings
  SideBarNavigationTheames createSidebarTheme() {
    return isDarkMode
        ? SideBarNavigationTheames.dark(
            titleApp: titleApp,
            isSidebarInCulomn: isSidbarInCulomn,
            layoutDirection: _layoutDirection,
            animationDuration: animationDuration,
            animationCurve: animationCurve,
            animationSlideDistance: animationSlideDistance,
            animationType: animationType,
            itemHeight: sidebarItemHeight,
            fontSize: sidebarFontSize,
            backgroundColor: sidebarBackgroundColor,
            selectedBackgroundColor: sidebarSelectedColor,
            hoverBackgroundColor: sidebarHoverColor,
            textColor: sidebarTextColor,
            selectedTextColor: sidebarSelectedTextColor,
            hoverTextColor: sidebarHoverTextColor,
            iconColor: sidebarIconColor,
            selectedIconColor: sidebarSelectedIconColor,
            hoverIconColor: sidebarHoverIconColor,
            expandedBackgroundColor: sidebarExpandedBackgroundColor,
            expandedTextColor: sidebarExpandedTextColor,
            expandedIconColor: sidebarExpandedIconColor,
            expandedArrowColor: sidebarExpandedArrowColor,
          )
        : SideBarNavigationTheames.light(
            titleApp: titleApp,
            isSidebarInCulomn: isSidbarInCulomn,
            layoutDirection: _layoutDirection,
            animationDuration: animationDuration,
            animationCurve: animationCurve,
            animationSlideDistance: animationSlideDistance,
            animationType: animationType,
            itemHeight: sidebarItemHeight,
            fontSize: sidebarFontSize,
            backgroundColor: sidebarBackgroundColor,
            selectedBackgroundColor: sidebarSelectedColor,
            hoverBackgroundColor: sidebarHoverColor,
            textColor: sidebarTextColor,
            selectedTextColor: sidebarSelectedTextColor,
            hoverTextColor: sidebarHoverTextColor,
            iconColor: sidebarIconColor,
            selectedIconColor: sidebarSelectedIconColor,
            hoverIconColor: sidebarHoverIconColor,
            expandedBackgroundColor: sidebarExpandedBackgroundColor,
            expandedTextColor: sidebarExpandedTextColor,
            expandedIconColor: sidebarExpandedIconColor,
            expandedArrowColor: sidebarExpandedArrowColor,
          );
  }

  // Method to provide the theme to child widgets
  static SideBarNavigationTheames getTheme(BuildContext context) {
    return Provider.of<SideBarNavigationTheames>(context, listen: false);
  }

  // Method to get settings provider
  static SettingsProvider getSettings(BuildContext context) {
    return Provider.of<SettingsProvider>(context, listen: false);
  }

  // Method to get app bar configuration
  static AppBarConfig? getAppBarConfig(
      BuildContext context, bool isSmallScreen) {
    final instance = Provider.of<AdaptiveAppShell>(context, listen: false);
    return isSmallScreen
        ? instance.smallScreenAppBar
        : instance.largeScreenAppBar;
  }

  // Method to get sidebar header configuration
  static SidebarHeaderConfig? getSidebarHeader(BuildContext context) {
    final instance = Provider.of<AdaptiveAppShell>(context, listen: false);
    return instance.sidebarHeader;
  }

  // Method to check if large screen should show app bar
  static bool shouldShowAppBarOnLargeScreen(BuildContext context) {
    final instance = Provider.of<AdaptiveAppShell>(context, listen: false);
    return instance.showAppBarOnLargeScreen;
  }

  // Method to get animation properties
  static TextDirection getLayoutDirection(BuildContext context) {
    final instance = Provider.of<AdaptiveAppShell>(context, listen: false);
    return instance._layoutDirection;
  }

  static Duration getAnimationDuration(BuildContext context) {
    final instance = Provider.of<AdaptiveAppShell>(context, listen: false);
    return instance.animationDuration;
  }

  static Curve getAnimationCurve(BuildContext context) {
    final instance = Provider.of<AdaptiveAppShell>(context, listen: false);
    return instance.animationCurve;
  }

  static double getAnimationSlideDistance(BuildContext context) {
    final instance = Provider.of<AdaptiveAppShell>(context, listen: false);
    return instance.animationSlideDistance;
  }

  static SidBarAnimationType getAnimationType(BuildContext context) {
    final instance = Provider.of<AdaptiveAppShell>(context, listen: false);
    return instance.animationType;
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        // Add AuthProvider first
        // ChangeNotifierProvider(create: (_) => AuthProvider()),

        // AppShellRouterProvider manages routing
        ChangeNotifierProvider(
          create: (_) => AppShellRouterProvider(
              sidebarItems: sidebarItems ??
                [
 ], errorConent: this.errorScreen),
        ),

        // SettingsProvider manages app settings
        ChangeNotifierProvider(
          create: (_) => SettingsProvider(
            languageCode: languageCode,
            isDarkMode: isDarkMode,
          ),
        ),

        ChangeNotifierProvider(
          create: (_) => StatusProvider(),
        ),

        // Provide the sidebar theme instance
        Provider<SideBarNavigationTheames>.value(
          value: createSidebarTheme(),
        ),

        // Provide the control panel instance
        Provider<AdaptiveAppShell>.value(value: this),
      ],
      child: Consumer2<AppShellRouterProvider, SettingsProvider>(
        builder: (context, appShellProvider, settingsProvider, child) {
          // Update localization when language changes
          LocalizationInit localizationInit =
              LocalizationInit(loclizationLangs);
          localizationInit.setAppLocal(settingsProvider.languageCode);

          return MaterialApp.router(
            supportedLocales: AppLocalizationsInit().supportedLocales,
            locale: Locale(settingsProvider.languageCode),
            localizationsDelegates: [
              ...AppLocalizationsInit().localizationsDelegates,
              if (this.extraLocalizationsDelegates != null)
                ...this.extraLocalizationsDelegates!,
            ],
            title: this.titleApp,
            theme: getCurrentTheme(context),
            darkTheme: darkTheme ?? ThemeData.dark(useMaterial3: true),
            themeMode:
                settingsProvider.isDarkMode ? ThemeMode.dark : ThemeMode.light,
            routerConfig: appShellProvider.createRouter(initRouter),
            debugShowCheckedModeBanner: debugShowCheckedModeBanner,
          );
        },
      ),
    );
  }

//  void setAppLocal(String localCode) {
//     LocalizationConfig localizationConfig =
//     LocalizationConfig(localizedValues:  {}
//     );
//     localizationConfig.setLocale(Locale(localCode));
//     Translation().getlocal();

//   }
}
