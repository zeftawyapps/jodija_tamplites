import 'package:flutter/material.dart';

/// Screen breakpoints and responsive utilities
/// 
/// Provides methods to check screen sizes and create responsive values
/// based on Material Design breakpoints:
/// - Mobile: < 600px
/// - Tablet: 600px - 1200px
/// - Desktop: >= 1200px
/// 
/// Example:
/// ```dart
/// if (ScreenUtils.isMobile(context)) {
///   // Show mobile layout
/// } else if (ScreenUtils.isTablet(context)) {
///   // Show tablet layout
/// } else {
///   // Show desktop layout
/// }
/// ```
class ScreenUtils {
  // Breakpoints
  static const double mobileBreakpoint = 600;
  static const double tabletBreakpoint = 900;
  static const double desktopBreakpoint = 1200;
  
  // Default scale factors
  static const double defaultTabletScale = 1.2;
  static const double defaultDesktopScale = 1.4;
  static const double defaultPaddingTabletScale = 1.5;
  static const double defaultPaddingDesktopScale = 2.0;
  
  /// Check if current screen is mobile size (< 600px)
  /// 
  /// Example:
  /// ```dart
  /// if (ScreenUtils.isMobile(context)) {
  ///   return MobileLayout();
  /// }
  /// ```
  static bool isMobile(BuildContext context) {
    return MediaQuery.of(context).size.width < mobileBreakpoint;
  }
  
  /// Check if current screen is tablet size (600px - 1200px)
  /// 
  /// Example:
  /// ```dart
  /// if (ScreenUtils.isTablet(context)) {
  ///   return TabletLayout();
  /// }
  /// ```
  static bool isTablet(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return width >= mobileBreakpoint && width < desktopBreakpoint;
  }
  
  /// Check if current screen is desktop size (>= 1200px)
  /// 
  /// Example:
  /// ```dart
  /// if (ScreenUtils.isDesktop(context)) {
  ///   return DesktopLayout();
  /// }
  /// ```
  static bool isDesktop(BuildContext context) {
    return MediaQuery.of(context).size.width >= desktopBreakpoint;
  }
  
  /// Check if current screen is small (mobile < 900px)
  /// 
  /// Useful for simple two-layout designs (small vs large)
  /// 
  /// Example:
  /// ```dart
  /// return ScreenUtils.isSmallScreen(context)
  ///     ? Column(children: widgets)  // Mobile: vertical layout
  ///     : Row(children: widgets);    // Tablet/Desktop: horizontal layout
  /// ```
  static bool isSmallScreen(BuildContext context) {
    return MediaQuery.of(context).size.width < tabletBreakpoint;
  }
  
  /// Check if current screen is large (tablet or desktop >= 900px)
  /// 
  /// Useful for simple two-layout designs (small vs large)
  /// 
  /// Example:
  /// ```dart
  /// if (ScreenUtils.isLargeScreen(context)) {
  ///   // Show sidebar and content side-by-side
  ///   return Row(children: [Sidebar(), Content()]);
  /// }
  /// ```
  static bool isLargeScreen(BuildContext context) {
    return MediaQuery.of(context).size.width >= tabletBreakpoint;
  }
  
  /// Get screen width
  static double getScreenWidth(BuildContext context) {
    return MediaQuery.of(context).size.width;
  }
  
  /// Get screen height
  static double getScreenHeight(BuildContext context) {
    return MediaQuery.of(context).size.height;
  }
  
  /// Get responsive value based on screen size
  /// 
  /// Returns different values for mobile, tablet, and desktop screens.
  /// If tablet/desktop values are not provided, falls back to mobile value.
  /// 
  /// Example:
  /// ```dart
  /// // Font sizes: 14 on mobile, 16 on tablet, 18 on desktop
  /// final fontSize = ScreenUtils.responsive<double>(
  ///   context: context,
  ///   mobile: 14.0,
  ///   tablet: 16.0,
  ///   desktop: 18.0,
  /// );
  /// 
  /// // Grid columns: 1 on mobile, 2 on tablet, 3 on desktop
  /// final columns = ScreenUtils.responsive<int>(
  ///   context: context,
  ///   mobile: 1,
  ///   tablet: 2,
  ///   desktop: 3,
  /// );
  /// ```
  static T responsive<T>({
    required BuildContext context,
    required T mobile,
    T? tablet,
    T? desktop,
  }) {
    if (isDesktop(context) && desktop != null) {
      return desktop;
    } else if (isTablet(context) && tablet != null) {
      return tablet;
    } else {
      return mobile;
    }
  }
  
