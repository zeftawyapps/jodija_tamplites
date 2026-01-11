import 'package:flutter/material.dart';

/// أنواع الحركات المتاحة للـ Sidebar
enum SidBarAnimationType {
  /// حركة الانزلاق من الجانب مع التلاشي
  slideAndFade,
  
  /// حركة التكبير (scale) من الصغير للكبير
  scaleUp,
  
  /// حركة التلاشي فقط (fade in)
  fadeOnly,
  
  /// حركة الانزلاق من الأعلى للأسفل
  slideFromTop,
  
  /// حركة الانزلاق من الأسفل للأعلى
  slideFromBottom,
  
  /// حركة التكبير مع التلاشي
  scaleAndFade,
  
  /// حركة دوارة (rotation) مع التكبير
  rotateAndScale,
}

class SideBarNavigationTheames {
  // Properties
  bool isSidebarInCulomn; 
  final Color backgroundColor;
  final Color hoverBackgroundColor;
  final Color selectedBackgroundColor;
  final Color textColor;
  final Color hoverTextColor;
  final Color selectedTextColor;
  final Color iconColor;
  final Color hoverIconColor;
  final Color selectedIconColor;
  
  // Expanded state colors for ExpansionTile
  final Color expandedBackgroundColor;
  final Color expandedTextColor;
  final Color expandedIconColor;
  final Color expandedArrowColor;
  
  final Color selectedBorderColor;
  final double selectedBorderWidth;
  final Duration hoverTransitionDuration;
  final Curve hoverTransitionCurve;
  final double itemHeight;
  final EdgeInsetsGeometry itemPadding;
  final double iconSize;
  final double iconTextSpacing;
  final double fontSize;
  final FontWeight normalFontWeight;
  final FontWeight selectedFontWeight;
  final String? titleApp;
  
  // Animation properties
  final TextDirection layoutDirection;
  final Duration animationDuration;
  final Curve animationCurve;
  final double animationSlideDistance;
  final SidBarAnimationType animationType;

  // Constructor
    SideBarNavigationTheames({
      this.titleApp,
    this.isSidebarInCulomn = false,
    required this.backgroundColor,
    required this.hoverBackgroundColor,
    required this.selectedBackgroundColor,
    required this.textColor,
    required this.hoverTextColor,
    required this.selectedTextColor,
    required this.iconColor,
    required this.hoverIconColor,
    required this.selectedIconColor,
    required this.expandedBackgroundColor,
    required this.expandedTextColor,
    required this.expandedIconColor,
    required this.expandedArrowColor,
    required this.selectedBorderColor,
    this.selectedBorderWidth = 2.0,
    this.hoverTransitionDuration = const Duration(milliseconds: 200),
    this.hoverTransitionCurve = Curves.easeInOut,
    this.itemHeight = 48.0,
    this.itemPadding = const EdgeInsets.symmetric(horizontal: 16.0),
    this.iconSize = 24.0,
    this.iconTextSpacing = 16.0,
    this.fontSize = 14.0,
    this.normalFontWeight = FontWeight.normal,
    this.selectedFontWeight = FontWeight.bold,
    this.layoutDirection = TextDirection.ltr,
    this.animationDuration = const Duration(milliseconds: 300),
    this.animationCurve = Curves.easeOutCubic,
    this.animationSlideDistance = 50.0,
    this.animationType = SidBarAnimationType.slideAndFade,
  });

