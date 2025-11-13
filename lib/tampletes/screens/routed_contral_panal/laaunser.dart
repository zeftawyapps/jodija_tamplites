import 'package:JoDija_tamplites/tampletes/screens/routed_contral_panal/models/route_item.dart';
import 'package:JoDija_tamplites/util/localization/loaclized_init.dart';
import 'package:JoDija_tamplites/util/localization/loclization/laoclization.inits.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/sidebar_provider.dart';
import 'providers/settings_provider.dart';
import 'theam/theam.dart';
import 'models/app_bar_config.dart';
import 'models/sidebar_header_config.dart';

/// Adaptive Application Shell - يتكيف مع أحجام الشاشات المختلفة
class AdaptiveAppShell extends StatelessWidget {
  final List<RouteItem>? sidebarItems;
  final SideBarNavigationTheames theme;

  // App bar configuration
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

  // Constructor with theme parameter
    AdaptiveAppShell({
    super.key,
    this.sidebarItems,
    this.isInBottomNavBar = false,
    this.languageCode = 'ar',
    this.isSidbarInCulomn = false,
    this.debugShowCheckedModeBanner = false,
    this.initRouter,
    this.errorScreen,
    required this.loclizationLangs,
    required this.theme, // Theme is now required
    
    // App bar configuration
    this.showAppBarOnLargeScreen = false,
    this.smallScreenAppBar,
    this.largeScreenAppBar,

    // Sidebar header configuration
    this.sidebarHeader,
  });

  // Factory constructor for light theme
   

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
    final instance =
        Provider.of<AdaptiveAppShell>(context, listen: false);
    return isSmallScreen
        ? instance.smallScreenAppBar
        : instance.largeScreenAppBar;
  }

  // Method to get sidebar header configuration
  static SidebarHeaderConfig? getSidebarHeader(BuildContext context) {
    final instance =
        Provider.of<AdaptiveAppShell>(context, listen: false);
    return instance.sidebarHeader;
  }

  // Method to check if large screen should show app bar
  static bool shouldShowAppBarOnLargeScreen(BuildContext context) {
    final instance =
        Provider.of<AdaptiveAppShell>(context, listen: false);
    return instance.showAppBarOnLargeScreen;
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
 ],
            errorConent: this.errorScreen
          ),
        ),

        // SettingsProvider manages app settings
        ChangeNotifierProvider(
          create: (_) => SettingsProvider(
            languageCode: languageCode,
            isDarkMode: theme == SideBarNavigationTheames.dark(),
          ),
        ),

        // Provide the theme instance
        Provider<SideBarNavigationTheames>.value(value: theme),

        // Provide the control panel instance
        Provider<AdaptiveAppShell>.value(value: this),
      ],
      child: Consumer2<AppShellRouterProvider, SettingsProvider>(
        builder: (context, appShellProvider, settingsProvider, child) {
          // Update localization when language changes
          LocalizationInit localizationInit = LocalizationInit(loclizationLangs);
          localizationInit.setAppLocal(settingsProvider.languageCode);

          return MaterialApp.router(
            supportedLocales: AppLocalizationsInit().supportedLocales,
            locale: Locale(settingsProvider.languageCode),
            localizationsDelegates: AppLocalizationsInit().localizationsDelegates,
            title: 'تطبيق مع شريط جانبي',
            theme: settingsProvider.isDarkMode
                ? ThemeData.dark(useMaterial3: true).copyWith(
                    colorScheme: ColorScheme.fromSeed(
                      seedColor: theme.selectedTextColor,
                      brightness: Brightness.dark,
                    ),
                  )
                : ThemeData.light(useMaterial3: true).copyWith(
                    colorScheme: ColorScheme.fromSeed(
                      seedColor: theme.selectedTextColor,
                      brightness: Brightness.light,
                    ),
                  ),
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