  /// Get device orientation
  static Orientation getOrientation(BuildContext context) {
    return MediaQuery.of(context).orientation;
  }
  
  /// Check if device is in landscape mode
  static bool isLandscape(BuildContext context) {
    return getOrientation(context) == Orientation.landscape;
  }
  
  /// Check if device is in portrait mode
  static bool isPortrait(BuildContext context) {
    return getOrientation(context) == Orientation.portrait;
  }
  
  /// Get safe area padding
  static EdgeInsets getSafeAreaPadding(BuildContext context) {
    return MediaQuery.of(context).padding;
  }
  
  /// Get device pixel ratio
  static double getPixelRatio(BuildContext context) {
    return MediaQuery.of(context).devicePixelRatio;
  }
  
  /// Get text scale factor
  static double getTextScaleFactor(BuildContext context) {
    return MediaQuery.of(context).textScaleFactor;
  }
  
  /// Calculate responsive font size with automatic scaling
  /// 
  /// If tablet/desktop sizes are not provided:
  /// - Tablet: mobile * 1.2
  /// - Desktop: mobile * 1.4
  /// 
  /// Example:
  /// ```dart
  /// Text(
  ///   'مرحبا',
  ///   style: TextStyle(
  ///     fontSize: ScreenUtils.responsiveFontSize(
  ///       context,
  ///       mobile: 16,  // 16 on mobile, 19.2 on tablet, 22.4 on desktop
  ///     ),
  ///   ),
  /// )
  /// 
  /// // Or specify custom values
  /// Text(
  ///   'عنوان',
  ///   style: TextStyle(
  ///     fontSize: ScreenUtils.responsiveFontSize(
  ///       context,
  ///       mobile: 24,
  ///       tablet: 28,
  ///       desktop: 32,
  ///     ),
  ///   ),
  /// )
  /// ```
  static double responsiveFontSize(BuildContext context, {
    required double mobile,
    double? tablet,
    double? desktop,
  }) {
    return responsive(
      context: context,
      mobile: mobile,
      tablet: tablet ?? mobile * 1.2,
      desktop: desktop ?? mobile * 1.4,
    );
  }
  
  /// Calculate responsive padding
  static EdgeInsets responsivePadding(BuildContext context, {
    required EdgeInsets mobile,
    EdgeInsets? tablet,
    EdgeInsets? desktop,
  }) {
    return responsive(
      context: context,
      mobile: mobile,
      tablet: tablet ?? mobile * 1.5,
      desktop: desktop ?? mobile * 2.0,
    );
  }
  
  /// Get sidebar width based on screen size
  static double getSidebarWidth(BuildContext context, {
    double mobileWidth = 280,
    double tabletWidth = 300,
    double desktopWidth = 320,
  }) {
    return responsive(
      context: context,
      mobile: mobileWidth,
      tablet: tabletWidth,
      desktop: desktopWidth,
    );
  }
  
  /// Check if keyboard is visible
  static bool isKeyboardVisible(BuildContext context) {
    return MediaQuery.of(context).viewInsets.bottom > 0;
  }
  
  /// Get available height (excluding keyboard)
  static double getAvailableHeight(BuildContext context) {
    return MediaQuery.of(context).size.height - 
           MediaQuery.of(context).viewInsets.bottom;
  }
}