  // Light Theme (Default)
  factory SideBarNavigationTheames.light({
    String? titleApp,
    bool isSidebarInCulomn = false,
    double? itemHeight,
    double? fontSize,
    EdgeInsetsGeometry? itemPadding,
    Color? backgroundColor,
    Color? hoverBackgroundColor,
    Color? selectedBackgroundColor,
    Color? textColor,
    Color? hoverTextColor,
    Color? selectedTextColor,
    Color? iconColor,
    Color? hoverIconColor,
    Color? selectedIconColor,
    Color? expandedBackgroundColor,
    Color? expandedTextColor,
    Color? expandedIconColor,
    Color? expandedArrowColor,
    TextDirection layoutDirection = TextDirection.ltr,
    Duration animationDuration = const Duration(milliseconds: 300),
    Curve animationCurve = Curves.easeOutCubic,
    double animationSlideDistance = 50.0,
    SidBarAnimationType animationType = SidBarAnimationType.slideAndFade,
  }) {
    return SideBarNavigationTheames(
      titleApp: titleApp,
      isSidebarInCulomn: isSidebarInCulomn,
      backgroundColor: backgroundColor ?? Colors.white,
      hoverBackgroundColor: hoverBackgroundColor ?? Colors.grey.shade100,
      selectedBackgroundColor: selectedBackgroundColor ?? Colors.blue.shade50,
      textColor: textColor ?? Colors.black87,
      hoverTextColor: hoverTextColor ?? Colors.blue.shade700,
      selectedTextColor: selectedTextColor ?? Colors.blue,
      iconColor: iconColor ?? Colors.black54,
      hoverIconColor: hoverIconColor ?? Colors.blue.shade700,
      selectedIconColor: selectedIconColor ?? Colors.blue,
      expandedBackgroundColor: expandedBackgroundColor ?? Colors.blue.shade100,
      expandedTextColor: expandedTextColor ?? Colors.blue.shade800,
      expandedIconColor: expandedIconColor ?? Colors.blue.shade800,
      expandedArrowColor: expandedArrowColor ?? Colors.blue.shade800,
      selectedBorderColor: Colors.blue,
      itemHeight: itemHeight ?? 48.0,
      fontSize: fontSize ?? 14.0,
      itemPadding: itemPadding ?? const EdgeInsets.symmetric(horizontal: 16.0),
      layoutDirection: layoutDirection,
      animationDuration: animationDuration,
      animationCurve: animationCurve,
      animationSlideDistance: animationSlideDistance,
      animationType: animationType,
    );
  }

  // Dark Theme
  factory SideBarNavigationTheames.dark({
    String? titleApp,
    bool isSidebarInCulomn = false,
    double? itemHeight,
    double? fontSize,
    EdgeInsetsGeometry? itemPadding,
    Color? backgroundColor,
    Color? hoverBackgroundColor,
    Color? selectedBackgroundColor,
    Color? textColor,
    Color? hoverTextColor,
    Color? selectedTextColor,
    Color? iconColor,
    Color? hoverIconColor,
    Color? selectedIconColor,
    Color? expandedBackgroundColor,
    Color? expandedTextColor,
    Color? expandedIconColor,
    Color? expandedArrowColor,
    TextDirection layoutDirection = TextDirection.ltr,
    Duration animationDuration = const Duration(milliseconds: 300),
    Curve animationCurve = Curves.easeOutCubic,
    double animationSlideDistance = 50.0,
    SidBarAnimationType animationType = SidBarAnimationType.slideAndFade,
  }) {
    return SideBarNavigationTheames(
      isSidebarInCulomn: isSidebarInCulomn,
      titleApp: titleApp,
      backgroundColor: backgroundColor ?? const Color(0xFF1F1F1F),
      hoverBackgroundColor: hoverBackgroundColor ?? const Color(0xFF2D2D2D),
      selectedBackgroundColor: selectedBackgroundColor ?? Colors.blue.shade900,
      textColor: textColor ?? Colors.white70,
      hoverTextColor: hoverTextColor ?? Colors.white,
      selectedTextColor: selectedTextColor ?? Colors.white,
      iconColor: iconColor ?? Colors.white54,
      hoverIconColor: hoverIconColor ?? Colors.white,
      selectedIconColor: selectedIconColor ?? Colors.white,
      expandedBackgroundColor: expandedBackgroundColor ?? Colors.blue.shade800,
      expandedTextColor: expandedTextColor ?? Colors.white,
      expandedIconColor: expandedIconColor ?? Colors.white,
      expandedArrowColor: expandedArrowColor ?? Colors.white,
      selectedBorderColor: Colors.blue.shade700,
      itemHeight: itemHeight ?? 48.0,
      fontSize: fontSize ?? 14.0,
      itemPadding: itemPadding ?? const EdgeInsets.symmetric(horizontal: 16.0),
      layoutDirection: layoutDirection,
      animationDuration: animationDuration,
      animationCurve: animationCurve,
      animationSlideDistance: animationSlideDistance,
      animationType: animationType,
    );
  }

