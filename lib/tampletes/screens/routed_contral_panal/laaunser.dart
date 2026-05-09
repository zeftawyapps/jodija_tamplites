import 'package:JoDija_tamplites/tampletes/screens/routed_contral_panal/models/route_item.dart';
import 'package:JoDija_tamplites/tampletes/screens/routed_contral_panal/providers/status_provider.dart';
import 'package:JoDija_tamplites/util/localization/loaclized_init.dart';
import 'package:JoDija_tamplites/util/localization/loclization/laoclization.inits.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
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

  /// قائمة العناصر (الروابط) التي سيتم عرضها في القائمة الجانبية (Sidebar).
  /// The list of elements (routes) that will be displayed in the sidebar.
  final List<RouteItem>? sidebarItems;

  // Theme configuration
  /// الثيم الفاتح للتطبيق.
  /// The light theme of the application.
  final ThemeData? lightTheme;

  /// الثيم الداكن للتطبيق.
  /// The dark theme of the application.
  final ThemeData? darkTheme;

  /// حالة التطبيق الحالية (هل هو في الوضع الداكن أم لا).
  /// The current application state indicating whether dark mode is enabled.
  final bool isDarkMode;

  // App bar configuration
  /// هل يتم عرض الـ AppBar في الشاشات الصغيرة (الجوال).
  /// Whether to display the app bar on small screens (mobile).
  final bool showAppBarOnSmallScreen;

  /// هل يتم عرض الـ AppBar في الشاشات الكبيرة (الكمبيوتر/التابلت).
  /// Whether to display the app bar on large screens (desktop/tablet).
  final bool showAppBarOnLargeScreen;

  /// إعدادات الـ AppBar للشاشات الصغيرة.
  /// The app bar configuration for small screens.
  final AppBarConfig? smallScreenAppBar;

  /// إعدادات الـ AppBar للشاشات الكبيرة.
  /// The app bar configuration for large screens.
  final AppBarConfig? largeScreenAppBar;

  /// تحديد ما إذا كانت القائمة الجانبية تُعرض كـ Column بدلاً من شكلها الافتراضي الموسع (Expansion Tiles).
  /// Whether the sidebar should be rendered as a Column instead of its default Expansion Tiles format.
  final bool isSidbarInCulomn;

  /// المسار (Route) المبدئي الذي سيفتح عليه التطبيق أول مرة.
  /// The initial route the application will open on first launch.
  final String? initRouter;

  /// هل التطبيق يعمل بداخل Bottom Navigation Bar.
  /// Whether the application is wrapped inside a Bottom Navigation Bar.
  final bool isInBottomNavBar;

  /// هل يتم عرض شريط الـ "Debug" الأحمر في أعلى الشاشة.
  /// Whether to display the red "Debug" banner at the top of the screen.
  final bool debugShowCheckedModeBanner;

  // Sidebar header configuration
  /// إعدادات الترويسة (Header) الخاصة بالقائمة الجانبية.
  /// The header configuration for the sidebar.
  final SidebarHeaderConfig? sidebarHeader;

  /// الشاشة التي تظهر في حالة حدوث خطأ أو صفحة غير موجودة (404).
  /// The screen that appears in case of an error or page not found (404).
  final Widget? errorScreen;

  /// رمز اللغة الحالي للتطبيق (مثال: 'ar' أو 'en').
  /// The current language code of the application (e.g., 'ar' or 'en').
  final String languageCode;

  /// خريطة لتهيئة اللغات المتاحة للترجمة.
  /// A map defining the available languages for localization.
  final Map<String, AppLocalizationsInit> loclizationLangs;

  /// ملفات الترجمة الإضافية التي قد تحتاج إضافتها للتطبيق.
  /// Additional localization delegates needed for the application.
  final List<LocalizationsDelegate<dynamic>>? extraLocalizationsDelegates;

  // Sidebar styling properties
  /// لون خلفية القائمة الجانبية.
  /// The background color of the sidebar.
  final Color? sidebarBackgroundColor;

  /// لون الخلفية للعنصر المحدد (النشط) في القائمة الجانبية.
  /// The background color of the selected (active) item in the sidebar.
  final Color? sidebarSelectedColor;

  /// لون الخلفية للعنصر عند تمرير الماوس عليه (Hover).
  /// The background color of the item when hovered.
  final Color? sidebarHoverColor;

  // Text colors for different states
  /// لون النص العادي لعناصر القائمة الجانبية.
  /// The default text color for sidebar items.
  final Color? sidebarTextColor;

  /// لون النص للعنصر المحدد (النشط).
  /// The text color of the selected (active) item.
  final Color? sidebarSelectedTextColor;

  /// لون النص للعنصر عند تمرير الماوس عليه.
  /// The text color of the item when hovered.
  final Color? sidebarHoverTextColor;

  // Icon colors for different states
  /// لون الأيقونات العادية في القائمة الجانبية.
  /// The default icon color for sidebar items.
  final Color? sidebarIconColor;

  /// لون الأيقونة للعنصر المحدد (النشط).
  /// The icon color of the selected (active) item.
  final Color? sidebarSelectedIconColor;

  /// لون الأيقونة للعنصر عند تمرير الماوس عليه.
  /// The icon color of the item when hovered.
  final Color? sidebarHoverIconColor;

  // Expanded state colors for ExpansionTile
  /// لون خلفية القسم المجمع (ExpansionTile) عندما يكون مفتوحاً.
  /// The background color of the grouped section (ExpansionTile) when expanded.
  final Color? sidebarExpandedBackgroundColor;

  /// لون نص القسم المجمع عندما يكون مفتوحاً.
  /// The text color of the grouped section when expanded.
  final Color? sidebarExpandedTextColor;

  /// لون أيقونة القسم المجمع عندما يكون مفتوحاً.
  /// The icon color of the grouped section when expanded.
  final Color? sidebarExpandedIconColor;

  /// لون سهم القسم المجمع عندما يكون مفتوحاً.
  /// The arrow color of the grouped section when expanded.
  final Color? sidebarExpandedArrowColor;

  /// ارتفاع كل عنصر داخل القائمة الجانبية.
  /// The height of each item inside the sidebar.
  final double? sidebarItemHeight;

  /// حجم الخط لعناصر القائمة الجانبية.
  /// The font size for sidebar items.
  final double? sidebarFontSize;

  /// نوع الخط المستخدم في القائمة الجانبية.
  /// The font family used in the sidebar.
  final String? sidebarFontFamily;

  /// اسم التطبيق الافتراضي أو عنوان الترويسة إذا لم يتم توفير صورة/شعار مخصص.
  /// The default app name or header title if no custom logo is provided.
  final String titleApp;

  // Animation properties
  /// مدة حركة الأنيميشن المستخدمة في التبديل وفتح العناصر.
  /// The duration of the animation used for switching and opening items.
  final Duration animationDuration;

  /// نوع المنحنى (Curve) للأنيميشن.
  /// The animation curve used.
  final Curve animationCurve;

  /// مسافة الانزلاق (Slide Distance) للأنيميشن أثناء الدخول أو الفتح.
  /// The slide distance for the animation upon entry or opening.
  final double animationSlideDistance;

  /// نوع الأنيميشن الخاص بدخول عناصر القائمة الجانبية (مثل: SlideAndFade).
  /// The type of animation for sidebar items entering (e.g., SlideAndFade).
  final SidBarAnimationType animationType;

  /// أدوات تتبع التوجيه (Navigator Observers) لرصد التنقل بين الشاشات.
  /// Navigator Observers for monitoring navigation between screens.
  final List<NavigatorObserver>? navigatorObservers;

  /// مزودات (Providers) أو (Blocs) إضافية تود تهيئتها على مستوى التطبيق بالكامل.
  /// Additional global Providers or Blocs to initialize across the application.
  final List<SingleChildWidget>? extraProvidersAndBlocs;

  // Internal layout direction (calculated from languageCode)
  late final TextDirection _layoutDirection;

    // Constructor
  AdaptiveAppShell({
    super.key,
    /// اسم التطبيق الافتراضي أو عنوان الترويسة إذا لم يتم توفير صورة/شعار مخصص.
    /// The default app name or header title if no custom logo is provided.
    this.titleApp = "تطبيقي",
    /// قائمة العناصر (الروابط) التي سيتم عرضها في القائمة الجانبية (Sidebar).
    /// The list of elements (routes) that will be displayed in the sidebar.
    this.sidebarItems,
    /// هل التطبيق يعمل بداخل Bottom Navigation Bar.
    /// Whether the application is wrapped inside a Bottom Navigation Bar.
    this.isInBottomNavBar = false,
    /// رمز اللغة الحالي للتطبيق (مثال: 'ar' أو 'en').
    /// The current language code of the application (e.g., 'ar' or 'en').
    this.languageCode = 'ar',
    /// تحديد ما إذا كانت القائمة الجانبية تُعرض كـ Column بدلاً من شكلها الافتراضي الموسع (Expansion Tiles).
    /// Whether the sidebar should be rendered as a Column instead of its default Expansion Tiles format.
    this.isSidbarInCulomn = false,
    /// هل يتم عرض شريط الـ "Debug" الأحمر في أعلى الشاشة.
    /// Whether to display the red "Debug" banner at the top of the screen.
    this.debugShowCheckedModeBanner = false,
    /// المسار (Route) المبدئي الذي سيفتح عليه التطبيق أول مرة.
    /// The initial route the application will open on first launch.
    this.initRouter,
    /// الشاشة التي تظهر في حالة حدوث خطأ أو صفحة غير موجودة (404).
    /// The screen that appears in case of an error or page not found (404).
    this.errorScreen,
    /// خريطة لتهيئة اللغات المتاحة للترجمة.
    /// A map defining the available languages for localization.
    required this.loclizationLangs,
    /// ملفات الترجمة الإضافية التي قد تحتاج إضافتها للتطبيق.
    /// Additional localization delegates needed for the application.
    this.extraLocalizationsDelegates,

    // Theme configuration
    /// الثيم الفاتح للتطبيق.
    /// The light theme of the application.
    this.lightTheme,
    /// الثيم الداكن للتطبيق.
    /// The dark theme of the application.
    this.darkTheme,
    /// حالة التطبيق الحالية (هل هو في الوضع الداكن أم لا).
    /// The current application state indicating whether dark mode is enabled.
    this.isDarkMode = false,

    // App bar configuration
    /// هل يتم عرض الـ AppBar في الشاشات الصغيرة (الجوال).
    /// Whether to display the app bar on small screens (mobile).
    this.showAppBarOnSmallScreen = true,
    /// هل يتم عرض الـ AppBar في الشاشات الكبيرة (الكمبيوتر/التابلت).
    /// Whether to display the app bar on large screens (desktop/tablet).
    this.showAppBarOnLargeScreen = false,
    /// إعدادات الـ AppBar للشاشات الصغيرة.
    /// The app bar configuration for small screens.
    this.smallScreenAppBar,
    /// إعدادات الـ AppBar للشاشات الكبيرة.
    /// The app bar configuration for large screens.
    this.largeScreenAppBar,

    // Sidebar header configuration
    /// إعدادات الترويسة (Header) الخاصة بالقائمة الجانبية.
    /// The header configuration for the sidebar.
    this.sidebarHeader,

    // Sidebar styling
    /// لون خلفية القائمة الجانبية.
    /// The background color of the sidebar.
    this.sidebarBackgroundColor,
    /// لون الخلفية للعنصر المحدد (النشط) في القائمة الجانبية.
    /// The background color of the selected (active) item in the sidebar.
    this.sidebarSelectedColor,
    /// لون الخلفية للعنصر عند تمرير الماوس عليه (Hover).
    /// The background color of the item when hovered.
    this.sidebarHoverColor,

    // Text colors
    /// لون النص العادي لعناصر القائمة الجانبية.
    /// The default text color for sidebar items.
    this.sidebarTextColor,
    /// لون النص للعنصر المحدد (النشط).
    /// The text color of the selected (active) item.
    this.sidebarSelectedTextColor,
    /// لون النص للعنصر عند تمرير الماوس عليه.
    /// The text color of the item when hovered.
    this.sidebarHoverTextColor,

    // Icon colors
    /// لون الأيقونات العادية في القائمة الجانبية.
    /// The default icon color for sidebar items.
    this.sidebarIconColor,
    /// لون الأيقونة للعنصر المحدد (النشط).
    /// The icon color of the selected (active) item.
    this.sidebarSelectedIconColor,
    /// لون الأيقونة للعنصر عند تمرير الماوس عليه.
    /// The icon color of the item when hovered.
    this.sidebarHoverIconColor,

    // Expanded colors
    /// لون خلفية القسم المجمع (ExpansionTile) عندما يكون مفتوحاً.
    /// The background color of the grouped section (ExpansionTile) when expanded.
    this.sidebarExpandedBackgroundColor,
    /// لون نص القسم المجمع عندما يكون مفتوحاً.
    /// The text color of the grouped section when expanded.
    this.sidebarExpandedTextColor,
    /// لون أيقونة القسم المجمع عندما يكون مفتوحاً.
    /// The icon color of the grouped section when expanded.
    this.sidebarExpandedIconColor,
    /// لون سهم القسم المجمع عندما يكون مفتوحاً.
    /// The arrow color of the grouped section when expanded.
    this.sidebarExpandedArrowColor,
    /// ارتفاع كل عنصر داخل القائمة الجانبية.
    /// The height of each item inside the sidebar.
    this.sidebarItemHeight,
    /// حجم الخط لعناصر القائمة الجانبية.
    /// The font size for sidebar items.
    this.sidebarFontSize,
    /// نوع الخط المستخدم في القائمة الجانبية.
    /// The font family used in the sidebar.
    this.sidebarFontFamily,

    // Animation properties
    /// مدة حركة الأنيميشن المستخدمة في التبديل وفتح العناصر.
    /// The duration of the animation used for switching and opening items.
    this.animationDuration = const Duration(milliseconds: 300),
    /// نوع المنحنى (Curve) للأنيميشن.
    /// The animation curve used.
    this.animationCurve = Curves.easeOutCubic,
    /// مسافة الانزلاق (Slide Distance) للأنيميشن أثناء الدخول أو الفتح.
    /// The slide distance for the animation upon entry or opening.
    this.animationSlideDistance = 50.0,
    /// نوع الأنيميشن الخاص بدخول عناصر القائمة الجانبية (مثل: SlideAndFade).
    /// The type of animation for sidebar items entering (e.g., SlideAndFade).
    this.animationType = SidBarAnimationType.slideAndFade,
    /// أدوات تتبع التوجيه (Navigator Observers) لرصد التنقل بين الشاشات.
    /// Navigator Observers for monitoring navigation between screens.
    this.navigatorObservers,
    /// مزودات (Providers) أو (Blocs) إضافية تود تهيئتها على مستوى التطبيق بالكامل.
    /// Additional global Providers or Blocs to initialize across the application.
    this.extraProvidersAndBlocs,
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
            fontFamily: sidebarFontFamily,
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
            fontFamily: sidebarFontFamily,
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
        if (extraProvidersAndBlocs != null) ...extraProvidersAndBlocs!,
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
            routerConfig: appShellProvider.createRouter(
              initRouter,
              observers: this.navigatorObservers,
            ),
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