/// Extension on num (double & int) for responsive sizing
/// 
/// Provides easy-to-use extensions for creating responsive values.
/// All extensions work with both int and double.
/// 
/// Naming convention:
/// - `m` prefix = Mobile base (scales: 1x, 1.2x, 1.4x)
/// - `t` prefix = Tablet base
/// - `d` prefix = Desktop base
/// - `h` suffix = Height
/// - `w` suffix = Width
/// - `fs` suffix = Font Size
/// - `p` suffix = Padding
/// - `r` suffix = Radius
extension ResponsiveNumExtension on num {
  /// Mobile height - scales based on screen size
  /// 
  /// Scales: mobile (1x), tablet (1.2x default), desktop (1.4x default)
  /// 
  /// You can customize the scale factors:
  /// ```dart
  /// Container(
  ///   height: 100.mh(context),  // Uses default: 100, 120, 140
  ///   child: Text('Content'),
  /// )
  /// 
  /// // Custom scales
  /// Container(
  ///   height: 100.mh(context, tabletScale: 1.5, desktopScale: 2.0),  // 100, 150, 200
  /// )
  /// ```
  double mh(BuildContext context, {
    double? tabletScale,
    double? desktopScale,
  }) {
    return ScreenUtils.responsive<double>(
      context: context,
      mobile: toDouble(),
      tablet: toDouble() * (tabletScale ?? ScreenUtils.defaultTabletScale),
      desktop: toDouble() * (desktopScale ?? ScreenUtils.defaultDesktopScale),
    );
  }
  
  /// Mobile width - scales based on screen size
  /// 
  /// Scales: mobile (1x), tablet (1.2x default), desktop (1.4x default)
  /// 
  /// You can customize the scale factors:
  /// ```dart
  /// Container(
  ///   width: 200.mw(context),  // Uses default: 200, 240, 280
  ///   child: Image.asset('logo.png'),
  /// )
  /// 
  /// // Custom scales
  /// Container(
  ///   width: 200.mw(context, tabletScale: 1.3, desktopScale: 1.6),  // 200, 260, 320
  /// )
  /// ```
  double mw(BuildContext context, {
    double? tabletScale,
    double? desktopScale,
  }) {
    return ScreenUtils.responsive<double>(
      context: context,
      mobile: toDouble(),
      tablet: toDouble() * (tabletScale ?? ScreenUtils.defaultTabletScale),
      desktop: toDouble() * (desktopScale ?? ScreenUtils.defaultDesktopScale),
    );
  }
  
  /// Mobile font size - scales based on screen size
  /// 
  /// Scales: mobile (1x), tablet (1.2x default), desktop (1.4x default)
  /// 
  /// You can customize the scale factors:
  /// ```dart
  /// Text(
  ///   'مرحبا بك',
  ///   style: TextStyle(
  ///     fontSize: 16.mfs(context),  // Uses default: 16, 19.2, 22.4
  ///   ),
  /// )
  /// 
  /// // Custom scales
  /// Text(
  ///   'عنوان',
  ///   style: TextStyle(
  ///     fontSize: 24.mfs(context, tabletScale: 1.3, desktopScale: 1.5),  // 24, 31.2, 36
  ///   ),
  /// )
  /// ```
  double mfs(BuildContext context, {
    double? tabletScale,
    double? desktopScale,
  }) {
    return ScreenUtils.responsive<double>(
      context: context,
      mobile: toDouble(),
      tablet: toDouble() * (tabletScale ?? ScreenUtils.defaultTabletScale),
      desktop: toDouble() * (desktopScale ?? ScreenUtils.defaultDesktopScale),
    );
  }
  
  /// Mobile padding - scales based on screen size
  /// 
  /// Scales: mobile (1x), tablet (1.5x default), desktop (2x default)
  /// Note: Padding scales more aggressively than width/height
  /// 
  /// You can customize the scale factors:
  /// ```dart
  /// Container(
  ///   padding: EdgeInsets.all(16.mp(context)),  // Uses default: 16, 24, 32
  ///   child: Text('Content'),
  /// )
  /// 
  /// // Custom scales
  /// Container(
  ///   padding: EdgeInsets.all(16.mp(context, tabletScale: 1.3, desktopScale: 1.6)),  // 16, 20.8, 25.6
  /// )
  /// ```
  double mp(BuildContext context, {
    double? tabletScale,
    double? desktopScale,
  }) {
    return ScreenUtils.responsive<double>(
      context: context,
      mobile: toDouble(),
      tablet: toDouble() * (tabletScale ?? ScreenUtils.defaultPaddingTabletScale),
      desktop: toDouble() * (desktopScale ?? ScreenUtils.defaultPaddingDesktopScale),
    );
  }
  