  // Copy with method for customization
  SideBarNavigationTheames copyWith({
    String? titleApp,
    bool? isSidebarInCulomn,
    Color? backgroundColor,
    Color? hoverBackgroundColor,
    Color? selectedBackgroundColor,
    Color? textColor,
    Color? hoverTextColor,
    Color? selectedTextColor,
    Color? iconColor,
    Color? hoverIconColor,
    Color? selectedIconColor,
    Color? expandedBackgroundColor,
    Color? expandedTextColor,
    Color? expandedIconColor,
    Color? expandedArrowColor,
    Color? selectedBorderColor,
    double? selectedBorderWidth,
    Duration? hoverTransitionDuration,
    Curve? hoverTransitionCurve,
    double? itemHeight,
    EdgeInsetsGeometry? itemPadding,
    double? iconSize,
    double? iconTextSpacing,
    double? fontSize,
    FontWeight? normalFontWeight,
    FontWeight? selectedFontWeight,
    TextDirection? layoutDirection,
    Duration? animationDuration,
    Curve? animationCurve,
    double? animationSlideDistance,
    SidBarAnimationType? animationType,
  }) {
    return SideBarNavigationTheames(
      titleApp: titleApp ?? this.titleApp,
      isSidebarInCulomn: isSidebarInCulomn ?? this.isSidebarInCulomn,
      backgroundColor: backgroundColor ?? this.backgroundColor,
      hoverBackgroundColor: hoverBackgroundColor ?? this.hoverBackgroundColor,
      selectedBackgroundColor: selectedBackgroundColor ?? this.selectedBackgroundColor,
      textColor: textColor ?? this.textColor,
      hoverTextColor: hoverTextColor ?? this.hoverTextColor,
      selectedTextColor: selectedTextColor ?? this.selectedTextColor,
      iconColor: iconColor ?? this.iconColor,
      hoverIconColor: hoverIconColor ?? this.hoverIconColor,
      selectedIconColor: selectedIconColor ?? this.selectedIconColor,
      expandedBackgroundColor: expandedBackgroundColor ?? this.expandedBackgroundColor,
      expandedTextColor: expandedTextColor ?? this.expandedTextColor,
      expandedIconColor: expandedIconColor ?? this.expandedIconColor,
      expandedArrowColor: expandedArrowColor ?? this.expandedArrowColor,
      selectedBorderColor: selectedBorderColor ?? this.selectedBorderColor,
      selectedBorderWidth: selectedBorderWidth ?? this.selectedBorderWidth,
      hoverTransitionDuration: hoverTransitionDuration ?? this.hoverTransitionDuration,
      hoverTransitionCurve: hoverTransitionCurve ?? this.hoverTransitionCurve,
      itemHeight: itemHeight ?? this.itemHeight,
      itemPadding: itemPadding ?? this.itemPadding,
      iconSize: iconSize ?? this.iconSize,
      iconTextSpacing: iconTextSpacing ?? this.iconTextSpacing,
      fontSize: fontSize ?? this.fontSize,
      normalFontWeight: normalFontWeight ?? this.normalFontWeight,
      selectedFontWeight: selectedFontWeight ?? this.selectedFontWeight,
      layoutDirection: layoutDirection ?? this.layoutDirection,
      animationDuration: animationDuration ?? this.animationDuration,
      animationCurve: animationCurve ?? this.animationCurve,
      animationSlideDistance: animationSlideDistance ?? this.animationSlideDistance,
      animationType: animationType ?? this.animationType,
    );
  }

  // Methods to get specific styles

  // Get the container decoration based on item state
  BoxDecoration getItemDecoration({
    bool isHovered = false,
    bool isSelected = false,
  }) {
    return BoxDecoration(
      color: isSelected
          ? selectedBackgroundColor
          : (isHovered ? hoverBackgroundColor : backgroundColor),
      border: isSelected
          ? Border(
              left: BorderSide(
                color: selectedBorderColor,
                width: selectedBorderWidth,
              ),
            )
          : null,
    );
  }

  // Get text style based on item state
  TextStyle getTextStyle({
    bool isHovered = false,
    bool isSelected = false,
  }) {
    return TextStyle(
      fontSize: fontSize,
      fontWeight: isSelected ? selectedFontWeight : normalFontWeight,
      color: isSelected
          ? selectedTextColor
          : (isHovered ? hoverTextColor : textColor),
    );
  }

  // Get icon color based on item state
  Color getIconColor({
    bool isHovered = false,
    bool isSelected = false,
  }) {
    return isSelected
        ? selectedIconColor
        : (isHovered ? hoverIconColor : iconColor);
  }

  /// Get slide offset for animation based on layout direction
  /// Returns positive offset for RTL, negative for LTR
  Offset getAnimationOffset(double factor) {
    final slideAmount = animationSlideDistance * (1 - factor);
    if (layoutDirection == TextDirection.rtl) {
      // From right to left
      return Offset(slideAmount, 0);
    } else {
      // From left to right (default LTR)
      return Offset(-slideAmount, 0);
    }
  }
}
