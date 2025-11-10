import 'package:JoDija_tamplites/tampletes/screens/navigation_app/screens/content_screens.dart';
import 'package:JoDija_tamplites/tampletes/screens/routed_contral_panal/models/route_item.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'providers/sidebar_provider.dart';
import 'theam/theam.dart';
import 'models/app_bar_config.dart';
import 'models/sidebar_header_config.dart';

/// تطبيق التنقل بالشريط الجانبي
class SidebarNavigationControlPanale extends StatelessWidget {
  final List<RouteItem>? sidebarItems;
  final SideBarNavigationTheames theme;

  // App bar configuration
  final bool showAppBarOnLargeScreen;
  final AppBarConfig? smallScreenAppBar;
  final AppBarConfig? largeScreenAppBar;
  final bool isSidbarInCulomn;
  // final List<RouteBase>? routes;
  final String? initRouter;
final bool? debugShowCheckedModeBanner;
  // Sidebar header configuration
  final SidebarHeaderConfig? sidebarHeader;
  Widget? errorScreen;
  // Constructor with customizable theme properties
  SidebarNavigationControlPanale({
    super.key,
    this.sidebarItems,
    // Theme properties
    Color? backgroundColor,
    bool isSidebarInCulomn = false,
    Color? selectedBackgroundColor,
    Color? textColor,
    Color? selectedTextColor,
    Color? iconColor,
    Color? selectedIconColor,
    double? fontSize,
    FontWeight? normalFontWeight,
    FontWeight? selectedFontWeight,
    double? itemHeight,
    double? itemWidth,
    bool  debugShowCheckedModeBanner = false,
    EdgeInsetsGeometry? itemPadding,
    bool useDarkTheme = false,
    // List<RouteBase>? routes,
    String? initRouter,
    this.  errorScreen,

    // App bar configuration
    this.showAppBarOnLargeScreen = false,
    this.smallScreenAppBar,
    this.largeScreenAppBar,

    // Sidebar header configuration
    this.sidebarHeader,
  })  : isSidbarInCulomn = isSidebarInCulomn,
        // this.
         debugShowCheckedModeBanner = debugShowCheckedModeBanner,
        // routes = routes,
        initRouter = initRouter,
        theme = SideBarNavigationTheames().copyWith(
          isSidebarInCulomn: isSidebarInCulomn,
          itemWidth: itemWidth,
          backgroundColor: backgroundColor,
          selectedBackgroundColor: selectedBackgroundColor,
          textColor: textColor,
          selectedTextColor: selectedTextColor,
          iconColor: iconColor,
          selectedIconColor: selectedIconColor,
          fontSize: fontSize,
          normalFontWeight: normalFontWeight,
          selectedFontWeight: selectedFontWeight,
          itemHeight: itemHeight,
          itemPadding: itemPadding,
        ) {
    // Apply dark theme if requested
    if (useDarkTheme) {
      theme.setDarkTheme();
    }
  }

  // Method to provide the theme to child widgets
  static SideBarNavigationTheames getTheme(BuildContext context) {
    return Provider.of<SideBarNavigationTheames>(context, listen: false);
  }

  // Method to get app bar configuration
  static AppBarConfig? getAppBarConfig(
      BuildContext context, bool isSmallScreen) {
    final instance =
        Provider.of<SidebarNavigationControlPanale>(context, listen: false);
    return isSmallScreen
        ? instance.smallScreenAppBar
        : instance.largeScreenAppBar;
  }

  // Method to get sidebar header configuration
  static SidebarHeaderConfig? getSidebarHeader(BuildContext context) {
    final instance =
        Provider.of<SidebarNavigationControlPanale>(context, listen: false);
    return instance.sidebarHeader;
  }

  // Method to check if large screen should show app bar
  static bool shouldShowAppBarOnLargeScreen(BuildContext context) {
    final instance =
        Provider.of<SidebarNavigationControlPanale>(context, listen: false);
    return instance.showAppBarOnLargeScreen;
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        // Add AuthProvider first
        // ChangeNotifierProvider(create: (_) => AuthProvider()),

        // SidebarProvider depends on AuthProvider
        ChangeNotifierProvider(
          create: (_) => SidebarProvider(
            sidebarItems: sidebarItems ??
                [
                  // Default sidebar items
                  RouteItem(
                    path: '/dashboard',
                    label: 'لوحة التحكم',
                    icon: Icons.dashboard,
                    content: HomeContent(),
                    isSideBarRouted: true,
                  ),
                  RouteItem(
                    path: '/profile',
                    label: 'الملف الشخصي',
                    icon: Icons.person,
                    content: ProfileContent(),
                    isSideBarRouted: true,
                  ),
                  RouteItem(
                    path: '/settings',
                    label: 'الإعدادات',
                    icon: Icons.settings,
                    content: SettingsContent(),
                    isSideBarRouted: true,
                  ),
                ],
            errorConent: this.errorScreen
          ),
        ),

        // Provide the theme instance
        Provider<SideBarNavigationTheames>.value(value: theme),

        // Provide the control panel instance
        Provider<SidebarNavigationControlPanale>.value(value: this),
      ],
      child: Consumer<SidebarProvider>(
        builder: (context, sidebarProvider, child) {
          return MaterialApp.router(
            title: 'تطبيق مع شريط جانبي',
            theme: ThemeData(
              colorScheme:
                  ColorScheme.fromSeed(seedColor: theme.selectedTextColor),
              useMaterial3: true,
            ),
            routerConfig: sidebarProvider.createRouter(
              initRouter
                // routes: routes,
                // authProvider: authProvider,
                ),
            debugShowCheckedModeBanner:  this.debugShowCheckedModeBanner??false  ,
          );
        },
      ),
    );
  }
}