  /// Mobile radius - scales based on screen size
  /// 
  /// Scales: mobile (1x), tablet (1.2x default), desktop (1.4x default)
  /// 
  /// You can customize the scale factors:
  /// ```dart
  /// Container(
  ///   decoration: BoxDecoration(
  ///     borderRadius: BorderRadius.circular(12.mr(context)),  // Uses default: 12, 14.4, 16.8
  ///     color: Colors.blue,
  ///   ),
  /// )
  /// 
  /// // Custom scales
  /// Container(
  ///   decoration: BoxDecoration(
  ///     borderRadius: BorderRadius.circular(12.mr(context, tabletScale: 1.5, desktopScale: 2.0)),  // 12, 18, 24
  ///   ),
  /// )
  /// ```
  double mr(BuildContext context, {
    double? tabletScale,
    double? desktopScale,
  }) {
    return ScreenUtils.responsive<double>(
      context: context,
      mobile: toDouble(),
      tablet: toDouble() * (tabletScale ?? ScreenUtils.defaultTabletScale),
      desktop: toDouble() * (desktopScale ?? ScreenUtils.defaultDesktopScale),
    );
  }
  
  /// Tablet height - uses tablet as base
  /// 
  /// Scales: mobile (÷1.2), tablet (1x), desktop (×1.167)
  /// Use when designing primarily for tablet screens
  /// 
  /// Example:
  /// ```dart
  /// Container(
  ///   height: 60.th(context),  // 50 mobile, 60 tablet, 70 desktop
  ///   child: AppBar(...),
  /// )
  /// ```
  double th(BuildContext context) {
    return ScreenUtils.responsive<double>(
      context: context,
      mobile: toDouble() / 1.2,
      tablet: toDouble(),
      desktop: toDouble() * 1.167,
    );
  }
  
  /// Tablet width - uses tablet as base
  /// 
  /// Scales: mobile (÷1.2), tablet (1x), desktop (×1.167)
  /// Use when designing primarily for tablet screens
  /// 
  /// Example:
  /// ```dart
  /// Container(
  ///   width: 300.tw(context),  // 250 mobile, 300 tablet, 350 desktop
  ///   child: Card(...),
  /// )
  /// ```
  double tw(BuildContext context) {
    return ScreenUtils.responsive<double>(
      context: context,
      mobile: toDouble() / 1.2,
      tablet: toDouble(),
      desktop: toDouble() * 1.167,
    );
  }
  
  /// Desktop height - uses desktop as base
  /// 
  /// Scales: mobile (÷1.4), tablet (÷1.167), desktop (1x)
  /// Use when designing primarily for desktop screens
  /// 
  /// Example:
  /// ```dart
  /// Container(
  ///   height: 80.dh(context),  // 57.14 mobile, 68.57 tablet, 80 desktop
  ///   child: Header(...),
  /// )
  /// ```
  double dh(BuildContext context) {
    return ScreenUtils.responsive<double>(
      context: context,
      mobile: toDouble() / 1.4,
      tablet: toDouble() / 1.167,
      desktop: toDouble(),
    );
  }
  
  /// Desktop width - uses desktop as base
  /// 
  /// Scales: mobile (÷1.4), tablet (÷1.167), desktop (1x)
  /// Use when designing primarily for desktop screens
  /// 
  /// Example:
  /// ```dart
  /// Container(
  ///   width: 400.dw(context),  // 285.71 mobile, 342.86 tablet, 400 desktop
  ///   child: DataTable(...),
  /// )
  /// ```
  double dw(BuildContext context) {
    return ScreenUtils.responsive<double>(
      context: context,
      mobile: toDouble() / 1.4,
      tablet: toDouble() / 1.167,
      desktop: toDouble(),
    );
  }
}

/// Extension on num for creating EdgeInsets with responsive padding
/// 
/// Provides convenient methods to create EdgeInsets with
/// responsive values based on screen size.
extension ResponsiveEdgeInsetsExtension on num {
  /// Create EdgeInsets.all with responsive value
  /// 
  /// Scales: mobile (1x), tablet (1.5x default), desktop (2x default)
  /// 
  /// Example:
  /// ```dart
  /// Container(
  ///   padding: 16.mpAll(context),  // Uses default: EdgeInsets.all(16/24/32)
  ///   child: Card(...),
  /// )
  /// 
  /// // Custom scales
  /// Container(
  ///   padding: 16.mpAll(context, tabletScale: 1.3, desktopScale: 1.6),  // EdgeInsets.all(16/20.8/25.6)
  /// )
  /// ```
  EdgeInsets mpAll(BuildContext context, {
    double? tabletScale,
    double? desktopScale,
  }) {
    return EdgeInsets.all(mp(context, tabletScale: tabletScale, desktopScale: desktopScale));
  }
  
  /// Create horizontal EdgeInsets with responsive value
  /// 
  /// Example:
  /// ```dart
  /// Container(
  ///   padding: 20.mpH(context),  // Uses default: EdgeInsets.symmetric(horizontal: 20/30/40)
  ///   child: Row(...),
  /// )
  /// 
  /// // Custom scales
  /// Container(
  ///   padding: 20.mpH(context, tabletScale: 1.2, desktopScale: 1.5),  // horizontal: 20/24/30
  /// )
  /// ```
  EdgeInsets mpH(BuildContext context, {
    double? tabletScale,
    double? desktopScale,
  }) {
    return EdgeInsets.symmetric(horizontal: mp(context, tabletScale: tabletScale, desktopScale: desktopScale));
  }
  
  /// Create vertical EdgeInsets with responsive value
  /// 
  /// Example:
  /// ```dart
  /// Container(
  ///   padding: 12.mpV(context),  // Uses default: EdgeInsets.symmetric(vertical: 12/18/24)
  ///   child: Column(...),
  /// )
  /// 
  /// // Custom scales
  /// Container(
  ///   padding: 12.mpV(context, tabletScale: 1.2, desktopScale: 1.5),  // vertical: 12/14.4/18
  /// )
  /// ```
  EdgeInsets mpV(BuildContext context, {
    double? tabletScale,
    double? desktopScale,
  }) {
    return EdgeInsets.symmetric(vertical: mp(context, tabletScale: tabletScale, desktopScale: desktopScale));
  }
}

/// Extension on num for creating SizedBox spacing
/// 
/// Provides convenient methods to create spacing between widgets
/// with responsive values.
extension ResponsiveSizedBoxExtension on num {
  /// Create vertical space with responsive height
  /// 
  /// Scales: mobile (1x), tablet (1.2x default), desktop (1.4x default)
  /// 
  /// Example:
  /// ```dart
  /// Column(
  ///   children: [
  ///     Text('العنوان'),
  ///     16.vSpace(context),  // Uses default: SizedBox(height: 16/19.2/22.4)
  ///     Text('المحتوى'),
  ///     24.vSpace(context, tabletScale: 1.5, desktopScale: 2.0),  // Custom: 24/36/48
  ///     ElevatedButton(...),
  ///   ],
  /// )
  /// ```
  SizedBox vSpace(BuildContext context, {
    double? tabletScale,
    double? desktopScale,
  }) {
    return SizedBox(height: mh(context, tabletScale: tabletScale, desktopScale: desktopScale));
  }
  
  /// Create horizontal space with responsive width
  /// 
  /// Scales: mobile (1x), tablet (1.2x default), desktop (1.4x default)
  /// 
  /// Example:
  /// ```dart
  /// Row(
  ///   children: [
  ///     Icon(Icons.home),
  ///     8.hSpace(context),   // Uses default: SizedBox(width: 8/9.6/11.2)
  ///     Text('الرئيسية'),
  ///     16.hSpace(context, tabletScale: 1.5, desktopScale: 2.0),  // Custom: 16/24/32
  ///     Icon(Icons.settings),
  ///   ],
  /// )
  /// ```
  SizedBox hSpace(BuildContext context, {
    double? tabletScale,
    double? desktopScale,
  }) {
    return SizedBox(width: mw(context, tabletScale: tabletScale, desktopScale: desktopScale));
  }
}
